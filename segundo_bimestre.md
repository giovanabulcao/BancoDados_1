## 2º BIMESTRE
### Atividade 1: Utilizando conceitos de INSERT e SELECT. Link da atividade no Supabase -> https://irpuzumfxujmbubizmra.supabase.co

### ATIVIDADE 4 (PARA ENTREGA): Link do Supabase -> https://nyqdvbkvsrjicljtqhyp.supabase.co
As perguntas dos exercícios 1 a 4, são respondidas em comentário no código.
EX 5:

| Tentativa | Inserção aceita? | Restrição envolvida | Explique o motivo |
| Produto sem nome | Não | `NOT NULL` | O produto precisa obrigatóriamente ter um nome, por isso utilizamos `NOT NULL` para não aceitar valores nulos |
| Preço negativo | Não | `CHECK` | Definimos na criação da tabela que preço precisa ser maior ou igual a 0, se ele não for, o banco rejeita o `INSERT` |
| Estoque negativo | Não | `CHECK` | Definimos na criação da tabela que estoque precisa ser maior ou igual a 0, como o valor do estoque é negativo, o banco rejeita o `INSERT`  |
| Categoria inexistente | Não | `FOREIGN KEY` | O ID 9999 não corresponde a nenhuma categoria cadastrada |			
| Categoria duplicada | Não | `UNIQUE` | Já existe uma categoria com o mesmo valor |			

