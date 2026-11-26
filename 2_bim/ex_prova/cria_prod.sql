SELECT 
    c.nome AS categoria,
    COUNT(p.id_produto) AS qntd_produtos,
    SUM(p.estoque) AS total_estoque,
    ROUND(AVG(p.preco), 2) AS preco_medio,
    MIN(p.preco) AS menor_preco,
    MAX(p.preco) AS maior_preco,
    SUM(p.preco * p.estoque) AS valor_estoque

FROM categoria c
INNER JOIN produto p
    ON p.id_categoria = c.id_categoria;

WHERE p.estoque > 0
AND (
    p.preco BETWEEN 100 AND 2000
    OR p.nome ILIKE '%a%'
)

GROUP BY c.id_categoria, c.nome
HAVING COUNT(p.id_produto) >= 2
ORDER BY quantidade_produtos DESC

LIMIT 3