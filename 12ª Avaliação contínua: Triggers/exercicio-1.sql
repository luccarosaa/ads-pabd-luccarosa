/*
Questão 01. 

Crie uma Trigger denominada dbo.trigger_prevent_assignment_teaches 
para impedir que aulas sejam atribuidas a um instrutor que já possui 
2 ou mais atribuições no ano.
*/

CREATE TRIGGER dbo.trigger_prevent_assignment_teaches
ON dbo.teaches
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar se a inserção violaria a regra
    IF EXISTS (
        SELECT 1
        FROM (
            -- Registros existentes
            SELECT ID, [year], COUNT(*) AS qtd
            FROM dbo.teaches
            GROUP BY ID, [year]
            
            UNION ALL
            
            -- Novos registros sendo inseridos
            SELECT ID, [year], COUNT(*) AS qtd
            FROM inserted
            GROUP BY ID, [year]
        ) AS combined
        GROUP BY ID, [year]
        HAVING SUM(qtd) > 2
    )
    BEGIN
        RAISERROR('Instrutor já possui 2 ou mais atribuições no ano.', 16, 1);
        RETURN;
    END
    
    -- Se passou na verificação, insere os dados
    INSERT INTO dbo.teaches (ID, course_id, sec_id, semester, [year])
    SELECT ID, course_id, sec_id, semester, [year]
    FROM inserted;
END;


-- Verificar situação atual
SELECT ID, [year], COUNT(*) AS total
FROM dbo.teaches
WHERE ID = '14365'
GROUP BY ID, [year];

-- Tentar inserir a primeira aula (não deve funcionar)
INSERT INTO dbo.teaches (ID, course_id, sec_id, semester, [year])
VALUES ('14365', '105', '1', 'Fall', 2009);
