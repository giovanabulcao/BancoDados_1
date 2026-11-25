/*
A
INSERT INTO produto (nome, preco, estoque, id_categoria)
VALUES ('Teclado', -150.00, 10, 1);

a) O preço é menor que 0
b) o CHECK da coluna preco, que exige um preço positivo (preco >= 0),Como -150.00 é menor que zero, o banco rejeita o INSERT.

*/


/*
B
INSERT INTO produto (preco, estoque, id_categoria)
VALUES (250.00, 5, 1);

a) Não recebemos o nome do produto na hora de inserir
b) O NOT NULL exige que nome deve existir obrigatóriamente.

*/



/*
C
INSERT INTO produto (nome, preco, estoque, id_categoria)
VALUES ('Webcam', 300.00, -2, 1);

a) O mesmo que acontece em A, ESTOQUE não deve ser menor que 0.
b) CHECK(estoque>=0) exige que estoque tenha um valor maior ou igual a 0.

*/


/*
D
INSERT INTO produto (nome, preco, estoque, id_categoria)
VALUES ('Headset', 450.00, 5, 9999);

a) o id categoria 9999 não existe
b) A chave estrangeira  de produto.id_categoria exige que a categoria informada exista na tabela categoria.

*/

INSERT INTO produto (nome, preco, estoque, id_categoria)
VALUES 
('Teclado', 150.00, 10, 1),
('Teclado Gamer',250.00, 5, 1),
('Webcam', 300.00, 0, 1),
('Headset', 450.00, 5, 1);
