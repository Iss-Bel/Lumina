import os
import pymysql
import pymysql.cursors
from flask import Flask, render_template, request, redirect, url_for, session
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

# Chave secreta para controle de sessões
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

# Mapeamento completo dos 38 produtos da coleção Lumina
PRODUTOS_MOCK = {
    1: {"nome": "Cardigan em Tricô Canelado com Renda", "preco": 70.00, "imagem": "img/cardicam_amarela.webp", "imagem_costas": "img/blusa amarela tras.webp", "nome_categoria": "Feminino", "descricao": "Cardigan macio em tricô canelado com acabamento delicado em renda nas bordas."},
    2: {"nome": "Vestido Frente Única Roxo Curto", "preco": 150.00, "imagem": "img/vestido_roxo.webp", "imagem_costas": "img/vestido_roxo_tras.webp", "nome_categoria": "Feminino", "descricao": "Vestido curto com decote frente única e caimento leve."},
    3: {"nome": "Camisa Branca Estampada", "preco": 90.00, "imagem": "img/camisa_branca_estampada.webp", "imagem_costas": "img/camisa_estanpada_tras.webp", "nome_categoria": "Unissex", "descricao": "Camisa de botão casual em tecido leve de algodão com estampa moderna."},
    4: {"nome": "Calça Baggy Unissex", "preco": 150.00, "imagem": "img/calça_baggy.webp", "imagem_costas": "img/calça_baggy_tras.webp", "nome_categoria": "Unissex", "descricao": "Calça jeans modelagem baggy com cintura média e corte amplo nas pernas."},
    5: {"nome": "Camisa Preta Masculina", "preco": 150.00, "imagem": "img/camisa_preta.webp", "imagem_costas": "img/camisa preta tras.webp", "nome_categoria": "Masculino", "descricao": "Camisa social esporte em tom preto fosco, confeccionada com caimento slim fit."},
    6: {"nome": "Blusa Preta Manga Longa", "preco": 150.00, "imagem": "img/blusa preta.webp", "imagem_costas": "img/blusa preta tras.webp", "nome_categoria": "Unissex", "descricao": "Blusa básica de manga longa em malha premium."},
    7: {"nome": "Jaqueta Jeans", "preco": 180.00, "imagem": "img/jaqueta jeans.webp", "imagem_costas": "img/jaqueta_jeans_tras.webp", "nome_categoria": "Feminino", "descricao": "Jaqueta feminina overshirt confeccionada em jeans encorpado de algodão."},
    8: {"nome": "Camisa Social", "preco": 150.00, "imagem": "img/camisa_social.webp", "imagem_costas": "img/camisa_socia_ tras.webp", "nome_categoria": "Masculino", "descricao": "Camisa social de manga longa em tom suave."},
    9: {"nome": "Calça Jeans Feminina", "preco": 150.00, "imagem": "img/calça_jeans.webp", "imagem_costas": "img/calça_jeans.webp", "nome_categoria": "Feminino", "descricao": "Calça jeans feminina com lavagem clássica e caimento ajustado ao corpo."},
    10: {"nome": "Bermuda Jeans Estampada", "preco": 140.00, "imagem": "img/bermuda_jeans_frente.webp", "imagem_costas": "img/bermuda_jeans_atras.webp", "nome_categoria": "Masculino", "descricao": "Bermuda jeans com lavagem especial e estampa frontal urbana."},
    11: {"nome": "Casaco com Capuz e Fecho Branco", "preco": 160.00, "imagem": "img/Blusa Branca Frente.webp", "imagem_costas": "img/blusa_branca_atras.webp", "nome_categoria": "Feminino", "descricao": "Casaco em moletom confortável com fecho e capuz ajustável."},
    12: {"nome": "Camiseta Estampada Gorillaz", "preco": 95.00, "imagem": "img/blusa_banda_frente.webp", "imagem_costas": "img/blusa_banda_tras.webp", "nome_categoria": "Unissex", "descricao": "Camiseta em algodão macio com estampa exclusiva da banda Gorillaz."},
    13: {"nome": "Top Frente Única Lastex Branco", "preco": 85.00, "imagem": "img/blusa_verao_frente.webp", "imagem_costas": "img/blusa_verao_tras.webp", "nome_categoria": "Feminino", "descricao": "Top leve com acabamento em lastex e decote frente única."},
    14: {"nome": "Vestido Longo de Cetim Azul Escuro", "preco": 180.00, "imagem": "img/vestido_azulescuro_frente.webp", "imagem_costas": "img/vestido_azulescuro_tras.webp", "nome_categoria": "Feminino", "descricao": "Vestido sofisticado em cetim de tom azul escuro com brilho acetinado."},
    15: {"nome": "Blusa Polo Brasil Verde", "preco": 89.90, "imagem": "img/Blusa_brasil_frente.webp", "imagem_costas": "img/Blusa_brasil_tras.webp", "nome_categoria": "Feminino", "descricao": "Blusa polo feminina verde com detalhes amarelos vibrantes."},
    16: {"nome": "Camiseta Oversized Brutal Esqueleto", "preco": 110.00, "imagem": "img/Blusa_esqueleto_frente.webp", "imagem_costas": "img/Blusa_esqueleto_tras.webp", "nome_categoria": "Masculino", "descricao": "Camiseta oversized preta com estampa gráfica de esqueleto."},
    17: {"nome": "Calça Jeans Wide Leg Feminina", "preco": 170.00, "imagem": "img/calça_jeans_wideLeg_frente.webp", "imagem_costas": "img/calça_jeans_wideLeg_tras.webp", "nome_categoria": "Feminino", "descricao": "Calça jeans wide leg de cintura alta com excelente caimento."},
    18: {"nome": "Jaqueta de Couro Sintético Preta", "preco": 250.00, "imagem": "img/Jaqueta_Preta_frente.webp", "imagem_costas": "img/Jaqueta_Preta_tras.webp", "nome_categoria": "Unissex", "descricao": "Jaqueta unissex em couro sintético preto de alta resistência."},
    19: {"nome": "Calça Jeans Infantil Preta com Estrelas", "preco": 130.00, "imagem": "img/calca-infantil-frente.webp", "imagem_costas": "img/calca-infantil-tras.webp", "nome_categoria": "Infantil", "descricao": "Calça jeans infantil preta decorada com estrelas."},
    20: {"nome": "Calça Jeans Wide Leg Cinza", "preco": 160.00, "imagem": "img/calca_jeans-cinza-frente.webp", "imagem_costas": "img/calca_jeans-cinza-tras.webp", "nome_categoria": "Unissex", "descricao": "Calça jeans cinza com modelagem wide leg e estilo contemporâneo."},
    21: {"nome": "Camisa Polo Branca com Zíper", "preco": 120.00, "imagem": "img/camisa-polo-branca-frente.webp", "imagem_costas": "img/camisa-polo-branca-tras.webp", "nome_categoria": "Masculino", "descricao": "Camisa polo masculina em algodão branco com fecho em zíper metálico."},
    22: {"nome": "Camiseta Roxa Estampada Oriental", "preco": 95.00, "imagem": "img/camisa-style-roxa-frente.webp", "imagem_costas": "img/camisa-style-roxa-tras.webp", "nome_categoria": "Unissex", "descricao": "Camiseta roxa com estampa oriental em destaque nas costas."},
    23: {"nome": "Calça Jeans Baggy Preta com Strass Chamas", "preco": 210.00, "imagem": "img/calca_preta_frente.webp", "imagem_costas": "img/calca_preta_frente.webp", "nome_categoria": "Unissex", "descricao": "Calça jeans baggy preta com aplicação em strass em formato de chamas."},
    24: {"nome": "Calça Baggy Preta Streetwear com Vivos", "preco": 169.90, "imagem": "img/calca-larga-preta-frente.webp", "imagem_costas": "img/calca-larga-preta-frente.webp", "nome_categoria": "Unissex", "descricao": "Calça baggy preta estilo streetwear com detalhes em linhas brancas destacadas."},
    25: {"nome": "Camiseta Infantil Capivara Piloto", "preco": 89.90, "imagem": "img/capivara frente.webp", "imagem_costas": "img/capivara tras.webp", "nome_categoria": "Infantil", "descricao": "Camiseta infantil divertida com ilustração de capivara de capacete."},
    26: {"nome": "Camiseta Infantil Amarela 'LOVELY'", "preco": 75.00, "imagem": "img/top_floral_peplum_2.webp", "imagem_costas": "img/top_floral_peplum_1.webp", "nome_categoria": "Infantil", "descricao": "Camiseta infantil amarela com estampa frontal delicada."},
    27: {"nome": "Top Regata em Renda Rosa", "preco": 99.00, "imagem": "img/top_renda_rosa_frente.webp", "imagem_costas": "img/top_renda_rosa_costas.webp", "nome_categoria": "Feminino", "descricao": "Top regata curto confeccionado em renda tom rosa claro."},
    28: {"nome": "Camiseta Oversized Verde 'New York'", "preco": 119.90, "imagem": "img/tshirt_verde_frente.webp", "imagem_costas": "img/tshirt_verde_tras.webp", "nome_categoria": "Unissex", "descricao": "Camiseta oversized verde escuro com estampa New York."},
    29: {"nome": "Vestido Mídi Estampa Tropical Azul", "preco": 199.00, "imagem": "img/vestido_azul-frente.webp", "imagem_costas": "img/vestido_azul-tras.webp", "nome_categoria": "Feminino", "descricao": "Vestido mídi leve com padronagem tropical azul e alças finas."},
    30: {"nome": "Bermuda Infantil Bege Dinossauro", "preco": 69.90, "imagem": "img/bermuda_marrom_infantil_frente.webp", "imagem_costas": "img/bermuda_marrom_infantil_tras.webp", "nome_categoria": "Infantil", "descricao": "Bermuda infantil bege confortável com bordado de dinossauro."},
    31: {"nome": "Jaqueta Infantil Corta-Vento Floral com Capuz", "preco": 129.90, "imagem": "img/blusa_frio_infantil_frente.webp", "imagem_costas": "img/blusa_frio_infantil_tras.webp", "nome_categoria": "Infantil", "descricao": "Corta-vento infantil floral com capuz e proteção contra o vento."},
    32: {"nome": "Regata Infantil Xadrez Rosa Moranguinhos", "preco": 59.90, "imagem": "img/blusa_rosa_infantil_frente.webp", "imagem_costas": "img/blusa_rosa_infantil_tras.webp", "nome_categoria": "Infantil", "descricao": "Regata infantil em xadrez rosa com detalhes de morangos."},
    33: {"nome": "Camiseta Infantil Snoopy Peanuts", "preco": 69.90, "imagem": "img/camisa_ilustrada_infantil_frente.webp", "imagem_costas": "img/camisa_ilustrada_infantil_tras.webp", "nome_categoria": "Infantil", "descricao": "Camiseta azul marinho infantil estampada com a turma do Snoopy."},
    34: {"nome": "Camiseta Infantil Listrada com Botões", "preco": 65.00, "imagem": "img/camisa_infantil_listrada_frente.webp", "imagem_costas": "img/camisa_infantil_listrada_tras.webp", "nome_categoria": "Infantil", "descricao": "Camiseta infantil listrada com abertura de botões no peito."},
    35: {"nome": "Camiseta Infantil Preta 'Super League'", "preco": 69.90, "imagem": "img/camisa_preta_infantil_frente.webp", "imagem_costas": "img/camisa_preta_infantil_tras.webp", "nome_categoria": "Infantil", "descricao": "Camiseta preta infantil estilo desportivo Super League."},
    36: {"nome": "Camiseta Infantil Oversized 'Athletic League 30'", "preco": 79.90, "imagem": "img/camisa_time_infatil_frente.webp", "imagem_costas": "img/camisa_time_infatil_tras.webp", "nome_categoria": "Infantil", "descricao": "Camiseta oversized branca infantil com estampa de liga desportiva."},
    37: {"nome": "Camiseta Infantil Bege Cãozinho com Bolso", "preco": 59.90, "imagem": "img/camisa-ilustrada-cachorro-infatil-frente.webp", "imagem_costas": "img/camisa-ilustrada-cachorro-infatil-tras.webp", "nome_categoria": "Infantil", "descricao": "Camiseta bege infantil com bolso e ilustração de cãozinho."},
    38: {"nome": "Conjunto Infantil Amarelo Floral Regata e Calça", "preco": 119.90, "imagem": "img/conjuto_amarelo_infatil_frente.webp", "imagem_costas": "img/conjuto_amarelo_infatil_tras.webp", "nome_categoria": "Infantil", "descricao": "Conjunto infantil de duas peças (regata e calça) com estampa floral amarela."}
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
# CONEXÃO COM A BASE DE DADOS
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
        print(f"Erro de conexão com o MySQL: {erro_conexao}")
        return None


# ==========================================
# ROTAS DA APLICAÇÃO
# ==========================================

@app.route("/")
def inicio():
    return render_template("index.html")


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
    mensagem = "Preencha as suas medidas para descobrir o seu tamanho."

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
        "altura_manequim": round(290 + (dados["altura"] - 140))
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
                    SELECT p.*, 
                           COALESCE(p.id_produto, p.id) AS id_produto, 
                           c.nome AS nome_categoria 
                    FROM produtos AS p
                    LEFT JOIN categoria AS c ON p.id_categoria = c.id_categoria
                    WHERE 1=1
                """
                parametros = []

                if categoria:
                    sql += " AND (c.nome = %s OR p.id_categoria = %s)"
                    parametros.extend([categoria, categoria])

                if busca:
                    sql += " AND (p.nome LIKE %s OR c.nome LIKE %s)"
                    parametros.extend([f"%{busca}%", f"%{busca}%"])

                cursor.execute(sql, parametros)
                produtos = cursor.fetchall()
                for prod in produtos:
                    prod["preco"] = float(prod["preco"]) if prod.get("preco") is not None else 0.0
        except pymysql.MySQLError as erro:
            print(f"Erro ao consultar produtos: {erro}")
        finally:
            conexao.close()

    if not produtos:
        produtos_lista = []
        for k, v in PRODUTOS_MOCK.items():
            item = {"id_produto": k, **v}

            if categoria and categoria.lower() not in ["todos", "produtos"]:
                cat_item = item["nome_categoria"].lower()
                cat_filtro = categoria.lower()
                if cat_filtro not in cat_item and cat_item not in cat_filtro:
                    continue

            if busca:
                if busca.lower() not in item["nome"].lower():
                    continue

            produtos_lista.append(item)
        produtos = produtos_lista

    return render_template(
        "produtos.html",
        produtos=produtos,
        categoria_atual=categoria,
        busca=busca
    )


# ==========================================
# DETALHES DO PRODUTO E VITRINE RELACIONADA
# ==========================================

@app.route("/produto/<int:id_produto>")
def produto_detalhes(id_produto):
    conexao = conectar_mysql()
    produto = None
    outros_produtos = []

    if conexao:
        try:
            with conexao.cursor() as cursor:
                sql = """
                    SELECT p.*, 
                           COALESCE(p.id_produto, p.id) AS id_produto, 
                           c.nome AS nome_categoria 
                    FROM produtos AS p
                    LEFT JOIN categoria AS c ON p.id_categoria = c.id_categoria
                    WHERE p.id_produto = %s OR p.id = %s
                """
                cursor.execute(sql, (id_produto, id_produto))
                produto = cursor.fetchone()

                sql_outros = """
                    SELECT p.*, 
                           COALESCE(p.id_produto, p.id) AS id_produto, 
                           c.nome AS nome_categoria 
                    FROM produtos AS p
                    LEFT JOIN categoria AS c ON p.id_categoria = c.id_categoria
                    WHERE p.id_produto != %s OR p.id_produto IS NULL
                    LIMIT 4
                """
                cursor.execute(sql_outros, (id_produto,))
                outros_produtos = cursor.fetchall()

                for prod in outros_produtos:
                    prod["preco"] = float(prod["preco"]) if prod.get("preco") is not None else 0.0

        except pymysql.MySQLError as erro:
            print(f"Erro ao consultar produto no MySQL: {erro}")
        finally:
            conexao.close()

    if not produto:
        dados_base = PRODUTOS_MOCK.get(id_produto)
        if dados_base:
            produto = {
                "id_produto": id_produto,
                "nome": dados_base["nome"],
                "preco": dados_base["preco"],
                "imagem": dados_base["imagem"],
                "imagem_costas": dados_base.get("imagem_costas"),
                "nome_categoria": dados_base["nome_categoria"],
                "descricao": dados_base["descricao"]
            }
        else:
            produto = {
                "id_produto": id_produto,
                "nome": f"Produto Exclusivo #{id_produto}",
                "preco": 199.90,
                "imagem": "img/jaqueta jeans.webp",
                "imagem_costas": "img/jaqueta_jeans_tras.webp",
                "nome_categoria": "Geral",
                "descricao": "Peça exclusiva da nova coleção Lumina, desenvolvida para proporcionar conforto e sofisticação."
            }
    else:
        try:
            produto["preco"] = float(produto["preco"])
        except (ValueError, TypeError):
            produto["preco"] = 0.0

    if not outros_produtos:
        outros_produtos = [
            {"id_produto": k, **v} for k, v in PRODUTOS_MOCK.items() if k != id_produto
        ][:4]

    return render_template("produto.html", produto=produto, outros_produtos=outros_produtos)


# ==========================================
# AUTENTICAÇÃO E PERFIL
# ==========================================

@app.route("/cadastro")
def cadastro():
    return render_template("forms.html", erro=None, sucesso=request.args.get("sucesso"), valores={})


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

        # Redireciona direto para o perfil após o cadastro
        return redirect(url_for("perfil"))

    except pymysql.MySQLError as erro:
        if conexao:
            conexao.rollback()

        if erro.args and erro.args[0] == 1062:
            mensagem = "Este e-mail já está cadastrado no sistema."
        else:
            mensagem = f"Erro no banco de dados: {erro}"

        return render_template("forms.html", erro=mensagem, valores=valores), 400

    finally:
        if conexao:
            conexao.close()


@app.route("/login")
def login():
    if "usuario_id" in session:
        # Se já estiver logado, vai direto para o perfil
        return redirect(url_for("perfil"))

    return render_template("login.html", erro=None, sucesso=request.args.get("sucesso"), email_digitado="")


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
            sql = """
                SELECT u.id_usuario, u.nome, u.email, u.senha, t.numero AS telefone
                FROM usuario AS u
                LEFT JOIN telefone AS t ON u.id_usuario = t.id_usuario
                WHERE u.email = %s
            """
            cursor.execute(sql, (email,))
            usuario = cursor.fetchone()

            if usuario and check_password_hash(usuario["senha"], senha):
                session["usuario_id"] = usuario["id_usuario"]
                session["usuario_nome"] = usuario["nome"]
                session["usuario_email"] = usuario["email"]
                if usuario.get("telefone"):
                    session["usuario_telefone"] = usuario["telefone"]

                # Redireciona direto para o perfil após o login
                return redirect(url_for("perfil"))
            else:
                return render_template("login.html", erro="E-mail ou senha incorretos.", email_digitado=email), 401

    except pymysql.MySQLError as erro:
        print(f"Erro ao autenticar utilizador: {erro}")
        return render_template("login.html", erro="Erro interno ao tentar autenticar.", email_digitado=email), 500

    finally:
        if conexao:
            conexao.close()


@app.route("/perfil")
def perfil():
    if "usuario_id" not in session:
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
            "nome": session.get("usuario_nome", "Utilizador Lumina"),
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
            print(f"Erro ao listar utilizadores: {erro_sql}")
            erro = "Erro ao carregar a lista de utilizadores da base de dados."
        finally:
            conexao.close()
    else:
        erro = "Servidor de base de dados indisponível."

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
        erro = "Não foi possível ligar à base de dados."

    return render_template("consultar_pedidos.html", pedidos=pedidos, erro=erro)


# ==========================================
# CARRINHO DE COMPRAS E CHECKOUT
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
    total = sum(float(item["preco"]) * int(item["quantidade"]) for item in produtos_carrinho)
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


@app.route("/checkout")
def checkout():
    carrinho_atual = session.get("carrinho", [])
    if not carrinho_atual:
        return redirect(url_for("carrinho"))

    total = sum(float(item["preco"]) * int(item["quantidade"]) for item in carrinho_atual)
    return render_template("checkout.html", produtos=carrinho_atual, total=total)


# ==========================================
# CONFIRMAÇÃO DE PAGAMENTO E PEDIDO
# ==========================================

@app.route("/confirmar-pagamento", methods=["POST"])
def confirmar_pagamento():
    carrinho_atual = session.get("carrinho", [])
    if not carrinho_atual:
        return redirect(url_for("carrinho"))

    usuario_id = session.get("usuario_id")
    if not usuario_id:
        return redirect(url_for("login"))

    total = sum(float(item["preco"]) * int(item["quantidade"]) for item in carrinho_atual)

    conexao = conectar_mysql()
    if not conexao:
        return render_template(
            "checkout.html", 
            produtos=carrinho_atual, 
            total=total, 
            erro="Não foi possível ligar à base de dados."
        ), 500

    try:
        with conexao.cursor() as cursor:
            # 1. Recupera ou cria o registo do cliente associado ao utilizador
            cursor.execute("SELECT cliente_id FROM clientes WHERE id_usuario = %s", (usuario_id,))
            cliente = cursor.fetchone()

            if not cliente:
                cursor.execute("INSERT INTO clientes (id_usuario) VALUES (%s)", (usuario_id,))
                cliente_id = cursor.lastrowid
            else:
                cliente_id = cliente["cliente_id"]

            # 2. Grava o pedido na tabela pedidos
            sql_pedido = """
                INSERT INTO pedidos (cliente_id, data_pedido, total_pedido)
                VALUES (%s, NOW(), %s)
            """
            cursor.execute(sql_pedido, (cliente_id, total))
            pedido_id = cursor.lastrowid

        conexao.commit()
        session.pop("carrinho", None)

        # Redireciona para a página de confirmação específica do pedido
        return redirect(url_for("confirmacao_pedido", id_pedido=pedido_id))

    except pymysql.MySQLError as erro:
        if conexao:
            conexao.rollback()
        print(f"Erro ao registrar pedido: {erro}")
        return render_template(
            "checkout.html", 
            produtos=carrinho_atual, 
            total=total, 
            erro="Erro ao gravar o pedido na base de dados."
        ), 500

    finally:
        if conexao:
            conexao.close()


@app.route("/confirmacao-pedido/<int:id_pedido>")
def confirmacao_pedido(id_pedido):
    usuario_id = session.get("usuario_id")
    if not usuario_id:
        return redirect(url_for("login"))

    conexao = conectar_mysql()
    pedido = None

    if conexao:
        try:
            with conexao.cursor() as cursor:
                sql = """
                    SELECT 
                        p.pedido_id AS id_pedido,
                        p.data_pedido,
                        p.total_pedido AS total,
                        u.nome AS nome_cliente,
                        u.email AS email_cliente
                    FROM pedidos AS p
                    INNER JOIN clientes AS c ON p.cliente_id = c.cliente_id
                    INNER JOIN usuario AS u ON c.id_usuario = u.id_usuario
                    WHERE p.pedido_id = %s AND u.id_usuario = %s
                """
                cursor.execute(sql, (id_pedido, usuario_id))
                pedido = cursor.fetchone()
        except pymysql.MySQLError as erro:
            print(f"Erro ao buscar confirmação do pedido: {erro}")
        finally:
            conexao.close()

    if not pedido:
        pedido = {
            "id_pedido": id_pedido,
            "data_pedido": "Hoje",
            "total": 0.0
        }

    return render_template(
        "confirmacao_pedido.html",
        pedido_id=pedido["id_pedido"],
        data_pedido=pedido.get("data_pedido"),
        total=pedido.get("total", 0.0)
    )


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