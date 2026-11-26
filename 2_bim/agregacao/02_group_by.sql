-- AGREGAÇÃO — NÍVEL 2: GROUP BY


-- 8. Conte os produtos por categoria.
SELECT
    c.nome AS categoria,
    COUNT(p.id_produto) AS quantidade_produtos
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY c.nome;

-- 9. Calcule o estoque total (unidades) por categoria.
SELECT
    c.nome AS categoria,
    SUM(p.estoque) AS total_unidades_estoque
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY c.nome;

-- 10. Calcule preço médio, mínimo e máximo por categoria.
SELECT
    c.nome AS categoria,
    AVG(p.preco) AS preco_medio,
    MIN(p.preco) AS menor_preco,
    MAX(p.preco) AS maior_preco
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY c.nome;

-- 11. Calcule o valor financeiro do estoque por categoria.
SELECT
    c.nome AS categoria,
    SUM(p.preco * p.estoque) AS valor_total_estoque
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY valor_total_estoque DESC;

-- 12. Liste alfabeticamente os produtos de cada categoria em uma única string.
-- ORDER BY dentro de STRING define a ordem dos nomes concatenados.
SELECT
    c.nome AS categoria,
    STRING_AGG(p.nome, ', ' ORDER BY p.nome) AS produtos
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY c.nome;
