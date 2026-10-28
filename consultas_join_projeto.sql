
USE lumina_formulario;

-- ETAPA 1: ESCOLHA DA RELAÇÃO ENTRE TABELAS
-- 1. Tabela Principal: `clientes` (Armazena os dados dos clientes da Lumina)
-- 2. Tabela Relacionada: `pedidos` (Armazena as compras efetuadas pelos clientes)
-- 3. Ligação: Chave Primária (PK): clientes.cliente_id / Chave Estrangeira (FK): pedidos.cliente_id
-- 4. Pergunta do Sistema: "Quais clientes cadastrados ainda não realizaram nenhuma compra na Lumina?"
-- 5. Qual registro pode existir sem correspondente: Um cliente recém-cadastrado na loja pode existir na tabela `clientes` sem ter nenhum registro associado na tabela `pedidos`.

-- ETAPA 2: VERIFICAÇÃO / PREPARAÇÃO DOS DADOS DE TESTE
-- Consulta simples para verificar se já existe algum cliente sem pedidos
SELECT c.cliente_id, c.id_usuario FROM clientes c;
SELECT p.pedido_id, p.cliente_id FROM pedidos p;

-- ETAPA 3: CONSULTAS DE JUNÇÃO (JOINS)
-- 1. INNER JOIN
-- Mostra apenas os clientes que já realizaram pelo menos um pedido.
-- Mantém somente a intersecção de dados. Clientes sem pedidos NÃO aparecem aqui.
SELECT 
    c.cliente_id,
    c.id_usuario,
    p.pedido_id,
    p.data_pedido,
    p.total_pedido
FROM clientes c
INNER JOIN pedidos p 
    ON c.cliente_id = p.cliente_id;


-- 2. LEFT JOIN
-- Mostra TODOS os clientes da tabela principal (`clientes`), inclusive aqueles sem pedidos.
-- A tabela `clientes` foi mantida à esquerda. Para os clientes que ainda não fizeram pedidos, as colunas da tabela `pedidos` (pedido_id, data_pedido, total_pedido) aparecem como NULL.
SELECT 
    c.cliente_id,
    c.id_usuario,
    p.pedido_id,
    p.data_pedido,
    p.total_pedido
FROM clientes c
LEFT JOIN pedidos p 
    ON c.cliente_id = p.cliente_id;

-- 3. RIGHT JOIN
-- Inverte a ordem declarada mantendo `pedidos` à direita, mas preserva o foco invertendo a posição das tabelas.
-- Ao colocar `pedidos` à esquerda e `clientes` à direita com RIGHT JOIN, a tabela `clientes` continua sendo totalmente mantida, exibindo todos os clientes, inclusive os que possuem colunas de pedido como NULL.
SELECT 
    c.cliente_id,
    c.id_usuario,
    p.pedido_id,
    p.data_pedido,
    p.total_pedido
FROM pedidos p
RIGHT JOIN clientes c 
    ON p.cliente_id = c.cliente_id;

-- 4. REGISTROS SEM CORRESPONDÊNCIA (LEFT JOIN + IS NULL)
-- Filtra o LEFT JOIN para trazer apenas os clientes que NUNCA fizeram um pedido.
-- Utiliza IS NULL na Chave Primária da tabela relacionada (`p.pedido_id`) para filtrar e listar unicamente os cadastros de clientes da Lumina que não possuem vínculo com a tabela de pedidos.
SELECT 
    c.cliente_id,
    c.id_usuario
FROM clientes c
LEFT JOIN pedidos p 
    ON c.cliente_id = p.cliente_id
WHERE p.pedido_id IS NULL;

-- ETAPA 4: APLICAÇÃO AO PROJETO
/*
 Respostas sobre a utilidade no projeto Lumina:

 1. Onde essa informação seria útil no sistema do grupo?
    Esta informação é crucial para a equipe de Marketing/CRM e para o dashboard administrativo do e-commerce.
    Permite enviar e-mails de "Boas-vindas" ou cupons de desconto de primeira compra para clientes inativos.

 2. O que o usuário/administrador entenderia ao ver um registro sem correspondência?
    O administrador entende que aquele cliente completou o cadastro na plataforma, mas ainda não se 
    converteu em comprador (leads/cadastros sem conversão em vendas).

 3. Qual das consultas vocês usariam para atender a essa necessidade?
    A consulta 4 (LEFT JOIN com filtro `p.pedido_id IS NULL`), pois traz exatamente a lista limpa 
    de clientes que precisam de uma ação de engajamento da equipe para realizarem sua primeira compra.
*/
