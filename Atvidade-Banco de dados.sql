CREATE DATABASE IF NOT EXISTS lumina_formulario;
USE lumina_formulario;

-- =========================================
-- 1. USUARIO
-- =========================================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    status BOOLEAN DEFAULT TRUE,

    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario)
);

-- =========================================
-- 2. CLIENTES (Relacionamento 1:1 com Usuario)
-- =========================================
CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT,
    id_usuario INT NOT NULL UNIQUE,

    CONSTRAINT pk_clientes PRIMARY KEY (cliente_id),
    CONSTRAINT fk_cliente_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
);

-- =========================================
-- 3. TELEFONE
-- =========================================
CREATE TABLE telefone (
    id_telefone INT AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    numero VARCHAR(20) NOT NULL,
    tipo VARCHAR(20) DEFAULT 'CELULAR',

    CONSTRAINT pk_telefone PRIMARY KEY (id_telefone),
    CONSTRAINT fk_telefone_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
);

-- =========================================
-- 4. ENDERECO
-- =========================================
CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,

    cep VARCHAR(9) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    bairro VARCHAR(60) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    estado CHAR(2) NOT NULL,

    CONSTRAINT pk_endereco PRIMARY KEY (id_endereco),
    CONSTRAINT fk_endereco_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id)
        ON DELETE CASCADE
);

-- =========================================
-- 5. CATEGORIA
-- =========================================
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE,
    descricao VARCHAR(255),

    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

-- =========================================
-- 6. PRODUTOS
-- =========================================
CREATE TABLE produtos (
    produto_id INT AUTO_INCREMENT,
    id_categoria INT NOT NULL,

    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0,

    CONSTRAINT pk_produtos PRIMARY KEY (produto_id),
    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
);

-- =========================================
-- 7. LOTE
-- =========================================
CREATE TABLE lote (
    id_lote INT AUTO_INCREMENT,
    produto_id INT NOT NULL,

    codigo_lote VARCHAR(50) NOT NULL UNIQUE,
    quantidade INT NOT NULL,
    data_entrada DATE NOT NULL,

    CONSTRAINT pk_lote PRIMARY KEY (id_lote),
    CONSTRAINT fk_lote_produto
        FOREIGN KEY (produto_id)
        REFERENCES produtos(produto_id)
);

ALTER TABLE lote 
DROP COLUMN data_validade;

TRUNCATE TABLE lote;


-- =========================================
-- 8. PEDIDOS
-- =========================================
CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,

    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    endereco_entrega VARCHAR(250),
    total_pedido DECIMAL(10,2) NOT NULL DEFAULT 0.00,

    CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id),
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id)
);

-- =========================================
-- 9. ITENS DO PEDIDO
-- =========================================
CREATE TABLE itens_pedido (
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,

    preco_unitario DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_itens_pedido
        PRIMARY KEY (pedido_id, produto_id),
    CONSTRAINT fk_item_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(pedido_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_item_produto
        FOREIGN KEY (produto_id)
        REFERENCES produtos(produto_id)
);

-- =========================================
-- 10. PAGAMENTOS
-- =========================================
CREATE TABLE pagamentos (
    pagamento_id INT AUTO_INCREMENT,
    pedido_id INT NOT NULL,

    valor_pedido DECIMAL(10,2) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    status_pagamento VARCHAR(30) NOT NULL,
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_pagamentos PRIMARY KEY (pagamento_id),
    CONSTRAINT fk_pagamento_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(pedido_id)
);

-- =========================================
-- 11. CARRINHO
-- =========================================
CREATE TABLE carrinho (
    id_carrinho INT AUTO_INCREMENT,
    cliente_id INT NOT NULL,

    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ABERTO',

    CONSTRAINT pk_carrinho PRIMARY KEY (id_carrinho),
    CONSTRAINT fk_carrinho_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id)
);

-- =========================================
-- 12. ITENS DO CARRINHO
-- =========================================
CREATE TABLE item_carrinho (
    id_item_carrinho INT AUTO_INCREMENT,
    id_carrinho INT NOT NULL,
    produto_id INT NOT NULL,

    quantidade INT NOT NULL DEFAULT 1,

    CONSTRAINT pk_item_carrinho PRIMARY KEY (id_item_carrinho),
    CONSTRAINT fk_item_carrinho
        FOREIGN KEY (id_carrinho)
        REFERENCES carrinho(id_carrinho)
        ON DELETE CASCADE,
    CONSTRAINT fk_item_carrinho_produto
        FOREIGN KEY (produto_id)
        REFERENCES produtos(produto_id)
);

-- =========================================
-- 13. REEMBOLSO
-- =========================================
CREATE TABLE reembolso (
    id_reembolso INT AUTO_INCREMENT,
    pedido_id INT NOT NULL,

    valor DECIMAL(10,2) NOT NULL,
    motivo VARCHAR(255),
    metodo_reembolso VARCHAR(30) NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDENTE',
    data_solicitacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_reembolso DATETIME,

    CONSTRAINT pk_reembolso PRIMARY KEY (id_reembolso),
    CONSTRAINT fk_reembolso_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(pedido_id)
);

-- Consultas de teste corrigidas com ponto e vírgula
SELECT * FROM usuario;
SELECT * FROM telefone;
SELECT * FROM produtos;
SELECT * FROM clientes;
DESCRIBE clientes;
SELECT cliente_id, id_usuario, nome, email
FROM clientes
ORDER BY cliente_id
LIMIT 10;

-- 1 pergunta: Quanto usuarios/clientes estao cadastrados atualmente no LUMINA?
SELECT COUNT(*) AS total_usuarios
FROM usuario;
SELECT COUNT(*) AS total_clientes
FROM clientes;


-- 2 pergunta: Qual é o valor total dos pedidos registrados na Lumina?
SELECT 
    SUM(total_pedido) AS valor_total_pedidos
FROM pedidos;

-- 3 pergunta: quantos produtos tem?
SELECT COUNT(*) AS total_produtos
FROM produtos;
SELECT * FROM produtos
ORDER BY produto_id;
SELECT produto_id, nome, preco, estoque
FROM produtos;
SELECT
    i.pedido_id,
    p.nome AS produto,
    i.preco_unitario,
    i.quantidade,
    i.subtotal
FROM itens_pedido i
INNER JOIN produtos p
    ON i.produto_id = p.produto_id
ORDER BY i.pedido_id;

-- 4 pergunta: Qual é o faturamento bruto total gerado pelas vendas de todos os pedidos realizados?
SELECT SUM(total_pedido) AS faturamento_bruto_total
FROM pedidos;

-- 5 pergunta: Qual é o valor médio investido pelos clientes por pedido (Ticket Médio)?
SELECT AVG(total_pedido) AS ticket_medio_pedido
FROM pedidos;

-- 6 pergunta: Qual é a quantidade total de produtos disponíveis em estoque e a quantidade de itens cadastrados agrupados por categoria?
SELECT 
    id_categoria,
    COUNT(produto_id) AS quantidade_produtos,
    SUM(estoque) AS total_itens_estoque
FROM produtos
GROUP BY id_categoria;

-- 7 pergunta: Quais são os produtos associados a cada lote de entrada, exibindo suas respectivas quantidades e datas de entrada?
SELECT 
    l.codigo_lote,
    l.quantidade AS quantidade_lote,
    l.data_entrada,
    p.nome AS nome_produto,
    p.preco AS preco_produto
FROM lote l
INNER JOIN produtos p
    -- PK (Primary Key): produtos.produto_id
    -- FK (Foreign Key): lote.produto_id
    ON l.produto_id = p.produto_id;