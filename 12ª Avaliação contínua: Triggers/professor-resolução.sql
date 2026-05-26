/*
Questão 01. 
Crie uma Trigger denominada dbo.trigger_prevent_assignment_teaches para impedir que aulas sejam atribuidas 
a um instrutor que já possui 2 ou mais atribuições no ano.
*/
CREATE TRIGGER dbo.trigger_prevent_assignment_teaches
ON dbo.teaches
AFTER INSERT AS
IF (ROWCOUNT_BIG() = 0)
RETURN;
IF EXISTS (SELECT 1  
           FROM inserted AS i   
           JOIN dbo.teaches AS t ON i.ID = t.ID AND i.[year] = t.[year] 
           GROUP BY t.ID, t.[year]
           HAVING count(*) >= 2
          )  
BEGIN  
RAISERROR ('Atribuição de aulas não permitida.', 16, 1);  
ROLLBACK TRANSACTION;  
RETURN   
END;

-- Exemplo de um instrutor que possui 2 atribuições em 2005
SELECT * FROM teaches WHERE ID = '19368';

-- Exemplo de atribuições de 2005 que poderiam ser associadas ao instrutor
SELECT course_id, sec_id, semester, [year], building, room_number, time_slot_id FROM [section] WHERE [year] = 2005;

-- Tentativa de atribuição mal sucedida. Trigger impediu a atribuição.
INSERT INTO teaches (ID, course_id, sec_id, semester, [year]) VALUES('19368', '362', '1', 'Fall', 2005);
