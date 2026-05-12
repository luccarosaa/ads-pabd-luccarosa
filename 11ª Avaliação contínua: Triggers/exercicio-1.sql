/*
Questão 01.

Ao realizar um curso o aluno ganha créditos.

Ao eliminar um curso da lista do aluno, os seus créditos totais deverão ser reduzidos.

Construa uma Trigger chamada dbo.lost_credits que atualiza o valor de créditos de um aluno 
após a retirada de um curso da sua lista.
*/

CREATE TRIGGER dbo.lost_credits
ON dbo.takes
AFTER DELETE AS
IF (ROWCOUNT_BIG() = 0)
RETURN;
BEGIN
    UPDATE dbo.student
    SET tot_cred = tot_cred - (
        SELECT SUM(c.credits)
        FROM deleted AS d
        INNER JOIN dbo.course AS c ON c.course_id = d.course_id
    )
    WHERE student.id IN (SELECT DISTINCT ID FROM deleted);
END;

-- Verificar créditos atuais (41 após o INSERT anterior)
SELECT ID, name, dept_name, tot_cred FROM student WHERE ID = '30299';

-- Remover o curso '105' que foi adicionado
DELETE FROM takes 
WHERE ID = '30299' AND course_id = '105' AND sec_id = '1' 
  AND semester = 'Fall' AND [year] = 2009;

-- Verificar créditos reduzidos (voltará para 38)
SELECT ID, name, dept_name, tot_cred FROM student WHERE ID = '30299';
