-- NORMALIZAÇÃO — PARTE 5: 

/* EXERCÍCIO 11 

Na versão A, nome_categoria está repetido em cada produto. Alterar apenas uma
linha deixa os produtos da mesma categoria com nomes diferentes.
Na versão B, o nome é armazenado uma vez em CATEGORIA e PRODUTO guarda apenas
o id_categoria. Assim, uma mudança é feita em um único registro.
A normalização reduz redundância, mas ainda precisamos de PRIMARY KEY,
FOREIGN KEY, UNIQUE, NOT NULL e CHECK para garantir integridade.
*/

-- Versão A: produto e categoria armazenados na mesma tabela.
CREATE TABLE IF NOT EXISTS norm_ex11_produto_categoria_a (
    id_produto BIGINT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    id_categoria BIGINT NOT NULL,
    nome_categoria VARCHAR(100) NOT NULL
);

INSERT INTO norm_ex11_produto_categoria_a
    (id_produto, nome_produto, preco, id_categoria, nome_categoria)
VALUES
    (1, 'Notebook', 3500.00, 10, 'Informática'),
    (2, 'Mouse',      80.00, 10, 'Informática'),
    (3, 'Teclado',   150.00, 10, 'Informática'),
    (4, 'Cadeira',   850.00, 20, 'Móveis'),
    (5, 'Mesa',     1200.00, 20, 'Móveis')
ON CONFLICT (id_produto) DO NOTHING;

-- c) Consulte todos os registros da versão A.
SELECT * FROM norm_ex11_produto_categoria_a ORDER BY id_produto;

-- d) Altere o nome da categoria em apenas um dos produtos (inconsistência intencional).
UPDATE norm_ex11_produto_categoria_a
SET nome_categoria = 'Tecnologia'
WHERE id_produto = 1;

-- e) Consulte novamente e observe que id_categoria 10 possui dois nomes.
SELECT * FROM norm_ex11_produto_categoria_a ORDER BY id_produto;

-- g), h), i) Versão B: tabelas separadas.
CREATE TABLE IF NOT EXISTS norm_ex11_categoria_b (
    id_categoria BIGINT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS norm_ex11_produto_b (
    id_produto BIGINT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    id_categoria BIGINT NOT NULL,
    CONSTRAINT fk_norm_ex11_produto_categoria
        FOREIGN KEY (id_categoria) REFERENCES norm_ex11_categoria_b(id_categoria)
);

INSERT INTO norm_ex11_categoria_b (id_categoria, nome_categoria)
VALUES (10, 'Informática'), (20, 'Móveis')
ON CONFLICT (id_categoria) DO NOTHING;

INSERT INTO norm_ex11_produto_b (id_produto, nome_produto, preco, id_categoria)
VALUES
    (1, 'Notebook', 3500.00, 10),
    (2, 'Mouse',      80.00, 10),
    (3, 'Teclado',   150.00, 10),
    (4, 'Cadeira',   850.00, 20),
    (5, 'Mesa',     1200.00, 20)
ON CONFLICT (id_produto) DO NOTHING;

-- j) Altere o nome de uma categoria em um único lugar.
UPDATE norm_ex11_categoria_b
SET nome_categoria = 'Tecnologia'
WHERE id_categoria = 10;

-- k) Consulte as categorias. A alteração vale para todos os produtos dessa categoria.
SELECT * FROM norm_ex11_categoria_b ORDER BY id_categoria;

-- Consulta adicional para verificar os produtos e seus IDs de categoria.
-- Os nomes das categorias ficam na tabela de categoria e não são copiados para produto.
SELECT * FROM norm_ex11_produto_b ORDER BY id_produto;

-- l), m) Na versão A seria necessário atualizar todas as linhas da categoria
-- (três produtos no exemplo). Na versão B basta atualizar uma linha em categoria.

/* EXERCÍCIO 12 — MIGRAÇÃO

A tabela original repete nome_categoria em cada produto. Dependência funcional:
- id_produto -> nome_produto, preco, id_categoria.
- id_categoria -> nome_categoria.
O modelo em 3FN separa CATEGORIA e PRODUTO. Preservar id_categoria durante a
migração mantém os vínculos entre produtos e categorias e permite que as FKs
continuem apontando para as mesmas entidades.
*/

CREATE TABLE IF NOT EXISTS norm_ex12_produto_original (
    id_produto BIGINT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco NUMERIC(10,2) NOT NULL,
    id_categoria BIGINT NOT NULL,
    nome_categoria VARCHAR(100) NOT NULL
);

INSERT INTO norm_ex12_produto_original
    (id_produto, nome_produto, preco, id_categoria, nome_categoria)
VALUES
    (1, 'Notebook', 3500.00, 10, 'Informática'),
    (2, 'Mouse',      80.00, 10, 'Informática'),
    (3, 'Teclado',   150.00, 10, 'Informática'),
    (4, 'Monitor',  1200.00, 20, 'Eletrônicos'),
    (5, 'Webcam',    180.00, 20, 'Eletrônicos'),
    (6, 'Impressora',900.00, 30, 'Escritório')
ON CONFLICT (id_produto) DO NOTHING;

CREATE TABLE IF NOT EXISTS norm_ex12_categoria_normalizada (
    id_categoria BIGINT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS norm_ex12_produto_normalizado (
    id_produto BIGINT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco NUMERIC(10,2) NOT NULL,
    id_categoria BIGINT NOT NULL,
    CONSTRAINT fk_norm_ex12_produto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES norm_ex12_categoria_normalizada(id_categoria)
);

-- e) Transfira as categorias sem repetir registros.
INSERT INTO norm_ex12_categoria_normalizada (id_categoria, nome_categoria)
SELECT DISTINCT id_categoria, nome_categoria
FROM norm_ex12_produto_original
ON CONFLICT (id_categoria) DO NOTHING;

-- f) Transfira os produtos mantendo seus identificadores e suas categorias.
INSERT INTO norm_ex12_produto_normalizado
    (id_produto, nome_produto, preco, id_categoria)
SELECT id_produto, nome_produto, preco, id_categoria
FROM norm_ex12_produto_original
ON CONFLICT (id_produto) DO NOTHING;

-- g) Consulte as tabelas novas separadamente.
SELECT * FROM norm_ex12_categoria_normalizada ORDER BY id_categoria;
SELECT * FROM norm_ex12_produto_normalizado ORDER BY id_produto;

-- h) Verifique os produtos transferidos: os seis registros devem aparecer.
-- A conferência é visual; a orientação desta lista não permite COUNT().
SELECT id_produto, nome_produto, preco, id_categoria
FROM norm_ex12_produto_normalizado
ORDER BY id_produto;

-- i), j) A preservação dos IDs mantém o vínculo entre produto e categoria.
-- A FOREIGN KEY impede que um produto aponte para categoria inexistente.
-- A tabela original é mantida, conforme solicitado.
