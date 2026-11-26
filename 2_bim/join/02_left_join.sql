-- JOIN — NÍVEL 2: LEFT JOIN

-- 6. Liste todas as categorias, incluindo as que não possuem produtos.
SELECT
    c.nome AS categoria,
    p.nome AS produto
FROM categoria AS c
LEFT JOIN produto AS p
    ON c.id_categoria = p.id_categoria
ORDER BY c.nome, p.nome;

-- 7. Identifique as categorias sem produtos.
SELECT
    c.id_categoria,
    c.nome AS categoria
FROM categoria AS c
LEFT JOIN produto AS p
    ON c.id_categoria = p.id_categoria
WHERE p.id_produto IS NULL
ORDER BY c.nome;

-- 8. Liste todas as categorias e associe somente produtos com preço superior
-- a R$ 100, preservando categorias sem correspondências.
-- A condição de preço fica no ON. Se fosse colocada no WHERE, as categorias
-- sem produto correspondente seriam eliminadas do resultado.
SELECT
    c.nome AS categoria,
    p.nome AS produto,
    p.preco
FROM categoria AS c
LEFT JOIN produto AS p
    ON c.id_categoria = p.id_categoria
   AND p.preco > 100
ORDER BY c.nome, p.nome;
