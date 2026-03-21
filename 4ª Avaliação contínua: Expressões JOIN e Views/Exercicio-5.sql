/*
Questão 5. Crie uma view a partir do resultado da Questão 4 com o nome “coeficiente_rendimento”.
*/

CREATE VIEW coeficiente_rendimento AS
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
        INNER JOIN grade_points gp ON t.grade = gp.grade;
