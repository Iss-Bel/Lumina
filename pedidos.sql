
-- =========================================
-- PROJETO: LUMINA - LOJA VIRTUAL DE ROUPAS
-- ATIVIDADE: CONSULTA COM INNER JOIN
-- =========================================

-- Selecionar o banco de dados
USE lumina_formulario;


-- =========================================
-- 1. CONFERIR AS TABELAS
-- =========================================

SHOW TABLES;


-- =========================================
-- 2. CONFERIR A ESTRUTURA DAS TABELAS
-- =========================================

DESCRIBE clientes;
DESCRIBE pedidos;


-- =========================================
-- 3. CONSULTAR OS CLIENTES CADASTRADOS
-- =========================================

SELECT *
FROM clientes;


-- =========================================
-- 4. CONSULTAR OS PEDIDOS CADASTRADOS
-- =========================================

SELECT *
FROM pedidos;


-- =========================================
-- 5. CONSULTA PRINCIPAL COM INNER JOIN
-- Mostrar pedidos junto com os dados dos clientes
-- =========================================

SELECT
    p.pedido_id,
    c.nome AS nome_cliente,
    c.email AS email_cliente,
    p.data_pedido,
    p.endereco_entrega,
    p.total_pedido
FROM pedidos AS p
INNER JOIN clientes AS c
    ON p.cliente_id = c.cliente_id
ORDER BY p.data_pedido DESC;


-- =========================================
-- 6. CONSULTA RESUMIDA
-- Quantidade de pedidos e valor total por cliente
-- =========================================

SELECT
    c.cliente_id,
    c.nome AS nome_cliente,
    COUNT(p.pedido_id) AS quantidade_pedidos,
    COALESCE(SUM(p.total_pedido), 0) AS valor_total_compras
FROM clientes AS c
LEFT JOIN pedidos AS p
    ON c.cliente_id = p.cliente_id
GROUP BY
    c.cliente_id,
    c.nome
ORDER BY valor_total_compras DESC;

DESCRIBE pedidos;
SELECT * FROM