import os
import pymysql
import pymysql.cursors
from flask import Flask, render_template, request, redirect, url_for, session
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

# Configuração da chave secreta obrigatória para gerenciar sessões (login)
app.secret_key = os.getenv("SECRET_KEY", "chave_secreta_lumina_2026")


# ==========================================
# CONEXÃO COM O BANCO DE DADOS
# ==========================================

def conectar_mysql():
    return pymysql.connect(
        host=os.getenv("MYSQL_HOST", "127.0.0.1"),
        user=os.getenv("MYSQL_USER", "root"),
        password=os.getenv("MYSQL_PASSWORD", "senai105"),
        database="lumina_formulario",
        autocommit=False,
        connect_timeout=3,  # Impede travamento do terminal caso o MySQL esteja desligado
        cursorclass=pymysql.cursors.DictCursor
    )


# ==========================================
# PÁGINA INICIAL
# ==========================================

@app.route("/")
def inicio():
    return render_template("index.html")


# ==========================================
# PÁGINA DE PRODUTOS (CATÁLOGO)
# ==========================================

@app.route("/produtos")
def produtos_pagina():
    return render_template("produtos.html")


# ==========================================
# PÁGINA DE CADASTRO
# ==========================================

@app.route("/cadastro")
def cadastro():
    return render_template(
        "forms.html",
        erro=None,
        sucesso=request.args.get("sucesso"),
        valores={}
    )


# ==========================================
# SALVAR CADASTRO (COM LOGIN AUTOMÁTICO)
# ==========================================

@app.route("/salvar", methods=["POST"])
def salvar():
    nome = request.form.get("nome", "").strip()
    email = request.form.get("email", "").strip()
    telefone = request.form.get("telefone", "").strip()
    senha = request.form.get("senha", "").strip()

    valores = {
        "nome": nome,
        "email": email,
        "telefone": telefone
    }

    if not nome or not email or not telefone or not senha:
        return render_template(
            "forms.html",
            erro="Preencha todos os campos obrigatórios.",
            sucesso=None,
            valores=valores
        ), 400

    if "@" not in email:
        return render_template(
            "forms.html",
            erro="Confira o formato do e-mail digitado.",
            sucesso=None,
            valores=valores
        ), 400

    conexao = None

    try:
        conexao = conectar_mysql()

        with conexao.cursor() as cursor:
            sql_usuario = """
                INSERT INTO usuario (nome, email, senha)
                VALUES (%s, %s, %s)
            """

            senha_hash = generate_password_hash(senha)

            cursor.execute(
                sql_usuario,
                (nome, email, senha_hash)
            )

            id_usuario = cursor.lastrowid

            sql_telefone = """
                INSERT INTO telefone (id_usuario, numero, tipo)
                VALUES (%s, %s, %s)
            """

            cursor.execute(
                sql_telefone,
                (id_usuario, telefone, "Celular")
            )

        conexao.commit()

        # Guarda os dados na sessão
        session["usuario_id"] = id_usuario
        session["usuario_nome"] = nome
        session["usuario_email"] = email

        return redirect(url_for("perfil"))

    except pymysql.MySQLError as erro:
        if conexao:
            conexao.rollback()

        print(f"Erro ao salvar cadastro: {erro}")

        if erro.args and erro.args[0] == 1062:
            mensagem = "Este e-mail já está cadastrado no sistema."
        else:
            mensagem = "Não foi possível realizar o cadastro. Verifique a conexão com o banco de dados."

        return render_template(
            "forms.html",
            erro=mensagem,
            sucesso=None,
            valores=valores
        ), 400

    finally:
        if conexao:
            conexao.close()


# ==========================================
# PÁGINA DE LOGIN
# ==========================================

@app.route("/login")
def login():
    if "usuario_id" in session:
        return redirect(url_for("perfil"))

    return render_template(
        "login.html",
        erro=None,
        sucesso=request.args.get("sucesso"),
        email_digitado=""
    )


# ==========================================
# AUTENTICAR LOGIN
# ==========================================

@app.route("/autenticar", methods=["POST"])
def autenticar():
    email = request.form.get("email", "").strip()
    senha = request.form.get("senha", "").strip()

    if not email or not senha:
        return render_template(
            "login.html",
            erro="Preencha o e-mail e a senha.",
            email_digitado=email
        ), 400

    conexao = None

    try:
        conexao = conectar_mysql()

        with conexao.cursor() as cursor:
            sql = "SELECT id_usuario, nome, email, senha FROM usuario WHERE email = %s"
            cursor.execute(sql, (email,))
            usuario = cursor.fetchone()

            if usuario and check_password_hash(usuario["senha"], senha):
                session["usuario_id"] = usuario["id_usuario"]
                session["usuario_nome"] = usuario["nome"]
                session["usuario_email"] = usuario["email"]

                return redirect(url_for("perfil"))
            else:
                return render_template(
                    "login.html",
                    erro="E-mail ou senha incorretos.",
                    email_digitado=email
                ), 401

    except pymysql.MySQLError as erro:
        print(f"Erro ao autenticar usuário: {erro}")
        return render_template(
            "login.html",
            erro="Não foi possível conectar ao banco de dados. Verifique se o MySQL está rodando.",
            email_digitado=email
        ), 500

    finally:
        if conexao:
            conexao.close()


# ==========================================
# PÁGINA DE PERFIL
# ==========================================

@app.route("/perfil")
def perfil():
    if "usuario_id" not in session:
        return redirect(url_for("login"))

    conexao = None
    usuario = None

    try:
        conexao = conectar_mysql()

        with conexao.cursor() as cursor:
            sql = """
                SELECT u.id_usuario, u.nome, u.email, t.numero AS telefone
                FROM usuario AS u
                LEFT JOIN telefone AS t ON u.id_usuario = t.id_usuario
                WHERE u.id_usuario = %s
            """
            cursor.execute(sql, (session["usuario_id"],))
            usuario = cursor.fetchone()

    except pymysql.MySQLError as erro:
        print(f"Erro ao carregar perfil: {erro}")

    finally:
        if conexao:
            conexao.close()

    return render_template("perfil.html", usuario=usuario)


# ==========================================
# LOGOUT (SAIR DA CONTA)
# ==========================================

@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))


# ==========================================
# CONSULTAR USUÁRIOS
# ==========================================

@app.route("/usuarios")
def listar_usuarios():
    conexao = None

    try:
        conexao = conectar_mysql()

        with conexao.cursor() as cursor:
            sql = """
                SELECT
                    u.id_usuario,
                    u.nome,
                    u.email,
                    t.numero
                FROM usuario AS u
                LEFT JOIN telefone AS t
                    ON u.id_usuario = t.id_usuario
                ORDER BY u.id_usuario DESC
            """

            cursor.execute(sql)
            usuarios = cursor.fetchall()

        return render_template(
            "usuarios.html",
            usuarios=usuarios
        )

    except pymysql.MySQLError as erro:
        print(f"Erro ao consultar usuários: {erro}")
        return "Erro ao consultar usuários no banco de dados.", 500

    finally:
        if conexao:
            conexao.close()


# ==========================================
# CONSULTAR PEDIDOS
# ==========================================

@app.route("/consultar-pedidos")
def consultar_pedidos():
    conexao = None

    try:
        conexao = conectar_mysql()

        with conexao.cursor() as cursor:
            sql = """
                SELECT
                    p.pedido_id AS id_pedido,
                    c.nome AS nome_cliente,
                    p.data_pedido,
                    p.endereco_entrega,
                    p.total_pedido AS valor_total
                FROM pedidos AS p
                INNER JOIN clientes AS c
                    ON p.cliente_id = c.cliente_id
                ORDER BY p.data_pedido DESC
            """

            cursor.execute(sql)
            pedidos = cursor.fetchall()

        return render_template(
            "consultar_pedidos.html",
            pedidos=pedidos,
            erro=None
        )

    except pymysql.MySQLError as erro:
        print(f"Erro ao consultar pedidos: {erro}")

        return render_template(
            "consultar_pedidos.html",
            pedidos=[],
            erro="Não foi possível consultar os pedidos. Verifique o banco de dados."
        ), 500

    finally:
        if conexao:
            conexao.close()


# ==========================================
# CARRINHO DE COMPRAS
# ==========================================

@app.route("/carrinho")
def carrinho():
    return render_template("carrinho.html", produtos=[])


# ==========================================
# PÁGINA DE CONTATO
# ==========================================

@app.route("/contato", methods=["GET", "POST"])
def contato():
    if request.method == "POST":
        nome = request.form.get("nome", "").strip()
        email = request.form.get("email", "").strip()
        assunto = request.form.get("assunto", "").strip()
        mensagem = request.form.get("mensagem", "").strip()

        if not nome or not email or not assunto or not mensagem:
            return render_template(
                "contato.html",
                erro="Preencha todos os campos obrigatórios."
            ), 400

        return render_template(
            "contato.html",
            sucesso="Mensagem enviada com sucesso!"
        )

    return render_template(
        "contato.html",
        erro=None,
        sucesso=None
    )


# ==========================================
# EXECUTAR A APLICAÇÃO
# ==========================================

if __name__ == "__main__":
    app.run(debug=True)