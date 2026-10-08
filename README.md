## Banco de Dados 1

### Atividade 1
Elaborar um DER(Diagrama de Entidade-Relacionamento) completo a partir da descrição dada pelo professor, contendo o sistema de gestão de uma oficina mecânica, controlando clientes, veículos, serviços, funcionários...

Conceitos trabalhados:
1. Entidades
2. Atributos
3. Identificadores
4. Relacionamentos
5. Cardinalidades mínima e máxima
6. Atributos de relacionamento
7. Generalização/ Especialização
8. Entidade associativa

Link da atividade (Diagrama feito no BR Modelo): https://app.brmodeloweb.com/publicview/6a997360f351603fa48c078a

### Atividade 2
Modelagem conceitual (DER) para um sistema de cálculo de locação de veículos.O sistema recebe dados de uma locação (dias, valor da diária, quilometragem percorrida, contratação de seguro e idade do motorista) e calcula o valor final a pagar, considerando:

- Valor das diárias (dias × valor da diária)
- Franquia de quilometragem (100 km/dia) com cobrança de R$ 0,50/km excedente
- Seguro opcional (R$ 35,00/dia, se contratado)
- Desconto progressivo sobre o valor das diárias conforme a duração da locação (0%, 5% ou 10%)
- Taxa adicional para motoristas com menos de 21 anos (R$ 150,00)
- Validação de entradas inválidas (dias, valor da diária, idade ou quilometragem fora dos limites aceitáveis)
  
Link da atividade (Diagrama feito no BR Modelo): https://app.brmodeloweb.com/publicview/6a99736df351603fa48c0798


### Atividade 3

### **A. Integridade de dados**

Explique com suas palavras:

> O que significa garantir a integridade dos dados em um banco de dados?

> Significa garantir e assegurar que os dados e informações serão armazenados no banco de maneira confiável, correta e consistente ao longo de todo o seu ciclo de vida.

### **B. Integridade de entidade**

Pesquise o que é **integridade de entidade** e responda:

* O que ela procura garantir?  
  * ela garante que cada registro/linha seja único e identificável, nenhuma linha pode ser confundida com outra  
* Qual é a relação entre integridade de entidade e chave primária (PK)?  
  * a chave primária é oq valida a integridade de entidade, é ela que identifica cada linha da tabela  
* Uma chave primária pode possuir valores repetidos?  
  * não, pois assim, ela não seria única, consultas, atualizações e exclusoẽs poderiam atingir a linha errada  
* Uma chave primária pode ser nula?  
  * não pode, cada registro precisa ser identificável  
* O que poderia acontecer se essas regras não fossem respeitadas?  
  * inconsistências, quebras no banco…

Ao final, apresente **um exemplo próprio**.

Temos uma tabela de aluno/ entidade mesmo havendo duas alunas com o mesmo nome e o mesmo curso, o RA diferente permite identificá-las separadamente. Se o banco aceitasse dois alunos com o mesmo RA, ou um aluno sem RA, não seria possível saber de quem é uma nota ou uma matrícula

### **C. Integridade referencial**

Pesquise o que é **integridade referencial** e responda:

* O que ela procura garantir?  
  * Consistência entre tabelas relacionadas, todo valor usado como referência a outra tabela deve corresponder a um registro que realmente existe.  
* Qual é sua relação com a chave estrangeira (FK)?  
  * ela implementa a integridade referencial, A FK em uma tabela aponta para a PK de outra, e o banco verifica se o valor apontado existe  
* Uma FK pode referenciar um registro inexistente?  
  * não, exceto se a coluna permitir NULL, que significa sem relação  
* O que significa um registro órfão?  
  * um registro filho cuja FK aponta para um registro pai que referenciam valores inexistentes  
* O que pode acontecer ao excluir um registro que está sendo referenciado por outra tabela?  
  * Se nada for feito, os registros que o referenciam ficam orfãos

Ao final, apresente **um exemplo próprio envolvendo duas tabelas relacionadas**.

### **D. Integridade de domínio**

Pesquise o que é **integridade de domínio** e responda:

* O que significa o domínio de um atributo?  
  * garante que os valores inseridos em uma coluna sejam validos para aquele campo  
* Como podemos determinar quais valores são válidos?  
  * analisando o significado do atributo no mundo real e traduzindo isso em tipo de dado, tamanho, formato, se aceita nulo ou não, faixa de valores e lista de valores permitidos.  
* O tipo de dado ajuda a controlar o domínio?  
  *  sim,mas não é suficiente  
* Existem restrições que vão além do tipo de dado?  
  * sim, por exemplo not null, check, default…

Considere a tabela:

```
PRODUTO
────────────────────
idProduto
nome
preco
estoque
```

Determine quais valores deveriam ou não ser permitidos para os atributos `preco` e `estoque`. Justifique sua resposta.

preco: é permitido valores reais, maior ou igual a zero, não é permitido texto, valores negativos, valor vazio/nulo

estoque: é permitido números inteiros maior ou igual a zero,já que é uma quantidade de unidades físicas, não pode ser valores negativos, decimais, texto e nulo.

para preço deveriam ser permitidos valores reais como float, double, int… Estoque poderia ser uma string com ó código do numero de estoque de um produto

4 \- Investigando um banco problemático

- Na tabela Cliente, um registro aparece sem nome, é um problema pq pode impedir o registro de ser identificável, integridade de dominio, o atributo nome não pode ser vazio. NOT NULL é obrigatório  
- Ainda na tabela Cliente, dois registros aparecem com o mesmo email, dois registros possuem o mesmo identificador, integridade de entidade.  
- Na tabela produto, preço e estoque aparecem com valores negativos, nome aparece vazio, integridade de domínio  
- Na tabela Pedido, o mesmo pedido referencia o mesmo cliente e um pedido referencia um cliente inexistente, integridade de referência.

TABELA CLIENTE  
\[E\] R01 \- Todo cliente deve possuir um identificador único  
\[E\] R02 \- O identificador do cliente não pode ser nulo  
\[D\] R03 \- Todo cliente deve possuir um nome obrigatório  
\[E\] R04 \- Dois clientes não podem possuir o mesmo e-mail  
\[D\] R05 \- O e-mail do cliente é obrigatório

TABELA PRODUTO  
\[E\] R06 \- Todo produto deve possuir um identificador único e não nulo  
\[D\] R07 \- Todo produto deve possuir um nome obrigatório  
\[D\] R08 \- O preço de um produto não pode ser negativo  
\[D\] R09 \- O estoque  deve ser um numero inteiro e não pode ser negativo  
\[D\] R10 \- O produto começa com estoque zero, a não ser que seja informado antes.

TABELA PEDIDO  
\[E\] R11 \- Todo pedido deve possuir um identificador único e não vazio  
\[R\] R12 \- Um pedido poderá referenciar somente um cliente existente  
\[D\] R13 \- Todo pedido precisa de uma data  
\[D\] R14 \- O valor de um pedido não pode ser negativo  
\[R\] R15 \- Um cliente que possui pedidos não poderá ser excluído 

Parte IV  
PRIMARY KEY

1. Procura garantir que cada linha da tabela seja identificada de forma única e nunca nula  
2. identificar cada cliente com idCliente, ou cada aluno pelo RA, implementa a integridade de entidade

FOREIGN KEY

1. Procura garantir que o valor de uma coluna corresponda a um valor existente na chave de outra tabela, implementa a integridade referencial  
2. impedir um pedido de um cliente que não existe (PEDIDO.idCliente apontando para CLIENTE.idCliente).

NOT NULL

1. procura garantir que a coluna sempre receba uma valor  
2. impedir o cadastro de um cliente ou produto sem nome, e de um pedido sem data.

UNIQUE

1. procura garantir que não existam dois registros com o mesmo valor naquela coluna  
2. impedir dois clientes com o mesmo e-mail ou o mesmo cpf

CHECK

1. procura garantir que o valor satisfaça uma condição lógica definida   
2. garantir que preco \>= 0, estoque \>- 0…

DEFAULT

1. procura garantir que quando nenhum valor for informado a coluna receba automaticamente um valor padrão predefinido  
2. iniciar estoque de um produto com 0

Parte V

| Necessidade | Mecanismo que você utilizaria |
| ----- | ----- |
| Identificar cada cliente de maneira única | PRIMARY KEY em idCliente |
| Impedir um cliente sem nome | NOT NULL em nome |
| Impedir dois clientes com o mesmo e-mail | UNIQUE em email |
| Impedir preço negativo | CHECK preco \>=0 |
| Garantir que um pedido pertença a um cliente existente | FOREIGN KEY em Pedido.idCliente referenciando Cliente.idCliente |
| Fazer um produto iniciar com estoque zero quando nenhum valor for informado | DEFAULT 0 em estoque |

Existe relação entre os problemas de integridade estudados e os mecanismos encontrados?

- Sim, existe uma relação direta, cada tipo de integridade é um conjunto de regras (o que precisa ser garantido), onde cada mecanismo (`PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`) implementa um tipo de integridade
