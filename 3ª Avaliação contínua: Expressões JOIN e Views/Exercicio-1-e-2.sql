/*
Questão 1. Crie uma relação a partir da união das tabelas student e takes.
*/
SELECT * FROM student
LEFT JOIN takes ON student.ID = takes.ID;

/*
Questão 2. Contar a quantidade de cursos realizados pelos alunos do departamento de Civil Eng. 

Ordenar de maneira descendente a quantidade de cursos associada aos alunos.
*/
SELECT
    student.ID, 
    student.name,
    COUNT(takes.course_id) AS Quantidade_Cursos
FROM student
LEFT JOIN takes ON student.ID = takes.ID
WHERE student.dept_name = 'Civil Eng.'
GROUP BY student.ID, student.name
ORDER BY Quantidade_Cursos DESC;
