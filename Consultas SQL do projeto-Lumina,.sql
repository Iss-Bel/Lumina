-- ============================================================================
-- CONSULTAS SQL PARA O PROJETO LUMINA
-- Aplicação de Funções de Data, Texto e Auditoria no MySQL
-- ============================================================================

USE lumina_formulario;

-- ----------------------------------------------------------------------------
-- TAREFA 1: Consulta com Funções de Data
-- Objetivo: Formatar a data do pedido para o padrão brasileiro e calcular
-- o número de dias decorridos desde a compra.
-- ----------------------------------------------------------------------------
SELECT 
    pedido_id,
    cliente_id,
    total_pedido,
    DATE_FORMAT(data_pedido, '%d/%m/%Y %H:%i') AS data_pedido_formatada,
    DATEDIFF(CURDATE(), data_pedido) AS dias_desde_o_pedido
FROM pedidos
ORDER BY data_pedido DESC;


-- ----------------------------------------------------------------------------
-- TAREFA 2: Consulta com Funções de Texto
-- Objetivo: Tratar e padronizar os dados de registo de utilizadores (limpeza 
-- de espaços, padronização de maiúsculas/minúsculas e concatenação).
-- ----------------------------------------------------------------------------
SELECT 
    id_usuario,
    TRIM(nome) AS nome_limpo,
    UPPER(TRIM(nome)) AS nome_maiusculo,
    LOWER(TRIM(email)) AS email_normalizado,
    CONCAT(UPPER(TRIM(nome)), ' <', LOWER(TRIM(email)), '>') AS destinatario_formatado,
    CHAR_LENGTH(TRIM(nome)) AS tamanho_nome
FROM usuario;


-- ----------------------------------------------------------------------------
-- TAREFA 3: Consulta para Verificação de Inconsistências de Dados
-- Objetivo: Identificar registos com erro (datas futuras, endereços nulos/vazios
-- ou valores inválidos de pedido).
-- ----------------------------------------------------------------------------
SELECT 
    pedido_id,
    cliente_id,
    data_pedido,
    endereco_entrega,
    total_pedido,
    CASE 
        WHEN data_pedido > NOW() THEN 'Erro: Data de pedido futura'
        WHEN endereco_entrega IS NULL OR TRIM(endereco_entrega) = '' THEN 'Erro: Endereço de entrega em branco'
        WHEN total_pedido <= 0 THEN 'Erro: Valor do pedido zerado ou negativo'
        ELSE 'Inconsistência não mapeada'
    END AS motivo_inconsistencia
FROM pedidos
WHERE data_pedido > NOW()
   OR endereco_entrega IS NULL 
   OR TRIM(endereco_entrega) = ''
   OR total_pedido <= 0;
   
SELECT COUNT(*) AS total_usuarios 
FROM usuario;