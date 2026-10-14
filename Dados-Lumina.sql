USE lumina_formulario;

-- =========================================
-- 1. 50 USUÁRIOS
-- =========================================

INSERT INTO usuario (nome, email, senha, status) VALUES
('Usuário Teste 01', 'usuario01@lumina.com', '12345678', TRUE),
('Usuário Teste 02', 'usuario02@lumina.com', '12345678', TRUE),
('Usuário Teste 03', 'usuario03@lumina.com', '12345678', TRUE),
('Usuário Teste 04', 'usuario04@lumina.com', '12345678', TRUE),
('Usuário Teste 05', 'usuario05@lumina.com', '12345678', TRUE),
('Usuário Teste 06', 'usuario06@lumina.com', '12345678', TRUE),
('Usuário Teste 07', 'usuario07@lumina.com', '12345678', TRUE),
('Usuário Teste 08', 'usuario08@lumina.com', '12345678', TRUE),
('Usuário Teste 09', 'usuario09@lumina.com', '12345678', TRUE),
('Usuário Teste 10', 'usuario10@lumina.com', '12345678', TRUE),
('Usuário Teste 11', 'usuario11@lumina.com', '12345678', TRUE),
('Usuário Teste 12', 'usuario12@lumina.com', '12345678', TRUE),
('Usuário Teste 13', 'usuario13@lumina.com', '12345678', TRUE),
('Usuário Teste 14', 'usuario14@lumina.com', '12345678', TRUE),
('Usuário Teste 15', 'usuario15@lumina.com', '12345678', TRUE),
('Usuário Teste 16', 'usuario16@lumina.com', '12345678', TRUE),
('Usuário Teste 17', 'usuario17@lumina.com', '12345678', TRUE),
('Usuário Teste 18', 'usuario18@lumina.com', '12345678', TRUE),
('Usuário Teste 19', 'usuario19@lumina.com', '12345678', TRUE),
('Usuário Teste 20', 'usuario20@lumina.com', '12345678', TRUE),
('Usuário Teste 21', 'usuario21@lumina.com', '12345678', TRUE),
('Usuário Teste 22', 'usuario22@lumina.com', '12345678', TRUE),
('Usuário Teste 23', 'usuario23@lumina.com', '12345678', TRUE),
('Usuário Teste 24', 'usuario24@lumina.com', '12345678', TRUE),
('Usuário Teste 25', 'usuario25@lumina.com', '12345678', TRUE),
('Usuário Teste 26', 'usuario26@lumina.com', '12345678', TRUE),
('Usuário Teste 27', 'usuario27@lumina.com', '12345678', TRUE),
('Usuário Teste 28', 'usuario28@lumina.com', '12345678', TRUE),
('Usuário Teste 29', 'usuario29@lumina.com', '12345678', TRUE),
('Usuário Teste 30', 'usuario30@lumina.com', '12345678', TRUE),
('Usuário Teste 31', 'usuario31@lumina.com', '12345678', TRUE),
('Usuário Teste 32', 'usuario32@lumina.com', '12345678', TRUE),
('Usuário Teste 33', 'usuario33@lumina.com', '12345678', TRUE),
('Usuário Teste 34', 'usuario34@lumina.com', '12345678', TRUE),
('Usuário Teste 35', 'usuario35@lumina.com', '12345678', TRUE),
('Usuário Teste 36', 'usuario36@lumina.com', '12345678', TRUE),
('Usuário Teste 37', 'usuario37@lumina.com', '12345678', TRUE),
('Usuário Teste 38', 'usuario38@lumina.com', '12345678', TRUE),
('Usuário Teste 39', 'usuario39@lumina.com', '12345678', TRUE),
('Usuário Teste 40', 'usuario40@lumina.com', '12345678', TRUE),
('Usuário Teste 41', 'usuario41@lumina.com', '12345678', TRUE),
('Usuário Teste 42', 'usuario42@lumina.com', '12345678', TRUE),
('Usuário Teste 43', 'usuario43@lumina.com', '12345678', TRUE),
('Usuário Teste 44', 'usuario44@lumina.com', '12345678', TRUE),
('Usuário Teste 45', 'usuario45@lumina.com', '12345678', TRUE),
('Usuário Teste 46', 'usuario46@lumina.com', '12345678', TRUE),
('Usuário Teste 47', 'usuario47@lumina.com', '12345678', TRUE),
('Usuário Teste 48', 'usuario48@lumina.com', '12345678', TRUE),
('Usuário Teste 49', 'usuario49@lumina.com', '12345678', TRUE),
('Usuário Teste 50', 'usuario50@lumina.com', '12345678', TRUE);

-- =========================================
-- 2. 50 CLIENTES
-- =========================================

INSERT INTO clientes (id_usuario) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50);

-- =========================================
-- 3. 50 TELEFONES
-- =========================================

INSERT INTO telefone (id_usuario, numero, tipo) VALUES
(1, '11990000001', 'CELULAR'),
(2, '11990000002', 'CELULAR'),
(3, '11990000003', 'CELULAR'),
(4, '11990000004', 'CELULAR'),
(5, '11990000005', 'CELULAR'),
(6, '11990000006', 'CELULAR'),
(7, '11990000007', 'CELULAR'),
(8, '11990000008', 'CELULAR'),
(9, '11990000009', 'CELULAR'),
(10, '11990000010', 'CELULAR'),
(11, '11990000011', 'CELULAR'),
(12, '11990000012', 'CELULAR'),
(13, '11990000013', 'CELULAR'),
(14, '11990000014', 'CELULAR'),
(15, '11990000015', 'CELULAR'),
(16, '11990000016', 'CELULAR'),
(17, '11990000017', 'CELULAR'),
(18, '11990000018', 'CELULAR'),
(19, '11990000019', 'CELULAR'),
(20, '11990000020', 'CELULAR'),
(21, '11990000021', 'CELULAR'),
(22, '11990000022', 'CELULAR'),
(23, '11990000023', 'CELULAR'),
(24, '11990000024', 'CELULAR'),
(25, '11990000025', 'CELULAR'),
(26, '11990000026', 'CELULAR'),
(27, '11990000027', 'CELULAR'),
(28, '11990000028', 'CELULAR'),
(29, '11990000029', 'CELULAR'),
(30, '11990000030', 'CELULAR'),
(31, '11990000031', 'CELULAR'),
(32, '11990000032', 'CELULAR'),
(33, '11990000033', 'CELULAR'),
(34, '11990000034', 'CELULAR'),
(35, '11990000035', 'CELULAR'),
(36, '11990000036', 'CELULAR'),
(37, '11990000037', 'CELULAR'),
(38, '11990000038', 'CELULAR'),
(39, '11990000039', 'CELULAR'),
(40, '11990000040', 'CELULAR'),
(41, '11990000041', 'CELULAR'),
(42, '11990000042', 'CELULAR'),
(43, '11990000043', 'CELULAR'),
(44, '11990000044', 'CELULAR'),
(45, '11990000045', 'CELULAR'),
(46, '11990000046', 'CELULAR'),
(47, '11990000047', 'CELULAR'),
(48, '11990000048', 'CELULAR'),
(49, '11990000049', 'CELULAR'),
(50, '11990000050', 'CELULAR');

INSERT INTO pedidos
(cliente_id, data_pedido, endereco_entrega, total_pedido)
VALUES
(1,  '2026-09-25 10:15:00', 'Rua das Flores, 100 - São Paulo/SP', 159.80),
(2,  '2026-09-25 14:30:00', 'Av. Paulista, 500 - São Paulo/SP', 229.90),
(3,  '2026-09-26 09:45:00', 'Rua Augusta, 250 - São Paulo/SP', 119.90),
(4,  '2026-09-26 16:20:00', 'Rua Oscar Freire, 300 - São Paulo/SP', 349.80),
(5,  '2026-09-27 11:10:00', 'Av. Ibirapuera, 800 - São Paulo/SP', 199.90),
(6,  '2026-09-27 18:40:00', 'Rua Vergueiro, 450 - São Paulo/SP', 279.70),
(7,  '2026-09-28 13:25:00', 'Rua Consolação, 700 - São Paulo/SP', 89.90),
(8,  '2026-09-29 15:50:00', 'Av. Brigadeiro Faria Lima, 900 - São Paulo/SP', 419.60),
(9,  '2026-09-30 10:05:00', 'Rua Haddock Lobo, 150 - São Paulo/SP', 149.90),
(10, '2026-10-01 17:15:00', 'Av. Rebouças, 600 - São Paulo/SP', 299.80);


-- =========================================
-- ITENS DOS PEDIDOS
-- =========================================
-- OBSERVAÇÃO:
-- Estes itens precisam de produtos cadastrados.
-- Os INSERTs abaixo assumem que existem produtos
-- com produto_id de 1 a 10.


INSERT INTO itens_pedido
(pedido_id, produto_id, preco_unitario, quantidade, subtotal)
VALUES
(1,  1, 79.90, 2, 159.80),
(2,  2, 114.95, 2, 229.90),
(3, 3, 119.90, 1, 119.90),
(4, 4, 174.90, 2, 349.80),
(5, 5, 199.90, 1, 199.90),
(6, 6, 139.85, 2, 279.70),
(7, 7, 89.90, 1, 89.90),
(8, 8, 209.80, 2, 419.60),
(9, 9, 149.90, 1, 149.90),
(10, 10, 149.90, 2, 299.80);


-- =========================================
-- PAGAMENTOS DOS 10 PEDIDOS
-- =========================================

INSERT INTO pagamentos
(pedido_id, valor_pedido, forma_pagamento, status_pagamento)
VALUES
(1,  159.80, 'PIX',             'APROVADO'),
(2,  229.90, 'CARTAO_CREDITO', 'APROVADO'),
(3,  119.90, 'PIX',             'APROVADO'),
(4,  349.80, 'CARTAO_CREDITO', 'APROVADO'),
(5,  199.90, 'PIX',             'APROVADO'),
(6,  279.70, 'CARTAO_DEBITO',  'APROVADO'),
(7,   89.90, 'PIX',             'APROVADO'),
(8,  419.60, 'CARTAO_CREDITO', 'APROVADO'),
(9,  149.90, 'PIX',             'APROVADO'),
(10, 299.80, 'CARTAO_CREDITO', 'APROVADO');

USE lumina_formulario;

INSERT INTO clientes (id_usuario)
SELECT id_usuario
FROM usuario
WHERE id_usuario NOT IN (
    SELECT id_usuario
    FROM clientes
);
INSERT INTO pedidos
(cliente_id, data_pedido, endereco_entrega, total_pedido)
VALUES
(1, '2026-09-25 10:15:00', 'Rua das Flores, 100 - São Paulo/SP', 159.80),
(2, '2026-09-25 14:30:00', 'Av. Paulista, 500 - São Paulo/SP', 229.90),
(3, '2026-09-26 09:45:00', 'Rua Augusta, 250 - São Paulo/SP', 119.90),
(4, '2026-09-26 16:20:00', 'Rua Oscar Freire, 300 - São Paulo/SP', 349.80),
(5, '2026-09-27 11:10:00', 'Av. Ibirapuera, 800 - São Paulo/SP', 199.90),
(6, '2026-09-27 18:40:00', 'Rua Vergueiro, 450 - São Paulo/SP', 279.70),
(7, '2026-09-28 13:25:00', 'Rua Consolação, 700 - São Paulo/SP', 89.90),
(8, '2026-09-29 15:50:00', 'Av. Brigadeiro Faria Lima, 900 - São Paulo/SP', 419.60),
(9, '2026-09-30 10:05:00', 'Rua Haddock Lobo, 150 - São Paulo/SP', 149.90),
(10, '2026-10-01 17:15:00', 'Av. Rebouças, 600 - São Paulo/SP', 299.80);


INSERT INTO categoria (nome, descricao) VALUES
('Camisetas', 'Camisetas femininas e masculinas'),
('Calças', 'Calças jeans e modelos casuais'),
('Vestidos', 'Vestidos femininos'),
('Blusas', 'Blusas e croppeds'),
('Casacos', 'Casacos e jaquetas');

INSERT INTO produtos
(id_categoria, nome, preco, estoque)
VALUES
(1, 'Camiseta Básica Lumina', 79.90, 50),
(1, 'Camiseta Oversized Lumina', 114.95, 40),
(2, 'Calça Jeans Feminina', 119.90, 30),
(3, 'Vestido Casual Lumina', 174.90, 25),
(4, 'Blusa Elegante Lumina', 199.90, 20),
(2, 'Calça Wide Leg', 139.85, 35),
(4, 'Cropped Lumina', 89.90, 45),
(5, 'Jaqueta Jeans Lumina', 209.80, 15),
(3, 'Vestido Floral Lumina', 149.90, 25),
(5, 'Casaco Feminino Lumina', 149.90, 20);

INSERT INTO itens_pedido
(pedido_id, produto_id, preco_unitario, quantidade, subtotal)
VALUES
(1, 1, 79.90, 2, 159.80),
(2, 2, 114.95, 2, 229.90),
(3, 3, 119.90, 1, 119.90),
(4, 4, 174.90, 2, 349.80),
(5, 5, 199.90, 1, 199.90),
(6, 6, 139.85, 2, 279.70),
(7, 7, 89.90, 1, 89.90),
(8, 8, 209.80, 2, 419.60),
(9, 9, 149.90, 1, 149.90),
(10, 10, 149.90, 2, 299.80);

USE lumina_formulario;

INSERT INTO lote (produto_id, codigo_lote, quantidade, data_entrada)
VALUES 
    (1, 'LOT-CAMISA-001', 100, '2026-01-10'),
    (1, 'LOT-CAMISA-002',  50, '2026-02-15'),
    (2, 'LOT-CALCA-001',   80, '2026-03-01'),
    (3, 'LOT-JAQUETA-001', 30, '2026-03-10');
    

USE lumina_formulario;

-- =========================================
-- PEDIDOS PARA OS CLIENTES 11 A 50
-- =========================================
INSERT INTO pedidos (cliente_id, data_pedido, endereco_entrega, total_pedido) VALUES
(11, '2026-10-02 08:30:00', 'Rua Augusta, 101 - São Paulo/SP', 79.90),
(12, '2026-10-02 09:15:00', 'Av. Paulista, 102 - São Paulo/SP', 114.95),
(13, '2026-10-02 10:00:00', 'Rua Oscar Freire, 103 - São Paulo/SP', 119.90),
(14, '2026-10-02 11:45:00', 'Av. Brigadeiro Faria Lima, 104 - São Paulo/SP', 174.90),
(15, '2026-10-02 12:20:00', 'Rua Vergueiro, 105 - São Paulo/SP', 199.90),
(16, '2026-10-02 13:10:00', 'Av. Rebouças, 106 - São Paulo/SP', 139.85),
(17, '2026-10-02 14:05:00', 'Rua Consolação, 107 - São Paulo/SP', 89.90),
(18, '2026-10-02 15:30:00', 'Rua Haddock Lobo, 108 - São Paulo/SP', 209.80),
(19, '2026-10-02 16:15:00', 'Av. Ibirapuera, 109 - São Paulo/SP', 149.90),
(20, '2026-10-02 17:00:00', 'Rua das Flores, 110 - São Paulo/SP', 149.90),
(21, '2026-10-03 08:00:00', 'Rua Augusta, 111 - São Paulo/SP', 79.90),
(22, '2026-10-03 09:10:00', 'Av. Paulista, 112 - São Paulo/SP', 114.95),
(23, '2026-10-03 10:25:00', 'Rua Oscar Freire, 113 - São Paulo/SP', 119.90),
(24, '2026-10-03 11:30:00', 'Av. Brigadeiro Faria Lima, 114 - São Paulo/SP', 174.90),
(25, '2026-10-03 12:50:00', 'Rua Vergueiro, 115 - São Paulo/SP', 199.90),
(26, '2026-10-03 13:40:00', 'Av. Rebouças, 116 - São Paulo/SP', 139.85),
(27, '2026-10-03 14:15:00', 'Rua Consolação, 117 - São Paulo/SP', 89.90),
(28, '2026-10-03 15:00:00', 'Rua Haddock Lobo, 118 - São Paulo/SP', 209.80),
(29, '2026-10-03 16:20:00', 'Av. Ibirapuera, 119 - São Paulo/SP', 149.90),
(30, '2026-10-03 17:45:00', 'Rua das Flores, 120 - São Paulo/SP', 149.90),
(31, '2026-10-04 08:45:00', 'Rua Augusta, 121 - São Paulo/SP', 79.90),
(32, '2026-10-04 09:30:00', 'Av. Paulista, 122 - São Paulo/SP', 114.95),
(33, '2026-10-04 10:15:00', 'Rua Oscar Freire, 123 - São Paulo/SP', 119.90),
(34, '2026-10-04 11:00:00', 'Av. Brigadeiro Faria Lima, 124 - São Paulo/SP', 174.90),
(35, '2026-10-04 12:30:00', 'Rua Vergueiro, 125 - São Paulo/SP', 199.90),
(36, '2026-10-04 13:15:00', 'Av. Rebouças, 126 - São Paulo/SP', 139.85),
(37, '2026-10-04 14:40:00', 'Rua Consolação, 127 - São Paulo/SP', 89.90),
(38, '2026-10-04 15:55:00', 'Rua Haddock Lobo, 128 - São Paulo/SP', 209.80),
(39, '2026-10-04 16:35:00', 'Av. Ibirapuera, 129 - São Paulo/SP', 149.90),
(40, '2026-10-04 17:10:00', 'Rua das Flores, 130 - São Paulo/SP', 149.90),
(41, '2026-10-05 08:10:00', 'Rua Augusta, 131 - São Paulo/SP', 79.90),
(42, '2026-10-05 09:25:00', 'Av. Paulista, 132 - São Paulo/SP', 114.95),
(43, '2026-10-05 10:40:00', 'Rua Oscar Freire, 133 - São Paulo/SP', 119.90),
(44, '2026-10-05 11:50:00', 'Av. Brigadeiro Faria Lima, 134 - São Paulo/SP', 174.90),
(45, '2026-10-05 12:15:00', 'Rua Vergueiro, 135 - São Paulo/SP', 199.90),
(46, '2026-10-05 13:05:00', 'Av. Rebouças, 136 - São Paulo/SP', 139.85),
(47, '2026-10-05 14:20:00', 'Rua Consolação, 137 - São Paulo/SP', 89.90),
(48, '2026-10-05 15:10:00', 'Rua Haddock Lobo, 138 - São Paulo/SP', 209.80),
(49, '2026-10-05 16:00:00', 'Av. Ibirapuera, 139 - São Paulo/SP', 149.90),
(50, '2026-10-05 17:30:00', 'Rua das Flores, 140 - São Paulo/SP', 149.90);

-- =========================================
-- ITENS DOS PEDIDOS (PEDIDOS 11 A 50)
-- =========================================
INSERT INTO itens_pedido (pedido_id, produto_id, preco_unitario, quantidade, subtotal) VALUES
(11, 1, 79.90, 1, 79.90),
(12, 2, 114.95, 1, 114.95),
(13, 3, 119.90, 1, 119.90),
(14, 4, 174.90, 1, 174.90),
(15, 5, 199.90, 1, 199.90),
(16, 6, 139.85, 1, 139.85),
(17, 7, 89.90, 1, 89.90),
(18, 8, 209.80, 1, 209.80),
(19, 9, 149.90, 1, 149.90),
(20, 10, 149.90, 1, 149.90),
(21, 1, 79.90, 1, 79.90),
(22, 2, 114.95, 1, 114.95),
(23, 3, 119.90, 1, 119.90),
(24, 4, 174.90, 1, 174.90),
(25, 5, 199.90, 1, 199.90),
(26, 6, 139.85, 1, 139.85),
(27, 7, 89.90, 1, 89.90),
(28, 8, 209.80, 1, 209.80),
(29, 9, 149.90, 1, 149.90),
(30, 10, 149.90, 1, 149.90),
(31, 1, 79.90, 1, 79.90),
(32, 2, 114.95, 1, 114.95),
(33, 3, 119.90, 1, 119.90),
(34, 4, 174.90, 1, 174.90),
(35, 5, 199.90, 1, 199.90),
(36, 6, 139.85, 1, 139.85),
(37, 7, 89.90, 1, 89.90),
(38, 8, 209.80, 1, 209.80),
(39, 9, 149.90, 1, 149.90),
(40, 10, 149.90, 1, 149.90),
(41, 1, 79.90, 1, 79.90),
(42, 2, 114.95, 1, 114.95),
(43, 3, 119.90, 1, 119.90),
(44, 4, 174.90, 1, 174.90),
(45, 5, 199.90, 1, 199.90),
(46, 6, 139.85, 1, 139.85),
(47, 7, 89.90, 1, 89.90),
(48, 8, 209.80, 1, 209.80),
(49, 9, 149.90, 1, 149.90),
(50, 10, 149.90, 1, 149.90);

-- =========================================
-- PAGAMENTOS DOS PEDIDOS 11 A 50
-- =========================================
INSERT INTO pagamentos (pedido_id, valor_pedido, forma_pagamento, status_pagamento) VALUES
(11, 79.90, 'PIX', 'APROVADO'),
(12, 114.95, 'CARTAO_CREDITO', 'APROVADO'),
(13, 119.90, 'PIX', 'APROVADO'),
(14, 174.90, 'CARTAO_CREDITO', 'APROVADO'),
(15, 199.90, 'PIX', 'APROVADO'),
(16, 139.85, 'CARTAO_DEBITO', 'APROVADO'),
(17, 89.90, 'PIX', 'APROVADO'),
(18, 209.80, 'CARTAO_CREDITO', 'APROVADO'),
(19, 149.90, 'PIX', 'APROVADO'),
(20, 149.90, 'CARTAO_CREDITO', 'APROVADO'),
(21, 79.90, 'PIX', 'APROVADO'),
(22, 114.95, 'CARTAO_CREDITO', 'APROVADO'),
(23, 119.90, 'PIX', 'APROVADO'),
(24, 174.90, 'CARTAO_CREDITO', 'APROVADO'),
(25, 199.90, 'PIX', 'APROVADO'),
(26, 139.85, 'CARTAO_DEBITO', 'APROVADO'),
(27, 89.90, 'PIX', 'APROVADO'),
(28, 209.80, 'CARTAO_CREDITO', 'APROVADO'),
(29, 149.90, 'PIX', 'APROVADO'),
(30, 149.90, 'CARTAO_CREDITO', 'APROVADO'),
(31, 79.90, 'PIX', 'APROVADO'),
(32, 114.95, 'CARTAO_CREDITO', 'APROVADO'),
(33, 119.90, 'PIX', 'APROVADO'),
(34, 174.90, 'CARTAO_CREDITO', 'APROVADO'),
(35, 199.90, 'PIX', 'APROVADO'),
(36, 139.85, 'CARTAO_DEBITO', 'APROVADO'),
(37, 89.90, 'PIX', 'APROVADO'),
(38, 209.80, 'CARTAO_CREDITO', 'APROVADO'),
(39, 149.90, 'PIX', 'APROVADO'),
(40, 149.90, 'CARTAO_CREDITO', 'APROVADO'),
(41, 79.90, 'PIX', 'APROVADO'),
(42, 114.95, 'CARTAO_CREDITO', 'APROVADO'),
(43, 119.90, 'PIX', 'APROVADO'),
(44, 174.90, 'CARTAO_CREDITO', 'APROVADO'),
(45, 199.90, 'PIX', 'APROVADO'),
(46, 139.85, 'CARTAO_DEBITO', 'APROVADO'),
(47, 89.90, 'PIX', 'APROVADO'),
(48, 209.80, 'CARTAO_CREDITO', 'APROVADO'),
(49, 149.90, 'PIX', 'APROVADO'),
(50, 149.90, 'CARTAO_CREDITO', 'APROVADO');

USE lumina_formulario;

-- =========================================
-- INSERIR NOVAS CATEGORIAS (APENAS ROUPAS)
-- =========================================

INSERT INTO categoria (nome, descricao) VALUES
('Regatas e Tops', 'Regatas casuais, regatas cavadas e tops femininos'),
('Moletons e Blusões', 'Blusões de moletom com e sem capuz'),
('Kimonos e Cardigans', 'Kimonos leves, cardigans de tricot e sobreposições'),
('Shorts e Bermudas', 'Shorts jeans, alfaiataria e bermudas casuais'),
('Saias', 'Saias curtas, midi e longas'),
('Macacões e Jardineiras', 'Macacões longos, macaquinhos e jardineiras'),
('Conjuntos', 'Conjuntos coordenados de blusa e calça ou saia'),
('Moda Alfaiataria', 'Blazers, calças sociais e coletes alinhados'),
('Moda Fitness (Vestuário)', 'Leggings, shorts de treino e camisetas respiráveis'),
('Moda Praia (Vestuário)', 'Saídas de praia, chemises e canga-vestidos');

USE lumina_formulario;
SELECT id_categoria, nome FROM categoria;

USE lumina_formulario;

-- ============================================================================
-- 1. INSERIR PRODUTOS USANDO OS IDs DA SUA IMAGEM
-- ============================================================================
INSERT INTO produtos (id_categoria, nome, preco, estoque) VALUES
(22, 'Regata Básica Canelada', 59.90, 60),          -- Regatas e Tops
(23, 'Moletom Flanelado com Capuz', 189.90, 30),    -- Moletons e Blusões
(24, 'Cardigan Alongado de Tricot', 129.90, 40),    -- Kimonos e Cardigans
(25, 'Short Jeans Cintura Alta', 99.90, 50),       -- Shorts e Bermudas
(26, 'Saia Midi Evasê', 119.90, 35),               -- Saias
(27, 'Macacão Pantalona Linho', 219.90, 20),       -- Macacões e Jardineiras
(28, 'Conjunto Soft Blusa e Calça', 159.90, 25),   -- Conjuntos
(29, 'Blazer Alfaiataria Feminino', 249.90, 15),   -- Moda Alfaiataria
(30, 'Legging Fitness Suplex', 89.90, 50),          -- Moda Fitness (Vestuário)
(31, 'Chemise Saida de Praia', 139.90, 30);        -- Moda Praia (Vestuário)


-- ============================================================================
-- 2. INSERIR PEDIDOS PARA OS 20 CLIENTES (IDs 51 a 70)
-- ============================================================================
INSERT INTO pedidos (cliente_id, data_pedido, endereco_entrega, total_pedido) VALUES
(51, '2026-10-06 09:10:00', 'Rua Augusta, 201 - São Paulo/SP', 59.90),
(52, '2026-10-06 10:15:00', 'Av. Paulista, 202 - São Paulo/SP', 189.90),
(53, '2026-10-06 11:30:00', 'Rua Oscar Freire, 203 - São Paulo/SP', 129.90),
(54, '2026-10-06 13:00:00', 'Av. Brigadeiro Faria Lima, 204 - São Paulo/SP', 99.90),
(55, '2026-10-06 14:20:00', 'Rua Vergueiro, 205 - São Paulo/SP', 119.90),
(56, '2026-10-06 15:45:00', 'Av. Rebouças, 206 - São Paulo/SP', 219.90),
(57, '2026-10-06 16:10:00', 'Rua Consolação, 207 - São Paulo/SP', 159.90),
(58, '2026-10-06 17:30:00', 'Rua Haddock Lobo, 208 - São Paulo/SP', 249.90),
(59, '2026-10-07 08:50:00', 'Av. Ibirapuera, 209 - São Paulo/SP', 89.90),
(60, '2026-10-07 09:40:00', 'Rua das Flores, 210 - São Paulo/SP', 139.90),
(61, '2026-10-07 10:25:00', 'Rua Augusta, 211 - São Paulo/SP', 59.90),
(62, '2026-10-07 11:15:00', 'Av. Paulista, 212 - São Paulo/SP', 189.90),
(63, '2026-10-07 12:40:00', 'Rua Oscar Freire, 213 - São Paulo/SP', 129.90),
(64, '2026-10-07 14:00:00', 'Av. Brigadeiro Faria Lima, 214 - São Paulo/SP', 99.90),
(65, '2026-10-07 15:10:00', 'Rua Vergueiro, 215 - São Paulo/SP', 119.90),
(66, '2026-10-07 16:30:00', 'Av. Rebouças, 216 - São Paulo/SP', 219.90),
(67, '2026-10-07 17:05:00', 'Rua Consolação, 217 - São Paulo/SP', 159.90),
(68, '2026-10-08 09:00:00', 'Rua Haddock Lobo, 218 - São Paulo/SP', 249.90),
(69, '2026-10-08 10:35:00', 'Av. Ibirapuera, 219 - São Paulo/SP', 89.90),
(70, '2026-10-08 11:50:00', 'Rua das Flores, 220 - São Paulo/SP', 139.90);


-- ============================================================================
-- 3. INSERIR ITENS DOS PEDIDOS (PEDIDOS 51 A 70)
-- Os produtos recém-inseridos assumirão os produto_id de 11 a 20
-- ============================================================================
INSERT INTO itens_pedido (pedido_id, produto_id, preco_unitario, quantidade, subtotal) VALUES
(51, 11, 59.90, 1, 59.90),
(52, 12, 189.90, 1, 189.90),
(53, 13, 129.90, 1, 129.90),
(54, 14, 99.90, 1, 99.90),
(55, 15, 119.90, 1, 119.90),
(56, 16, 219.90, 1, 219.90),
(57, 17, 159.90, 1, 159.90),
(58, 18, 249.90, 1, 249.90),
(59, 19, 89.90, 1, 89.90),
(60, 20, 139.90, 1, 139.90),
(61, 11, 59.90, 1, 59.90),
(62, 12, 189.90, 1, 189.90),
(63, 13, 129.90, 1, 129.90),
(64, 14, 99.90, 1, 99.90),
(65, 15, 119.90, 1, 119.90),
(66, 16, 219.90, 1, 219.90),
(67, 17, 159.90, 1, 159.90),
(68, 18, 249.90, 1, 249.90),
(69, 19, 89.90, 1, 89.90),
(70, 20, 139.90, 1, 139.90);


-- ============================================================================
-- 4. INSERIR PAGAMENTOS DOS PEDIDOS (PEDIDOS 51 A 70)
-- ============================================================================
INSERT INTO pagamentos (pedido_id, valor_pedido, forma_pagamento, status_pagamento) VALUES
(51, 59.90, 'PIX', 'APROVADO'),
(52, 189.90, 'CARTAO_CREDITO', 'APROVADO'),
(53, 129.90, 'PIX', 'APROVADO'),
(54, 99.90, 'CARTAO_CREDITO', 'APROVADO'),
(55, 119.90, 'PIX', 'APROVADO'),
(56, 219.90, 'CARTAO_DEBITO', 'APROVADO'),
(57, 159.90, 'PIX', 'APROVADO'),
(58, 249.90, 'CARTAO_CREDITO', 'APROVADO'),
(59, 89.90, 'PIX', 'APROVADO'),
(60, 139.90, 'CARTAO_CREDITO', 'APROVADO'),
(61, 59.90, 'PIX', 'APROVADO'),
(62, 189.90, 'CARTAO_CREDITO', 'APROVADO'),
(63, 129.90, 'PIX', 'APROVADO'),
(64, 99.90, 'CARTAO_CREDITO', 'APROVADO'),
(65, 119.90, 'PIX', 'APROVADO'),
(66, 219.90, 'CARTAO_DEBITO', 'APROVADO'),
(67, 159.90, 'PIX', 'APROVADO'),
(68, 249.90, 'CARTAO_CREDITO', 'APROVADO'),
(69, 89.90, 'PIX', 'APROVADO'),
(70, 139.90, 'CARTAO_CREDITO', 'APROVADO');

USE lumina_formulario;

-- ============================================================================
-- INSERIR ITENS DO PEDIDO DE FORMA DINÂMICA
-- ============================================================================
INSERT INTO itens_pedido (pedido_id, produto_id, preco_unitario, quantidade, subtotal)
SELECT 
    p.pedido_id,
    prod.produto_id,
    prod.preco,
    1 AS quantidade,
    prod.preco AS subtotal
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.cliente_id
JOIN produtos prod ON prod.nome = CASE c.cliente_id
    WHEN 51 THEN 'Regata Básica Canelada'
    WHEN 52 THEN 'Moletom Flanelado com Capuz'
    WHEN 53 THEN 'Cardigan Alongado de Tricot'
    WHEN 54 THEN 'Short Jeans Cintura Alta'
    WHEN 55 THEN 'Saia Midi Evasê'
    WHEN 56 THEN 'Macacão Pantalona Linho'
    WHEN 57 THEN 'Conjunto Soft Blusa e Calça'
    WHEN 58 THEN 'Blazer Alfaiataria Feminino'
    WHEN 59 THEN 'Legging Fitness Suplex'
    WHEN 60 THEN 'Chemise Saida de Praia'
    WHEN 61 THEN 'Regata Básica Canelada'
    WHEN 62 THEN 'Moletom Flanelado com Capuz'
    WHEN 63 THEN 'Cardigan Alongado de Tricot'
    WHEN 64 THEN 'Short Jeans Cintura Alta'
    WHEN 65 THEN 'Saia Midi Evasê'
    WHEN 66 THEN 'Macacão Pantalona Linho'
    WHEN 67 THEN 'Conjunto Soft Blusa e Calça'
    WHEN 68 THEN 'Blazer Alfaiataria Feminino'
    WHEN 69 THEN 'Legging Fitness Suplex'
    WHEN 70 THEN 'Chemise Saida de Praia'
END
WHERE c.cliente_id BETWEEN 51 AND 70;


-- ============================================================================
-- INSERIR PAGAMENTOS DOS PEDIDOS (PEDIDOS 51 A 70)
-- ============================================================================
INSERT INTO pagamentos (pedido_id, valor_pedido, forma_pagamento, status_pagamento)
SELECT 
    p.pedido_id,
    p.total_pedido,
    IF(p.pedido_id % 2 = 0, 'CARTAO_CREDITO', 'PIX') AS forma_pagamento,
    'APROVADO' AS status_pagamento
FROM pedidos p
WHERE p.cliente_id BETWEEN 51 AND 70
  AND p.pedido_id NOT IN (SELECT pedido_id FROM pagamentos);
