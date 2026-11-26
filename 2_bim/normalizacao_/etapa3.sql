-- NORMALIZAÇÃO — PARTE 7: 

/* ETAPA 1 

Chave primária original: (id_pedido, id_produto).
Dependências funcionais relevantes:
- id_pedido -> data_pedido, id_cliente.
- id_cliente -> nome_cliente, telefone_cliente.
- id_produto -> nome_produto, preco_atual_produto.
- (id_pedido, id_produto) -> quantidade, preco_unitario_venda.

Dependências parciais:
- data_pedido e id_cliente dependem apenas de id_pedido.
- nome_produto e preco_atual_produto dependem apenas de id_produto.

Dependência transitiva:
- a partir da chave composta, id_pedido determina id_cliente, que determina
  nome_cliente e telefone_cliente.

A relação viola a 2FN porque há atributos que dependem de apenas parte da chave
composta. Também viola a 3FN pela dependência transitiva dos dados do cliente.

Modelo final em 3FN:
CLIENTE(id_cliente PK, nome_cliente, telefone_cliente)
PRODUTO(id_produto PK, nome_produto, preco_atual_produto)
PEDIDO(id_pedido PK, data_pedido, id_cliente FK)
ITEM_PEDIDO(id_pedido PK/FK, id_produto PK/FK, quantidade, preco_unitario_venda)

Cardinalidades:
- CLIENTE 1:N PEDIDO.
- PEDIDO N:N PRODUTO, resolvido pela tabela ITEM_PEDIDO.
- PEDIDO 1:N ITEM_PEDIDO e PRODUTO 1:N ITEM_PEDIDO.

O preco_unitario_venda é armazenado no item porque representa o valor cobrado
naquela compra. Ele não deve ser substituído quando o preço cadastral atual do
produto mudar: assim, o histórico da venda permanece correto.
*/

CREATE TABLE IF NOT EXISTS norm_ex13_cliente (
    id_cliente BIGINT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    telefone_cliente VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS norm_ex13_produto (
    id_produto BIGINT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL UNIQUE,
    preco_atual_produto NUMERIC(10,2) NOT NULL CHECK (preco_atual_produto >= 0)
);

CREATE TABLE IF NOT EXISTS norm_ex13_pedido (
    id_pedido BIGINT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    id_cliente BIGINT NOT NULL,
    CONSTRAINT fk_norm_ex13_pedido_cliente
        FOREIGN KEY (id_cliente) REFERENCES norm_ex13_cliente(id_cliente)
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS norm_ex13_item_pedido (
    id_pedido BIGINT NOT NULL,
    id_produto BIGINT NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario_venda NUMERIC(10,2) NOT NULL CHECK (preco_unitario_venda >= 0),
    CONSTRAINT pk_norm_ex13_item_pedido PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_norm_ex13_item_pedido_pedido
        FOREIGN KEY (id_pedido) REFERENCES norm_ex13_pedido(id_pedido)
        ON DELETE CASCADE,
    CONSTRAINT fk_norm_ex13_item_pedido_produto
        FOREIGN KEY (id_produto) REFERENCES norm_ex13_produto(id_produto)
        ON DELETE RESTRICT
);

-- q) Cadastre três clientes.
INSERT INTO norm_ex13_cliente (id_cliente, nome_cliente, telefone_cliente)
VALUES
    (1, 'Ana',   '4499999-1111'),
    (2, 'Bruno', '4499999-2222'),
    (3, 'Carla', '4499999-3333')
ON CONFLICT (id_cliente) DO NOTHING;

-- r) Cadastre cinco produtos.
INSERT INTO norm_ex13_produto (id_produto, nome_produto, preco_atual_produto)
VALUES
    (1, 'Notebook', 3500.00),
    (2, 'Mouse',      80.00),
    (3, 'Teclado',   150.00),
    (4, 'Monitor',  1200.00),
    (5, 'Webcam',    180.00)
ON CONFLICT (id_produto) DO NOTHING;

-- s) Cadastre quatro pedidos.
INSERT INTO norm_ex13_pedido (id_pedido, data_pedido, id_cliente)
VALUES
    (100, DATE '2026-10-01', 1),
    (101, DATE '2026-10-03', 2),
    (102, DATE '2026-10-04', 1),
    (103, DATE '2026-10-07', 3)
ON CONFLICT (id_pedido) DO NOTHING;

-- t) Cadastre oito itens, sem repetir produto dentro do mesmo pedido.
-- O preço unitário de venda é registrado como fotografia do momento da compra.
INSERT INTO norm_ex13_item_pedido
    (id_pedido, id_produto, quantidade, preco_unitario_venda)
VALUES
    (100, 1, 1, 3400.00),
    (100, 2, 2,   80.00),
    (100, 3, 1,  150.00),
    (101, 4, 1, 1150.00),
    (101, 5, 2,  170.00),
    (102, 2, 1,   75.00),
    (102, 3, 2,  145.00),
    (103, 5, 1,  180.00)
ON CONFLICT (id_pedido, id_produto) DO NOTHING;

-- u) Consulte todos os pedidos.
SELECT *
FROM norm_ex13_pedido
ORDER BY data_pedido, id_pedido;

-- v) Consulte os itens pertencentes ao pedido 100.
SELECT *
FROM norm_ex13_item_pedido
WHERE id_pedido = 100
ORDER BY id_produto;

-- w) Atualize o telefone de um cliente.
UPDATE norm_ex13_cliente
SET telefone_cliente = '4498888-1111'
WHERE id_cliente = 1;

-- x) Atualize o preço cadastral atual de um produto.
UPDATE norm_ex13_produto
SET preco_atual_produto = 3700.00
WHERE id_produto = 1;

-- y) Verifique os dois valores separadamente.
-- O preço atual do notebook muda, mas o preco_unitario_venda do pedido 100
-- continua em R$ 3.400,00. Isso preserva o histórico da compra.
SELECT id_produto, nome_produto, preco_atual_produto
FROM norm_ex13_produto
WHERE id_produto = 1;

SELECT id_pedido, id_produto, quantidade, preco_unitario_venda
FROM norm_ex13_item_pedido
WHERE id_produto = 1
ORDER BY id_pedido;

-- z) A separação é importante porque o preço cadastral pode mudar com o tempo,
-- enquanto o preço unitário de venda precisa representar o valor histórico
-- efetivamente cobrado em cada pedido.
