-- NÍVEL 4: JOIN E AGREGAÇÃO


-- 18. Conte produtos por categoria incluindo categorias vazias.
-- LEFT JOIN preserva todas as categorias. COUNT(p.id_produto) conta apenas
-- produtos correspondentes; COUNT(*) também contaria a linha sem produto.
SELECT
    c.nome AS categoria,
    COUNT(p.id_produto) AS quantidade_produtos
FROM categoria AS c
LEFT JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY c.nome;

-- 19. Mostre somente categorias vazias.
SELECT
    c.id_categoria,
    c.nome AS categoria
FROM categoria AS c
LEFT JOIN produto AS p
    ON p.id_categoria = c.id_categoria
WHERE p.id_produto IS NULL
ORDER BY c.nome;

-- 20. Calcule quantidade de produtos, unidades em estoque, média de preço
-- e valor financeiro do estoque por categoria.
SELECT
    c.nome AS categoria,
    COUNT(p.id_produto) AS quantidade_produtos,
    COALESCE(SUM(p.estoque), 0) AS quantidade_unidades,
    AVG(p.preco) AS preco_medio,
    COALESCE(SUM(p.preco * p.estoque), 0) AS valor_total_estoque
FROM categoria AS c
LEFT JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY c.nome;

-- 21. Por que COUNT(*) pode dar resultado incorreto em um LEFT JOIN?
-- Resposta: o LEFT JOIN mantém uma linha para cada categoria sem produto,
-- preenchendo as colunas de produto com NULL. COUNT(*) conta essa linha e
-- retorna 1 para uma categoria vazia. COUNT(p.id_produto) ignora NULL e
-- retorna 0, que é a quantidade correta de produtos correspondentes.
-- Compare as duas contagens:
SELECT
    c.nome AS categoria,
    COUNT(*) AS contagem_com_count_asterisco,
    COUNT(p.id_produto) AS contagem_correta_de_produtos
FROM categoria AS c
LEFT JOIN produto AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY c.nome;
