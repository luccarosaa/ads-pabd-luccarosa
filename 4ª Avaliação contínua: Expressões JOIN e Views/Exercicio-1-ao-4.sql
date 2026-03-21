/* 
Questão 1. Gere uma lista de todos os instrutores, mostrando sua ID, nome e número de seções 
que eles ministraram. Não se esqueça de mostrar o número de seções como 0 para os instrutores 
que não ministraram qualquer seção. 
Sua consulta deverá utilizar outer join e não deverá utilizar subconsultas escalares.
*/

SELECT 
    i.ID, 
    i.name, 
    COUNT(t.course_id) AS seções_ministradas
FROM instructor i
LEFT OUTER JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID, i.name;

/*
Questão 2. Escreva a mesma consulta do item anterior, mas usando uma subconsulta escalar, 
sem outer join.
*/

SELECT 
    i.ID, 
    i.name, 
    (SELECT COUNT(*) FROM teaches t WHERE t.ID = i.ID) AS seções_ministradas
FROM instructor i;

/*
Questão 3. Gere a lista de todas as seções de curso oferecidas na primavera de 2010, 
junto com o nome dos instrutores ministrando a seção. Se uma seção tiver mais de 1 instrutor, 
ela deverá aparecer uma vez no resultado para cada instrutor. Se não tiver instrutor algum, 
ela ainda deverá aparecer no resultado, com o nome do instrutor definido como “-”.
*/

SELECT 
    s.course_id, 
    s.sec_id, 
    COALESCE(i.name, '-') AS "Nome instrutor"
FROM section s
LEFT OUTER JOIN teaches t ON s.course_id = t.course_id AND s.sec_id = t.sec_id
LEFT OUTER JOIN instructor i ON t.ID = i.ID
WHERE s.semester = 'Spring' AND s.year = 2010;

/*
Questão 4. Suponha que você tenha recebido uma relação grade_points (grade, points), 
que oferece uma conversão de conceitos (letras) na relação takes para notas numéricas; 
por exemplo, uma nota “A+” poderia ser especificada para corresponder a 4 pontos, 
um “A” para 3,7 pontos, e “A-” para 3,4, e “B+” para 3,1 pontos, e assim por diante. 

Os Pontos totais obtidos por um aluno para uma oferta de curso (section) são definidos como 
o número de créditos para o curso multiplicado pelos pontos numéricos para a nota que o aluno recebeu.

Dada essa relação e o nosso esquema university, escreva: 

Ache os pontos totais recebidos por aluno, para todos os cursos realizados por ele.
*/

CREATE TABLE [dbo].[grade_points] (
    [grade] varchar(2) NOT NULL,
    [points] numeric(3,1) NOT NULL,
    PRIMARY KEY ([grade])
);

INSERT INTO [dbo].[grade_points] ([grade], [points]) VALUES
('A+', 4.0),
('A', 3.7),
('A-', 3.3),
('B+', 3.0),
('B', 2.7),
('B-', 2.3),
('C+', 2.0),
('C', 1.7),
('C-', 1.3),
('D+', 1.0),
('D', 0.7),
('F', 0.0);

SELECT
    s.ID,
    s.name,
    c.title,
    c.dept_name,
    t.grade,
    gp.points,
    c.credits,
    (c.credits * gp.points) AS "Pontos totais"
FROM student s
    INNER JOIN takes t ON s.ID = t.ID
    INNER JOIN course c ON t.course_id = c.course_id
    INNER JOIN grade_points gp ON t.grade = gp.grade
ORDER BY s.ID, c.course_id;
