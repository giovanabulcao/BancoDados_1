-- NÍVEL 3: WHERE, HAVING E FILTER


-- 13. Conte por categoria somente produtos com preço acima de R$ 100.
-- WHERE filtra as linhas antes de formar os grupos.
SELECT
    c.nome AS categoria,
    COUNT(p.id_produto) AS quantidade_produtos
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
WHERE p.preco > 100
GROUP BY c.id_categoria, c.nome
ORDER BY c.nome;

-- 14. Mostre categorias com pelo menos três produtos.
-- HAVING filtra os grupos depois do GROUP BY.
SELECT
    c.nome AS categoria,
    COUNT(p.id_produto) AS quantidade_produtos
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
HAVING COUNT(p.id_produto) >= 3
ORDER BY c.nome;

-- 15. Mostre categorias com preço médio acima de R$ 500.
SELECT
    c.nome AS categoria,
    AVG(p.preco) AS preco_medio
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
HAVING AVG(p.preco) > 500
ORDER BY preco_medio DESC;

-- 16. Em uma única linha, conte todos os produtos, os de preço acima de R$ 1000
-- e os que possuem estoque abaixo de 10. FILTER filtra cada agregação separadamente.
SELECT
    COUNT(*) AS todos_os_produtos,
    COUNT(*) FILTER (WHERE preco > 1000) AS produtos_acima_de_1000,
    COUNT(*) FILTER (WHERE estoque < 10) AS produtos_com_estoque_abaixo_de_10
FROM produto;

-- 17. Mostre categorias cujo valor total de estoque supera R$ 10.000.
SELECT
    c.nome AS categoria,
    SUM(p.preco * p.estoque) AS valor_total_estoque
FROM categoria AS c
INNER JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
HAVING SUM(p.preco * p.estoque) > 10000
ORDER BY valor_total_estoque DESC;
