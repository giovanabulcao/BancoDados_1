-- NÍVEL 1: INNER JOIN


-- 1. Apresente o nome de cada produto e sua categoria.
SELECT
    p.nome AS produto,
    c.nome AS categoria
FROM produto AS p
INNER JOIN categoria AS c
    ON p.id_categoria = c.id_categoria
ORDER BY p.nome;

-- 2. Apresente nome, preço e categoria, em ordem decrescente de preço.
SELECT
    p.nome AS produto,
    p.preco,
    c.nome AS categoria
FROM produto AS p
INNER JOIN categoria AS c
    ON p.id_categoria = c.id_categoria
ORDER BY p.preco DESC;

-- 3. Consulte somente os produtos de Informática.
SELECT
    p.nome AS produto,
    c.nome AS categoria
FROM produto AS p
INNER JOIN categoria AS c
    ON p.id_categoria = c.id_categoria
WHERE c.nome = 'Informática'
ORDER BY p.nome;

-- 4. Apresente produtos com preço superior a R$ 500 e suas categorias.
SELECT
    p.nome AS produto,
    p.preco,
    c.nome AS categoria
FROM produto AS p
INNER JOIN categoria AS c
    ON p.id_categoria = c.id_categoria
WHERE p.preco > 500
ORDER BY p.preco DESC;

-- 5. Apresente produtos de Informática ou Móveis, em ordem alfabética.
SELECT
    p.nome AS produto,
    c.nome AS categoria
FROM produto AS p
INNER JOIN categoria AS c
    ON p.id_categoria = c.id_categoria
WHERE c.nome IN ('Informática', 'Móveis')
ORDER BY p.nome ASC;
