-- NÍVEL 1: 

-- 1. Conte todos os produtos.
SELECT COUNT(*) AS total_produtos
FROM produto;

-- 2. Conte as categorias distintas que possuem pelo menos um produto.
-- Para contar também categorias vazias, consulte COUNT(*) em agg_categoria.
SELECT COUNT(DISTINCT id_categoria) AS categorias_com_produtos
FROM produto;

-- 3. Calcule o total de unidades em estoque.
SELECT COALESCE(SUM(estoque), 0) AS total_unidades_estoque
FROM produto;

-- 4. Calcule o valor financeiro total do estoque (preço x quantidade).
SELECT COALESCE(SUM(preco * estoque), 0) AS valor_total_estoque
FROM produto;

-- 5. Calcule o preço médio dos produtos.
SELECT AVG(preco) AS preco_medio
FROM produto;

-- 6. Encontre o menor e o maior preço.
SELECT
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco
FROM produto;

-- 7. Mostre todos os produtos empatados no menor preço.
SELECT id_produto, nome, preco
FROM produto
WHERE preco = (SELECT MIN(preco) FROM produto)
ORDER BY nome;
