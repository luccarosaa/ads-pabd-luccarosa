/*
Questão 01. Crie um SCHEMA chamado avaliacaocontinua no seu banco de dados para armazenar 
os objetos criados nas próximas questões.
*/

CREATE SCHEMA avaliacaocontinua;

/*
Questão 02. Crie a tabela company com os atributos company_name e city.
Utilize a restrição not null para o atributo company_name.
O atributo company_name deverá ser uma chave primária.
*/

CREATE TABLE avaliacaocontinua.company (
    company_name VARCHAR(255) NOT NULL PRIMARY KEY,
    city VARCHAR(255)
);

/*
Questão 03. Crie a tabela employee com os atributos person_name, street e city.
Utilize a restrição not null para o atributo person_name.
O atributo person_name deverá ser uma chave primária.
*/

CREATE TABLE avaliacaocontinua.employee (
    person_name VARCHAR(255) NOT NULL PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255)
);

/*
Questão 04. Crie a tabela manages com os atributos person_name e manager_name.
Utilize a restrição not null para o atributo person_name.
O atributo person_name deverá ser uma chave primária.
*/

CREATE TABLE avaliacaocontinua.manages (
    person_name VARCHAR(255) NOT NULL PRIMARY KEY,
    manager_name VARCHAR(255)
);

/*
Questão 05. Crie a tabela works com os atributos person_name, company_name e salary.
Utilize a restrição not null para o atributo person_name e company_name.
O atributo person_name deverá ser uma chave primária.
*/

CREATE TABLE avaliacaocontinua.works (
    person_name VARCHAR(255) NOT NULL PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2)
);

/*
Questão 06. Crie a integridade referencial entre a relação works e a relação employee.
O atributo person_name da relação works deverá existir na relação employee.
Utilize as ações em cascata: update e delete.
*/

ALTER TABLE avaliacaocontinua.works
    ADD CONSTRAINT fk_works_employee
    FOREIGN KEY (person_name)
    REFERENCES avaliacaocontinua.employee(person_name)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/*
Questão 07. Crie a integridade referencial entre a relação works e a relação company.
O atributo company_name da relação works deverá existir na relação company.
Utilize as ações em cascata: update e delete.
*/

ALTER TABLE avaliacaocontinua.works
    ADD CONSTRAINT fk_works_company
    FOREIGN KEY (company_name)
    REFERENCES avaliacaocontinua.company(company_name)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/*
Questão 08. Crie a integridade referencial entre a relação manages e a relação employee.
O atributo person_name da relação manages deverá existir na relação employee.
Utilize as ações em cascata: update e delete.
*/

ALTER TABLE avaliacaocontinua.manages
    ADD CONSTRAINT fk_manages_employee
    FOREIGN KEY (person_name)
    REFERENCES avaliacaocontinua.employee(person_name)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
