# Respostas — Avaliação Prática II de Banco de Dados I

**Acadêmico(a):Giovana da Silva Bulcão**  
**RA: 144325**  
**Data: 26/11/2007**

## Orientações

Preencha os blocos SQL com as consultas finais, testadas no Supabase. Utilize os nomes completos das tabelas (`avaliacao_bd2.produto` e `avaliacao_bd2.categoria`). 
Mantenha os títulos e a numeração dos itens. Não inclua o script de preparação, resultados das consultas ou capturas de tela. No item 2.c, escreva sua explicação em texto.

## Questão 1 — Consultas SQL

### 1.a

```
SELECT nome, preco, estoque 
FROM avaliacao_bd2.produto
WHERE preco > 100 
  AND  estoque >= 5
ORDER BY preco ASC;

```

### 1.b

```
SELECT *
FROM avaliacao_bd2.produto
WHERE preco BETWEEN 50 AND 1000
ORDER BY nome ASC;

```

## Questão 2 — Relacionamentos

### 2.a

``
SELECT
    p.id_produto,
    p.preco,
    c.nome
FROM avaliacao_bd2.produto AS p
INNER JOIN avaliacao_bd2.categoria AS c
    ON p.id_categoria = c.id_categoria;

```

### 2.b

```
SELECT
    c.nome,
    p.id_produto
FROM avaliacao_bd2.categoria AS c
LEFT JOIN avaliacao_bd2.produto AS p
    ON c.id_categoria = p.id_categoria;

```

### 2.c

**Limpeza não aparece na questão a, pq utilizamos INNER JOIN que seleciona todos os registros das tabelas que são relacionadas, já LEFT JOIN usado no exercio b) seleciona os registros independente de estarem relacionados ou não*/**

## Questão 3 — Agregações

### 3.a

```
/*Coloquei a 3.b aqui tb*/
SELECT 
  COUNT(*) AS qntd_produtos,
  COUNT(estoque) AS qntd_estoque,
  ROUND(AVG(preco), 2) AS preco_medio,
  MIN(preco) AS menor_preco,
  MAX(preco) AS maior_preco,
  /*Calcule o valor financeiro total do estoque, considerando o preço de cada produto multiplicado pela respectiva quantidade em estoque.*/
  SUM(preco* estoque) AS valor_estoque

FROM avaliacao_bd2.produto;

```


### 3.c

```
SELECT
    id_categoria,
    COUNT(*) AS total_produtos
FROM avaliacao_bd2.produto
GROUP BY avaliacao_bd2.categoria
HAVING COUNT(*) > 2;

```

## Questão 4 — Relacionamentos e agregações

```
SELECT
    c.nome AS avaliacao_bd2.categoria,
    COUNT(*) AS quantidade_podutos,
    COUNT(*) AS quantidade_estoque,
    SUM(preco*estoque) AS total_estoque
FROM avaliacao_bd2.produto
RIGHT JOIN avaliacao_bd2. categoria c 
  ON  p.id_categoria = c.id_categoria

GROUP BY avaliacao_bd2.categoria
ORDER BY total_estoque AS ASC;

```
