import os
import pymysql
import pymysql.cursors
from flask import Flask, render_template, request, redirect, url_for, session
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

# Configuração da chave secreta para manter a sessão no navegador
app.secret_key = os.getenv("SECRET_KEY", "chave_secreta_lumina_2026")


# ==========================================
# CONFIGURAÇÕES E DADOS DO PROVADOR VIRTUAL
# ==========================================

TONS_PELE = [
    "#e8c6a5", "#c99570", "#986747", "#593a2c", "#30221d"
]

TABELA_MEDIDAS = {
    "PP":  {"busto": (70, 80),  "cintura": (50, 62), "quadril": (80, 90)},
    "P":   {"busto": (81, 88),  "cintura": (63, 70), "quadril": (91, 98)},
    "M":   {"busto": (89, 96),  "cintura": (71, 78), "quadril": (99, 106)},
    "G":   {"busto": (97, 104), "cintura": (79, 86), "quadril": (107, 114)},
    "GG":  {"busto": (105, 115), "cintura": (87, 96), "quadril": (115, 125)},
    "XGG": {"busto": (116, 140), "cintura": (97, 130), "quadril": (126, 150)}
}

CAMPOS_PROVADOR = {
    "altura": (140, 210),
    "peso": (2, 120),
    "idade": (13, 90),
    "busto": (65, 140),
    "cintura": (50, 130),
    "quadril": (70, 150)
}


def limitar(valor, minimo, maximo):
    return max(minimo, min(valor, maximo))


def analisar_caimento(medidas):
    tamanhos_chaves = list(TABELA_MEDIDAS.keys())
    indices = []

    for parte, valor in medidas.items():
        melhor_distancia = float("inf")
        melhor_index = 2  # Padrão M

        for idx, (tamanho, faixas) in enumerate(TABELA_MEDIDAS.items()):
            minimo, maximo = faixas[parte]
            if minimo <= valor <= maximo:
                melhor_index = idx
                break
            else:
                centro = (minimo + maximo) / 2
                distancia = abs(valor - centro)
                if distancia < melhor_distancia:
                    melhor_distancia = distancia
                    melhor_index = idx

        indices.append(melhor_index)

    media_index = round(sum(indices) / len(indices))
    tamanho_sugerido = tamanhos_chaves[media_index]

    faixas_sugeridas = TABELA_MEDIDAS[tamanho_sugerido]
    detalhes = []
    status_linhas = {}

    for parte, valor in medidas.items():
        minimo, maximo = faixas_sugeridas[parte]
        
        if valor < minimo:
            detalhes.append((parte.capitalize(), "um pouco folgado/largo"))
            status_linhas[parte] = "folgado"
        elif valor > maximo:
            detalhes.append((parte.capitalize(), "mais justo/apertado"))
            status_linhas[parte] = "justo"
        else:
            detalhes.append((parte.capitalize(), "ideal"))
            status_linhas[parte] = "ideal"

    return tamanho_sugerido, detalhes, status_linhas


# ==========================================
# CONEXÃO COM O BANCO DE DADOS
# ==========================================

def conectar_mysql():
    try:
        return pymysql.connect(
            host=os.getenv("MYSQL_HOST", "127.0.0.1"),
            user=os.getenv("MYSQL_USER", "root"),
            password=os.getenv("MYSQL_PASSWORD", "senai105"),
            database="lumina_formulario",
            autocommit=False,
            connect_timeout=3,
            cursorclass=pymysql.cursors.DictCursor
        )
    except pymysql.MySQLError as erro_conexao:
        print(f"Erro de conexão ao MySQL: {erro_conexao}")
        return None


# ==========================================
# PÁGINA INICIAL DA LOJA
# ==========================================

@app.route("/")
def inicio():
    return render_template("index.html")


# ==========================================
# PÁGINA EXCLUSIVA DO PROVADOR VIRTUAL
# ==========================================

@app.route("/provador", methods=["GET", "POST"])
def provador():
    dados = {
        "altura": 165,
        "peso": 60,
        "idade": 25,
        "busto": 88,
        "cintura": 70,
        "quadril": 96
    }

    pele = TONS_PELE[0]
    tamanho = None
    detalhes_caimento = []
    status_linhas = {"busto": "ideal", "cintura": "ideal", "quadril": "ideal"}
    mensagem = "Preencha suas medidas para descobrir seu tamanho."

    if request.method == "POST":
        for campo, (minimo, maximo) in CAMPOS_PROVADOR.items():
            try:
                valor = int(request.form.get(campo, dados[campo]))
                dados[campo] = limitar(valor, minimo, maximo)
            except (ValueError, TypeError):
                pass

        cores_enviadas = request.form.getlist("pele")
        if cores_enviadas:
            cor_selecionada = cores_enviadas[-1]
            if cor_selecionada in TONS_PELE:
                pele = cor_selecionada

        medidas = {
            "busto": dados["busto"],
            "cintura": dados["cintura"],
            "quadril": dados["quadril"]
        }

        tamanho, detalhes_caimento, status_linhas = analisar_caimento(medidas)
        mensagem = f"Recomendamos o tamanho {tamanho}. Veja os detalhes do caimento no seu corpo:"

    busto_visual = limitar(30 + (dados["busto"] - 65) * 60 / (140 - 65), 30, 90)
    cintura_visual = limitar(20 + (dados["cintura"] - 50) * 60 / (130 - 50), 20, 80)
    quadril_visual = limitar(35 + (dados["quadril"] - 70) * 60 / (150 - 70), 35, 95)

    escala_peso = round(limitar(0.60 + (dados["peso"] - 2) * 0.70 / (120 - 2), 0.60, 1.30), 2)

    proporcoes = {
        "busto_esq": round((100 - busto_visual) / 2, 1),
        "busto_dir": round((100 + busto_visual) / 2, 1),
        "cintura_esq": round((100 - cintura_visual) / 2, 1),
        "cintura_dir": round((100 + cintura_visual) / 2, 1),
        "quadril_esq": round((100 - quadril_visual) / 2, 1),
        "quadril_dir": round((100 + quadril_visual) / 2, 1),
        "escala_peso": escala_peso,
        "altura_manequim": round(290 + (dados["altura"] - 140) * 70 / 70)
    }

    return render_template(
        "provador.html",
        tons_pele=TONS_PELE,
        **dados,
        pele=pele,
        tamanho=tamanho,
        detalhes_caimento=detalhes_caimento,
        status_linhas=status_linhas,
        mensagem=mensagem,
        **proporcoes
    )


# ==========================================
# PÁGINA DE PRODUTOS E CATEGORIAS
# ==========================================

@app.route("/produtos")
@app.route("/produtos/<categoria>")
def produtos_pagina(categoria=None):
    busca = request.args.get("q", "").strip()
    
    conexao = conectar_mysql()
    produtos = []

    if conexao:
        try:
            with conexao.cursor() as cursor:
                sql = """
                    SELECT p.*, c.nome AS nome_categoria 
                    FROM produtos AS p
                    LEFT JOIN categoria AS c ON p.id_categoria = c.id_categoria
                    WHERE 1=1
                """
                parametros = []

                if categoria:
                    sql += " AND (c.nome = %s OR p.id_categoria = %s)"
                    parametros.extend([categoria, categoria])

                if busca:
                    sql += " AND (p.nome LIKE %s)"
                    parametros.append(f"%{busca}%")

                cursor.execute(sql, parametros)
                produtos = cursor.fetchall()
        except pymysql.MySQLError as erro:
            print(f"Erro ao consultar produtos: {erro}")
        finally:
            conexao.close()

    return render_template(
        "produtos.html",
        produtos=produtos,
        categoria_atual=categoria,
        busca=busca
    )


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
# SALVAR CADASTRO
# ==========================================

@app.route("/salvar", methods=["POST"])
def salvar():
    nome = request.form.get("nome", "").strip()
    email = request.form.get("email", "").strip()
    telefone = request.form.get("telefone", "").strip()
    senha = request.form.get("senha", "").strip()

    valores = {"nome": nome, "email": email, "telefone": telefone}

    if not nome or not email or not telefone or not senha:
        return render_template("forms.html", erro="Preencha todos os campos obrigatórios.", valores=valores), 400

    if "@" not in email:
        return render_template("forms.html", erro="Confira o formato do e-mail digitado.", valores=valores), 400

    conexao = conectar_mysql()

    if not conexao:
        return render_template("forms.html", erro="Servidor de banco de dados indisponível.", valores=valores), 500

    try:
        with conexao.cursor() as cursor:
            sql_usuario = "INSERT INTO usuario (nome, email, senha, status) VALUES (%s, %s, %s, TRUE)"
            cursor.execute(sql_usuario, (nome, email, generate_password_hash(senha)))
            id_usuario = cursor.lastrowid

            sql_cliente = "INSERT INTO clientes (id_usuario) VALUES (%s)"
            cursor.execute(sql_cliente, (id_usuario,))

            sql_telefone = "INSERT INTO telefone (id_usuario, numero, tipo) VALUES (%s, %s, %s)"
            cursor.execute(sql_telefone, (id_usuario, telefone, "CELULAR"))

        conexao.commit()

        session["usuario_id"] = id_usuario
        session["usuario_nome"] = nome
        session["usuario_email"] = email
        session["usuario_telefone"] = telefone

        return redirect(url_for("listar_usuarios"))

    except pymysql.MySQLError as erro:
        if conexao:
            conexao.rollback()

        print(f"Erro ao salvar cadastro: {erro}")
        if erro.args and erro.args[0] == 1062:
            mensagem = "Este e-mail já está cadastrado no sistema."
        else:
            mensagem = f"Erro no banco de dados: {erro}"

        return render_template("forms.html", erro=mensagem, valores=valores), 400

    finally:
        if conexao:
            conexao.close()


# ==========================================
# LOGIN E AUTENTICAÇÃO
# ==========================================

@app.route("/login")
def login():
    if "usuario_id" in session:
        return redirect(url_for("listar_usuarios"))

    return render_template(
        "login.html",
        erro=None,
        sucesso=request.args.get("sucesso"),
        email_digitado=""
    )


@app.route("/autenticar", methods=["POST"])
def autenticar():
    email = request.form.get("email", "").strip()
    senha = request.form.get("senha", "").strip()

    if not email or not senha:
        return render_template("login.html", erro="Preencha o e-mail e a senha.", email_digitado=email), 400

    conexao = conectar_mysql()

    if not conexao:
        return render_template("login.html", erro="Servidor de banco de dados indisponível.", email_digitado=email), 500

    try:
        with conexao.cursor() as cursor:
            sql = "SELECT id_usuario, nome, email, senha FROM usuario WHERE email = %s"
            cursor.execute(sql, (email,))
            usuario = cursor.fetchone()

            if usuario and check_password_hash(usuario["senha"], senha):
                session["usuario_id"] = usuario["id_usuario"]
                session["usuario_nome"] = usuario["nome"]
                session["usuario_email"] = usuario["email"]
                return redirect(url_for("listar_usuarios"))
            else:
                return render_template("login.html", erro="E-mail ou senha incorretos.", email_digitado=email), 401

    except pymysql.MySQLError as erro:
        print(f"Erro ao autenticar usuário: {erro}")
        return render_template("login.html", erro="Erro interno ao tentar autenticar.", email_digitado=email), 500

    finally:
        if conexao:
            conexao.close()


# ==========================================
# PÁGINA DE PERFIL E HISTÓRICO
# ==========================================

@app.route("/perfil")
def perfil():
    if "usuario_id" not in session and "usuario_nome" not in session:
        return redirect(url_for("cadastro"))

    conexao = conectar_mysql()
    usuario = None

    if conexao:
        try:
            with conexao.cursor() as cursor:
                sql = """
                    SELECT u.id_usuario, u.nome, u.email, t.numero AS telefone
                    FROM usuario AS u
                    LEFT JOIN telefone AS t ON u.id_usuario = t.id_usuario
                    WHERE u.id_usuario = %s
                """
                cursor.execute(sql, (session.get("usuario_id"),))
                usuario = cursor.fetchone()
        except pymysql.MySQLError as erro:
            print(f"Erro ao carregar perfil: {erro}")
        finally:
            conexao.close()

    if not usuario:
        usuario = {
            "id_usuario": session.get("usuario_id", 1),
            "nome": session.get("usuario_nome", "Usuário Lumina"),
            "email": session.get("usuario_email", "email@exemplo.com"),
            "telefone": session.get("usuario_telefone", "Não informado")
        }

    return render_template("perfil.html", usuario=usuario)


@app.route("/usuarios")
def listar_usuarios():
    conexao = conectar_mysql()
    usuarios = []
    erro = None

    if conexao:
        try:
            with conexao.cursor() as cursor:
                sql = """
                    SELECT u.id_usuario, u.nome, u.email, t.numero
                    FROM usuario AS u
                    LEFT JOIN telefone AS t ON u.id_usuario = t.id_usuario
                    ORDER BY u.id_usuario DESC
                """
                cursor.execute(sql)
                usuarios = cursor.fetchall()
        except pymysql.MySQLError as erro_sql:
            print(f"Erro ao listar usuários: {erro_sql}")
            erro = "Erro ao carregar a lista de usuários do banco de dados."
        finally:
            conexao.close()
    else:
        erro = "Servidor de banco de dados indisponível."

    return render_template("usuarios.html", usuarios=usuarios, erro=erro)


@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))


@app.route("/consultar-pedidos")
def consultar_pedidos():
    conexao = conectar_mysql()
    pedidos = []
    erro = None

    if conexao:
        try:
            with conexao.cursor() as cursor:
                sql = """
                    SELECT
                        p.pedido_id AS id_pedido,
                        u.nome AS nome_cliente,
                        p.data_pedido,
                        p.total_pedido AS valor_total
                    FROM pedidos AS p
                    INNER JOIN clientes AS c ON p.cliente_id = c.cliente_id
                    INNER JOIN usuario AS u ON c.id_usuario = u.id_usuario
                    ORDER BY p.data_pedido DESC
                """
                cursor.execute(sql)
                pedidos = cursor.fetchall()
        except pymysql.MySQLError as erro_sql:
            print(f"Erro ao consultar pedidos: {erro_sql}")
            erro = "Não foi possível carregar o histórico de pedidos no momento."
        finally:
            conexao.close()
    else:
        erro = "Não foi possível conectar ao banco de dados."

    return render_template("consultar_pedidos.html", pedidos=pedidos, erro=erro)


# ==========================================
# CARRINHO DE COMPRAS
# ==========================================

@app.route("/adicionar-carrinho", methods=["POST"])
def adicionar_carrinho():
    nome = request.form.get("nome", "").strip()

    try:
        preco = float(request.form.get("preco", 0))
    except (ValueError, TypeError):
        preco = 0.0

    imagem = request.form.get("imagem", "").strip()
    tamanho = request.form.get("tamanho", "M").strip()
    cor = request.form.get("cor", "Padrão").strip()

    if not nome:
        return redirect(url_for("carrinho"))

    carrinho_atual = list(session.get("carrinho", []))

    item_encontrado = False
    for item in carrinho_atual:
        if item.get("nome") == nome and item.get("tamanho") == tamanho:
            item["quantidade"] = item.get("quantidade", 1) + 1
            item_encontrado = True
            break

    if not item_encontrado:
        carrinho_atual.append({
            "nome": nome,
            "preco": preco,
            "imagem": imagem,
            "tamanho": tamanho,
            "cor": cor,
            "quantidade": 1
        })

    session["carrinho"] = carrinho_atual
    session.modified = True

    return redirect(url_for("carrinho"))


@app.route("/carrinho")
def carrinho():
    produtos_carrinho = session.get("carrinho", [])
    total = sum(item["preco"] * item["quantidade"] for item in produtos_carrinho)
    return render_template("carrinho.html", produtos=produtos_carrinho, total=total)


@app.route("/atualizar-quantidade", methods=["POST"])
def atualizar_quantidade():
    index = request.form.get("index", type=int)
    acao = request.form.get("acao")

    carrinho_atual = list(session.get("carrinho", []))

    if index is not None and 0 <= index < len(carrinho_atual):
        if acao == "aumentar":
            carrinho_atual[index]["quantidade"] += 1
        elif acao == "diminuir":
            carrinho_atual[index]["quantidade"] -= 1
            if carrinho_atual[index]["quantidade"] <= 0:
                carrinho_atual.pop(index)

        session["carrinho"] = carrinho_atual
        session.modified = True

    return redirect(url_for("carrinho"))


@app.route("/remover-item/<int:index>")
def remover_item(index):
    carrinho_atual = list(session.get("carrinho", []))

    if 0 <= index < len(carrinho_atual):
        carrinho_atual.pop(index)
        session["carrinho"] = carrinho_atual
        session.modified = True

    return redirect(url_for("carrinho"))


@app.route("/limpar-carrinho")
def limpar_carrinho():
    session.pop("carrinho", None)
    return redirect(url_for("carrinho"))


# ==========================================
# ROTA DE CHECKOUT E CONFIRMAÇÃO DE PAGAMENTO
# ==========================================

@app.route("/checkout")
def checkout():
    carrinho_atual = session.get("carrinho", [])
    if not carrinho_atual:
        return redirect(url_for("carrinho"))

    total = sum(item["preco"] * item["quantidade"] for item in carrinho_atual)
    return render_template("checkout.html", produtos=carrinho_atual, total=total)


@app.route("/confirmar-pagamento", methods=["POST"])
def confirmar_pagamento():
    session.pop("carrinho", None)
    return render_template(
        "contato.html",
        sucesso="🎉 Compra realizada com sucesso! O seu pedido já está a ser processado."
    )


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
            return render_template("contato.html", erro="Preencha todos os campos obrigatórios."), 400

        return render_template("contato.html", sucesso="Mensagem enviada com sucesso!")

    return render_template("contato.html", erro=None, sucesso=None)


if __name__ == "__main__":
    app.run(debug=True)
