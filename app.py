import os
import pymysql
import pymysql.cursors

from flask import Flask, render_template, request
from werkzeug.security import generate_password_hash

app = Flask(__name__)


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
        cursorclass=pymysql.cursors.DictCursor
    )


# ==========================================
# PÁGINA INICIAL DA LOJA
# ==========================================

@app.route("/")
def inicio():
    return render_template("index.html")


# ==========================================
# FORMULÁRIO DE CADASTRO
# ==========================================

@app.route("/cadastro")
def cadastro():
    sucesso = request.args.get("sucesso")
    return render_template(
        "forms.html",
        erro=None,
        sucesso=sucesso,
        valores={}
    )


# ==========================================
# SALVAR CADASTRO
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

    # Validações básicas
    if not nome or not email or not telefone or not senha:
        return render_template(
            "forms.html",
            erro="Preencha todos os campos obrigatórios (inclusive a senha).",
            valores=valores
        ), 400

    if "@" not in email:
        return render_template(
            "forms.html",
            erro="Confira o formato do e-mail digitado.",
            valores=valores
        ), 400

    conexao = None
    cursor = None

    try:
        conexao = conectar_mysql()
        cursor = conexao.cursor()

        # 1. Inserção do usuário
        sql_usuario = "INSERT INTO usuario (nome, email, senha) VALUES (%s, %s, %s)"
        senha_hash = generate_password_hash(senha)
        cursor.execute(sql_usuario, (nome, email, senha_hash))
        id_usuario_gerado = cursor.lastrowid

        # 2. Inserção do telefone
        sql_telefone = "INSERT INTO telefone (id_usuario, numero, tipo) VALUES (%s, %s, %s)"
        cursor.execute(sql_telefone, (id_usuario_gerado, telefone, "Celular"))

        conexao.commit()

        return render_template(
            "forms.html",
            erro=None,
            sucesso="Cadastro realizado com sucesso!",
            valores={}
        )

    except pymysql.MySQLError as erro:
        if conexao:
            conexao.rollback()

        # E-mail duplicado
        if len(erro.args) > 0 and erro.args[0] == 1062:
            return render_template(
                "forms.html",
                erro="Este e-mail já está cadastrado no sistema.",
                valores=valores
            ), 400

        return render_template(
            "forms.html",
            erro=f"Erro no banco de dados: {erro}",
            valores=valores
        ), 500

    finally:
        if cursor:
            cursor.close()
        if conexao:
            conexao.close()


# ==========================================
# PÁGINA SEPARADA DE USUÁRIOS
# ==========================================

@app.route("/usuarios")
def listar_usuarios():
    conexao = None
    cursor = None
    todos_usuarios = []

    try:
        conexao = conectar_mysql()
        cursor = conexao.cursor()
        query = """
            SELECT 
                u.id_usuario, 
                u.nome, 
                u.email, 
                t.numero
            FROM usuario u 
            LEFT JOIN telefone t 
                ON u.id_usuario = t.id_usuario 
            ORDER BY u.id_usuario DESC
        """
        cursor.execute(query)
        todos_usuarios = cursor.fetchall()
    except pymysql.MySQLError as erro:
        print(f"Erro ao consultar usuários: {erro}")
    finally:
        if cursor:
            cursor.close()
        if conexao:
            conexao.close()

    return render_template("usuarios.html", usuarios=todos_usuarios)


if __name__ == "__main__":
    app.run(debug=True)