/*
Questão 01. Crie um procedimento chamado student_grade_points segundo os critérios abaixo:

a. Utilize como parâmetro de entrada o conceito. Exemplo: A+, A-, ...

b. Retorne os atributos das tuplas: Nome do estudante, Departamento do estudante, Título do curso, 
Departamento do curso, Semestre do curso, Ano do curso, Pontuação alfanumérica, Pontuação numérica.

c. Filtre as tuplas utilizando o parâmetro de entrada.
*/

CREATE PROCEDURE dbo.student_grade_points
    @grade VARCHAR(2)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        s.name AS Nome_Estudante,
        s.dept_name AS Departamento_Estudante,
        c.title AS Titulo_Curso,
        c.dept_name AS Departamento_Curso,
        t.semester AS Semestre_Curso,
        t.year AS Ano_Curso,
        t.grade AS Pontuacao_Alfanumerica,
        gp.points AS Pontuacao_Numerica
    FROM 
        dbo.student s
        INNER JOIN dbo.takes t ON s.ID = t.ID
        INNER JOIN dbo.course c ON t.course_id = c.course_id
        INNER JOIN dbo.grade_points gp ON t.grade = gp.grade
    WHERE 
        t.grade = @grade
    ORDER BY 
        s.name, t.year DESC, t.semester;
END
GO

/* Testando se deu certo */
EXEC dbo.student_grade_points 'A+';

/*
Questão 02. Crie uma função chamada return_instructor_location segundo os critérios abaixo:

a. Utilize como parâmetro de entrada o nome do instrutor.

b. Retorne os atributos das tuplas: Nome do instrutor, Curso ministrado, Semestre do curso, 
Ano do curso, prédio e número da sala na qual o curso foi ministrado

c. Exemplo: SELECT * FROM dbo.return_instructor_location('Gustafsson');
*/

CREATE FUNCTION dbo.return_instructor_location (@instructor_name VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        i.name AS Nome_Instrutor,
        t.course_id AS Curso_Ministrado,
        t.semester AS Semestre_Curso,
        t.year AS Ano_Curso,
        s.building AS Predio,
        s.room_number AS Numero_Sala
    FROM 
        dbo.instructor i
        INNER JOIN dbo.teaches t ON i.ID = t.ID
        INNER JOIN dbo.section s ON t.course_id = s.course_id 
            AND t.sec_id = s.sec_id 
            AND t.semester = s.semester 
            AND t.year = s.year
    WHERE 
        i.name = @instructor_name
);
GO

/* Testando se deu certo */
SELECT * FROM dbo.return_instructor_location('Gustafsson');
