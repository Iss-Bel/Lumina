import os
import pymysql
from flask import Flask, render_template, request

app = Flask(__name__)

# Função de conexão para o banco de dados Lumina
def conectar_mysql():

    return pymysql.connect(
        host=os.getenv("MYSQL_HOST", "127.0.0.1"),
        user=os.getenv("MYSQL_USER", "root"),
        password=os.getenv("MYSQL_PASSWORD", "senai105"),
        database="lumina_formulario",
        autocommit=False
    )

# Página inicial
@app.route("/")
def index():

    return render_template(
        "forms.html",
        erro=None,
        valores={}
    )

# Salvar cadastro
@app.route("/salvar", methods=["GET", "POST"])
def salvar():

    if request.method == "GET":

        return render_template(
            "forms.html",
            erro=None,
            valores={}
        )

    # Captura os dados enviados pelo HTML
    nome = request.form.get("nome", "").strip()
    email = request.form.get("email", "").strip()
    telefone = request.form.get("telefone", "").strip()
    senha = request.form.get("senha", "").strip()

    valores = {
        "nome": nome,
        "email": email,
        "telefone": telefone
    }

    # Validações básicas de backend
    if not nome or not email or not telefone or not senha:

        return render_template(
            "forms.html",
            erro="Preencha todos os campos obrigatórios (inclusive senha).",
            valores=valores
        ), 400

    if "@" not in email:

        return render_template(
            "forms.html",
            erro="Confira o formato do email.",
            valores=valores
        ), 400

    conexao = None
    cursor = None

    try:

        conexao = conectar_mysql()
        cursor = conexao.cursor()

        # Passo 1:
        # Insere os dados na tabela usuario
        sql_usuario = """
            INSERT INTO usuario (nome, email, senha)
            VALUES (%s, %s, %s)
        """

        cursor.execute(
            sql_usuario,
            (nome, email, senha)
        )

        # Recupera o id_usuario gerado pelo AUTO_INCREMENT
        id_usuario_gerado = cursor.lastrowid

        # Passo 2:
        # Insere o telefone vinculado ao usuário
        sql_telefone = """
            INSERT INTO telefone (id_usuario, numero, tipo)
            VALUES (%s, %s, %s)
        """

        cursor.execute(
            sql_telefone,
            (
                id_usuario_gerado,
                telefone,
                "Celular"
            )
        )

        # Confirma e salva as duas inserções juntas
        conexao.commit()

        return """
            Cadastro Lumina realizado com sucesso!
            <br><br>
            <a href="/usuarios">
                Ver lista de usuários
            </a>
        """

    except pymysql.MySQLError as erro:

        # Se algo falhar, desfaz a transação
        if conexao:
            conexao.rollback()

        # Erro 1062 = e-mail duplicado
        if len(erro.args) > 0 and erro.args[0] == 1062:

            return render_template(
                "forms.html",
                erro="Este e-mail já está cadastrado no sistema.",
                valores=valores
            ), 400

        # Outros erros do banco
        return render_template(
            "forms.html",
            erro=f"Erro no banco de dados: {erro}",
            valores=valores
        ), 500

    finally:

        # Fecha o cursor
        if cursor:
            cursor.close()

        # Fecha a conexão
        if conexao:
            conexao.close()


# Listar usuários
@app.route("/usuarios")
def listar_usuarios():

    conexao = None
    cursor = None

    try:

        conexao = conectar_mysql()
        cursor = conexao.cursor()

        # Busca os usuários junto com seus telefones
        query = """
            SELECT
                u.id_usuario,
                u.nome,
                u.email,
                t.numero,
                u.data_cadastro
            FROM usuario u
            LEFT JOIN telefone t
                ON u.id_usuario = t.id_usuario
        """

        cursor.execute(query)

        todos_usuarios = cursor.fetchall()

        # Envia os dados para o arquivo usuarios.html
        return render_template(
            "usuarios.html",
            usuarios=todos_usuarios
        )

    except pymysql.MySQLError as erro:

        return f"Erro ao consultar a lista: {erro}", 500

    finally:

        # Fecha o cursor
        if cursor:
            cursor.close()

        # Fecha a conexão
        if conexao:
            conexao.close()


# Inicia o servidor
if __name__ == "__main__":
    app.run(debug=True)