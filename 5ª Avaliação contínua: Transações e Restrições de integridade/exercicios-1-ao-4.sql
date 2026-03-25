/*
Questão 01. Crie uma tabela pessoa com os campos ID, nome, sobrenome e idade. 
Crie uma cláusula de checagem para o campo idade, impedindo que valores menores que 0 sejam adicionados.
*/

CREATE TABLE pessoa (
	ID int,
	nome varchar(50),
	sobrenome varchar(50),
	idade int,
	CHECK(idade >= 0)
);

/* Incluindo dados válidos */
INSERT INTO pessoa (ID, nome, sobrenome, idade)
VALUES(1, 'Lucca', 'Rosa', 21);

/* Testando a validação */
INSERT INTO pessoa (ID, nome, sobrenome, idade)
VALUES(2, 'Ana', 'Vergueiro', -2); 

/*
Questão 02. Altere a tabela pessoa e crie uma restrição utilizando a especificação 
unique ( A1, A2, …, Am) para os campos ID, nome e sobrenome.
*/

ALTER TABLE pessoa
ADD CONSTRAINT unico UNIQUE (ID, nome, sobrenome);

/* Testando a validação */
INSERT INTO pessoa (ID, nome, sobrenome, idade)
VALUES(1, 'Lucca', 'Rosa', 21);

/*
Questão 03. Altere a coluna idade da tabela pessoa e garanta que ela não receba valores nulos.
*/

ALTER TABLE pessoa
ALTER COLUMN idade int NOT NULL;

/* Testando a validação */
INSERT INTO pessoa (ID, nome, sobrenome)
VALUES(2, 'Ana', 'Vergueiro'); 

/*
Questão 04. Crie uma tabela endereco com os campos ID e rua. 
Adicione o campo endereco na tabela pessoa e crie uma integridade referencial a partir deste 
campo com a tabela endereco.
*/

CREATE TABLE endereco (
	ID int PRIMARY KEY,
	rua varchar(100)
);

ALTER TABLE pessoa
ADD id_endereco int;

ALTER TABLE pessoa
ADD CONSTRAINT fk_endereco
FOREIGN KEY (id_endereco)
REFERENCES endereco(ID);

/* Testando a validação */
INSERT INTO endereco (ID, rua)
VALUES(1, 'Avenida Mutinga, 951');

UPDATE pessoa
SET id_endereco = 1
WHERE ID = 1;

SELECT 
	p.nome,
	p.idade,
	(SELECT rua FROM endereco e WHERE e.ID = p.id_endereco) AS endereco
FROM pessoa p;
