-- PARTE 4: 

/* EXERCÍCIO 9 

Dependências funcionais:
- id_aluno -> nome_aluno, id_curso.
- id_curso -> nome_curso, coordenador.
Dependência transitiva:
- id_aluno -> id_curso -> nome_curso, coordenador.
A relação atende à 2FN porque a chave candidata id_aluno é simples; não há
como existir dependência parcial de parte da chave. Não atende à 3FN porque
atributos não-chave (nome_curso e coordenador) dependem transitivamente da chave.
Separação: CURSO(id_curso PK, nome_curso, coordenador) e
ALUNO(id_aluno PK, nome_aluno, id_curso FK).
*/

CREATE TABLE curso (
    id_curso BIGINT PRIMARY KEY,
    nome_curso VARCHAR(120) NOT NULL,
    coordenador VARCHAR(100) NOT NULL
);

CREATE TABLE aluno (
    id_aluno BIGINT PRIMARY KEY,
    nome_aluno VARCHAR(100) NOT NULL,
    id_curso BIGINT NOT NULL,
    CONSTRAINT fk_aluno_curso
        FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

-- j) Cadastre os três cursos apresentados.
INSERT INTO curso (id_curso, nome_curso, coordenador)
VALUES
    (10, 'Sistemas de Informação', 'Carlos'),
    (20, 'Ciência da Computação', 'Fernanda'),
    (30, 'Engenharia de Software', 'Roberto')
ON CONFLICT (id_curso) DO NOTHING;

-- k) Cadastre cinco alunos distribuídos entre os cursos.
INSERT INTO aluno (id_aluno, nome_aluno, id_curso)
VALUES
    (1, 'Ana', 10),
    (2, 'Bruno', 10),
    (3, 'Maria', 20),
    (4, 'Pedro', 30),
    (5, 'Julia', 20)
ON CONFLICT (id_aluno) DO NOTHING;

-- l) Altere o coordenador do curso de Sistemas de Informação.
UPDATE curso
SET coordenador = 'Marcos'
WHERE id_curso = 10;

-- m) Consulte o curso alterado.
SELECT *
FROM curso
WHERE id_curso = 10;

-- n) Não é necessário atualizar os alunos porque os dados do coordenador
-- são armazenados uma única vez na tabela CURSO.

/* EXERCÍCIO 10 

Dependências:
- id_funcionario -> nome_funcionario, salario, id_departamento.
- id_departamento -> nome_departamento, gerente_departamento.
A relação original apresenta dependência transitiva a partir de id_funcionario.
Modelo em 3FN: DEPARTAMENTO(id_departamento PK, nome_departamento,
gerente_departamento) e FUNCIONARIO(id_funcionario PK, nome_funcionario,
salario, id_departamento FK).
Anomalias: não cadastrar departamento sem funcionário; repetir atualizações
do gerente/nome do departamento; perder dados do departamento ao excluir o
último funcionário.
*/

CREATE TABLE departamento (
    id_departamento BIGINT PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL UNIQUE,
    gerente_departamento VARCHAR(100) NOT NULL
);

CREATE TABLE funcionario (
    id_funcionario BIGINT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    salario NUMERIC(10,2) NOT NULL CHECK (salario >= 0),
    id_departamento BIGINT NOT NULL,
    CONSTRAINT fk_funcionario_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES departamento(id_departamento)
);

-- i) e j) Cadastre departamentos e funcionários.
INSERT INTO departamento (id_departamento, nome_departamento, gerente_departamento)
VALUES (10, 'TI', 'Carlos'), (20, 'Financeiro', 'Fernanda')
ON CONFLICT (id_departamento) DO NOTHING;

INSERT INTO funcionario (id_funcionario, nome_funcionario, salario, id_departamento)
VALUES
    (1, 'Ana', 3500.00, 10),
    (2, 'Bruno', 4200.00, 10),
    (3, 'Maria', 3100.00, 20),
    (4, 'Pedro', 3900.00, 10),
    (5, 'Julia', 3700.00, 20)
ON CONFLICT (id_funcionario) DO NOTHING;

-- k) Aumente em 10% o salário dos funcionários do departamento de TI.
UPDATE funcionario
SET salario = salario * 1.10
WHERE id_departamento = (
    SELECT id_departamento
    FROM departamento
    WHERE nome_departamento = 'TI'
);

-- l) Altere o gerente do departamento Financeiro.
UPDATE departamento
SET gerente_departamento = 'Mariana'
WHERE nome_departamento = 'Financeiro';

-- m) Consulte os dados dos departamentos.
SELECT * 
FROM departamento
 ORDER BY id_departamento;

-- n) Consulte os funcionários que pertencem ao departamento de TI.
SELECT *
FROM funcionario
WHERE id_departamento = (
    SELECT id_departamento
    FROM departamento
    WHERE nome_departamento = 'TI'
)
ORDER BY id_funcionario;

-- o) Teste a chave estrangeira: o comando abaixo deve falhar porque
-- o departamento 999 não foi cadastrado. Execute separadamente se desejar testar.
-- INSERT INTO norm_ex10_funcionario
--     (id_funcionario, nome_funcionario, salario, id_departamento)
-- VALUES (99, 'Funcionário Inválido', 2500.00, 999);

-- p) A FOREIGN KEY impede associar um funcionário a um departamento inexistente.
