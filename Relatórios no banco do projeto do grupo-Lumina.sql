USE lumina_formulario


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
SELECT * FROM usuarios

SELECT 
    (SELECT COUNT(*) FROM usuario) AS total_usuarios,
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM pedidos) AS total_pedidos,
    (SELECT COUNT(*) FROM itens_pedido) AS total_itens_pedido,
    (SELECT COUNT(*) FROM pagamentos) AS total_pagamentos;
    
-- Deve retornar 70 linhas (apenas os clientes que compraram
SELECT 
    c.cliente_id,
    c.id_usuario,
    p.pedido_id,
    p.total_pedido
FROM clientes c
INNER JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- Deve retornar 101 linhas (os 70 com pedido + os 30 sem pedido com campos a NULL
SELECT 
    c.cliente_id,
    c.id_usuario,
    p.pedido_id,
    p.total_pedido
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- Deve retornar 30 linhas (os clientes que ainda não realizaram nenhuma compra):
SELECT 
    c.cliente_id,
    c.id_usuario,
    p.pedido_id
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id
WHERE p.pedido_id IS NULL;
