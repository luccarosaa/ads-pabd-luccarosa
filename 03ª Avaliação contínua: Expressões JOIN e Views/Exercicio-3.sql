/*
Questão 3. Criar uma view chamada 'civil_eng_students' a partir da relação construída na Questão 2.
*/
CREATE VIEW civil_eng_students AS
SELECT
    student.ID, 
    student.name,
    COUNT(takes.course_id) AS Quantidade_Cursos
FROM student
LEFT JOIN takes ON student.ID = takes.ID
WHERE student.dept_name = 'Civil Eng.'
GROUP BY student.ID, student.name;