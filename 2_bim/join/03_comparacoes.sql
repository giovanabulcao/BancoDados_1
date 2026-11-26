--  NÍVEL 3: COMPARAÇÕES

-- 9. INNER JOIN: retorna somente categorias que possuem produtos.
SELECT c.nome AS categoria, p.nome AS produto
FROM categoria AS c
INNER JOIN produto AS p
    ON c.id_categoria = p.id_categoria
ORDER BY c.nome, p.nome;

-- 9. LEFT JOIN: retorna todas as categorias, mesmo sem produto associado.
SELECT c.nome AS categoria, p.nome AS produto
FROM categoria AS c
LEFT JOIN produto AS p
    ON c.id_categoria = p.id_categoria
ORDER BY c.nome, p.nome;

-- Comparação: INNER JOIN elimina categorias sem correspondência;
-- LEFT JOIN mantém todas as linhas da tabela que aparece à esquerda.

-- 10. Reescreva o LEFT JOIN anterior utilizando RIGHT JOIN.
-- A tabela join_categoria foi movida para o lado direito.
SELECT c.nome AS categoria, p.nome AS produto
FROM produto AS p
RIGHT JOIN categoria AS c
    ON p.id_categoria = c.id_categoria
ORDER BY c.nome, p.nome;

-- 11. CROSS JOIN: combina cada categoria com cada produto.
SELECT
    c.nome AS categoria,
    p.nome AS produto
FROM categoria AS c
CROSS JOIN produto AS p
ORDER BY c.nome, p.nome;

-- A quantidade de linhas do CROSS JOIN é o número de categorias multiplicado
-- pelo número de produtos. Confira os dois fatores sem JOIN:
SELECT COUNT(*) AS total_categorias FROM categoria;
SELECT COUNT(*) AS total_produtos FROM produto;
