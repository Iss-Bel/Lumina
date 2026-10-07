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