/*
Questão 01. O User_B poderá selecionar todos os atributos da relação INSTRUCTOR e TAKES, 
exceto salary e grade, respectivamente.

IMPORTANTE: O User_B foi criado na avaliação contínua anterior.
*/

GRANT SELECT ON takes TO User_B;
GRANT SELECT ON instructor TO User_B;


/*
Questão 02. O User_C poderá selecionar ou modificar a relação SECTION, 
mas só poderá recuperar e modificar os atributos course_id, sec_id, semester e year.

IMPORTANTE: O User_C foi criado na avaliação contínua anterior.
*/

GRANT SELECT, UPDATE ON section TO User_C;

/*
Questão 03. O User_D poderá selecionar qualquer atributo das relações INSTRUCTOR e STUDENT. 
Poderá selecionar os atributos da view grade_points.

IMPORTANTE: O User_D foi criado na avaliação contínua anterior.
*/

GRANT SELECT ON instructor TO User_D;
GRANT SELECT ON student TO User_D;
GRANT SELECT ON dbo.grade_points TO User_D;

/*
Questão 04. O User_E poderá selecionar qualquer atributo de STUDENT, 
mas somente para tuplas de STUDENT que tem dept_name = ‘Civil Eng.’

IMPORTANTE: O User_E foi criado na avaliação contínua anterior.
*/

GRANT SELECT ON dbo.civil_eng_students TO User_D;

/*
Questão 05. Revogue os privilégios do usuário User_E
*/

REVOKE SELECT ON dbo.civil_eng_students FROM User_E;

/*
Questão 06. Mostre os privilégios concedidos aos usuários 'User_A', 'User_B', 'User_C', 'User_D' e 'User_E'.
*/

SELECT  princ.name
,       princ.type_desc
,       perm.permission_name
,       perm.state_desc
,       perm.class_desc
,       object_name(perm.major_id)
FROM    sys.database_principals princ
LEFT JOIN
        sys.database_permissions perm
ON      perm.grantee_principal_id = princ.principal_id
WHERE princ.type_desc = 'SQL_USER'
AND princ.name IN ('User_A', 'User_B', 'User_C', 'User_D', 'User_E')
ORDER BY princ.name;
