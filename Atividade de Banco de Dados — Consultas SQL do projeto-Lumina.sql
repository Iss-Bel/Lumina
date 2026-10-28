USE lumina_formulario;

-- ============================================================================
-- CONSULTA 1: Funções de Data (DATEDIFF e DATE_FORMAT)
-- Tabela: reembolso
-- Objetivo: Medir o tempo de processamento dos reembolsos concluídos
-- ============================================================================
SELECT 
    id_reembolso,
    pedido_id,
    valor,
    DATE_FORMAT(data_solicitacao, '%d/%m/%Y %H:%i') AS data_solicitacao_formatada,
    DATE_FORMAT(data_reembolso, '%d/%m/%Y %H:%i') AS data_reembolso_formatada,
    DATEDIFF(data_reembolso, data_solicitacao) AS dias_para_processamento
FROM reembolso
WHERE status = 'CONCLUIDO';

-- ============================================================================
-- CONSULTA 2: Funções de Texto (TRIM, UPPER, LOWER, CONCAT, CHAR_LENGTH)
-- Tabela: usuario
-- Objetivo: Padronizar cadastros e gerar cabeçalhos de notificação
-- ============================================================================
SELECT 
    id_usuario,
    UPPER(TRIM(nome)) AS nome_maiusculo,
    LOWER(TRIM(email)) AS email_padronizado,
    CONCAT(UPPER(TRIM(nome)), ' <', LOWER(TRIM(email)), '>') AS cabecalho_contato,
    CHAR_LENGTH(TRIM(nome)) AS tamanho_nome
FROM usuario;

-- ============================================================================
-- CONSULTA 3: Verificação de Inconsistência nos Dados (Auditoria)
-- Tabela: reembolso
-- Objetivo: Identificar reembolsos "CONCLUIDO" sem data de finalização
-- ============================================================================
SELECT 
    id_reembolso,
    pedido_id,
    status,
    data_solicitacao,
    data_reembolso
FROM reembolso
WHERE status = 'CONCLUIDO' 
  AND data_reembolso IS NULL;