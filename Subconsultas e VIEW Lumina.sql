USE lumina_formulario;

-- REQUISITO 1: IN
-- Pergunta: Quais clientes cadastrados possuem histórico de compras registrado no sistema?
-- Explicação: A subconsulta extrai os cliente_id com registros em pedidos. O WHERE c.cliente_id IN (...) filtra a tabela clientes mantendo apenas os identificadores retornados por esse conjunto.

SELECT 
    c.cliente_id,
    u.nome,
    u.email
FROM clientes c
INNER JOIN usuario u ON c.id_usuario = u.id_usuario
WHERE c.cliente_id IN (
    SELECT p.cliente_id 
    FROM pedidos p
);
-- Resultado observado: Retorna os clientes 1 (Ana Silva) e 2 (Carlos Souza). 
-- A cliente 3 (Mariana Lima) é ignorada por não possuir pedidos.

-- REQUISITO 2: NOT IN
-- Pergunta: Quais clientes ainda NÃO realizaram nenhuma compra no sistema?
-- Explicação: Identifica os clientes cujo ID não está presente na subconsulta de pedidos. O filtro 'WHERE p.cliente_id IS NOT NULL' trata a presença de valores nulos para evitar falhas no NOT IN.

SELECT 
    c.cliente_id,
    u.nome,
    u.email
FROM clientes c
INNER JOIN usuario u ON c.id_usuario = u.id_usuario
WHERE c.cliente_id NOT IN (
    SELECT p.cliente_id 
    FROM pedidos p 
    WHERE p.cliente_id IS NOT NULL
);
-- Resultado observado: Retorna apenas a cliente 3 (Mariana Lima), identificando o registro sem correspondência.

-- REQUISITO 3: EXISTS
-- Pergunta: Quais clientes cadastrados possuem histórico de compras registrado no sistema?
-- Explicação: Utiliza subconsulta correlacionada (p.cliente_id = c.cliente_id). A verificação linha a linha é interrompida assim que encontra o primeiro vínculo existente na tabela de pedidos.

SELECT 
    c.cliente_id,
    u.nome,
    u.email
FROM clientes c
INNER JOIN usuario u ON c.id_usuario = u.id_usuario
WHERE EXISTS (
    SELECT 1 
    FROM pedidos p 
    WHERE p.cliente_id = c.cliente_id
);
-- Resultado observado: Retorna os clientes 1 (Ana Silva) e 2 (Carlos Souza).

-- COMPARAÇÃO IN vs EXISTS:
-- Ambos os comandos respondem à mesma pergunta de negócio com os mesmos resultados. 
-- O IN cria a lista completa de IDs da subconsulta primeiro para verificar a inclusão, 
-- enquanto o EXISTS faz uma busca correlacionada direta que encerra o teste no primeiro match, 
-- oferecendo melhor performance em volumes elevados de dados.

-- REQUISITO 4: VIEW
-- Pergunta: Qual é o resumo gerencial de compras dos clientes, contendo total gasto e quantidade de pedidos?
-- Explicação: Estrutura uma visão consolidada unindo clientes, usuarios e pedidos via LEFT JOIN e funções agregadas.

CREATE OR REPLACE VIEW vw_resumo_compras_clientes AS
SELECT 
    c.cliente_id,
    u.nome AS nome_cliente,
    u.email AS email_cliente,
    COUNT(p.pedido_id) AS total_pedidos_realizados,
    IFNULL(SUM(p.total_pedido), 0.00) AS valor_total_gasto
FROM clientes c
INNER JOIN usuario u ON c.id_usuario = u.id_usuario
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id
GROUP BY c.cliente_id, u.nome, u.email;
-- Resultado observado: VIEW criada com sucesso na base de dados.

-- REQUISITO 5: CONSULTA À VIEW
-- Pergunta: Quais clientes possuem compras acima de R$ 0,00, ordenados do maior para o menor valor gasto?
-- Explicação: Lê a VIEW criada aplicando filtro de valor mínimo e ordenação decrescente pelo faturamento total.

SELECT 
    cliente_id,
    nome_cliente,
    email_cliente,
    total_pedidos_realizados,
    valor_total_gasto
FROM vw_resumo_compras_clientes
WHERE valor_total_gasto > 0.00
ORDER BY valor_total_gasto DESC;
-- Resultado observado: Retorna os clientes com saldo de compras ativos.

-- ANÁLISE DE NEGÓCIO DO PROJETO LUMINA.
/*
1. Em qual tela ou relatório a VIEW poderia ser utilizada?
   No Dashboard Administrativo do e-commerce Lumina, especificamente no módulo 
   "Gestão de Clientes / Relatório de Lifetime Value (LTV)".

2. Qual informação ela oferece ao usuário?
   Oferece uma visão consolidada por cliente, listando a quantidade de pedidos finalizados 
   e o somatório financeiro investido na loja.

3. Por que essa informação é útil no contexto do projeto?
   Permite mapear os clientes VIP (com maior volume de compras) para programas de fidelidade 
   e identificar clientes sem histórico de compras para disparos de campanhas promocionais.
*/