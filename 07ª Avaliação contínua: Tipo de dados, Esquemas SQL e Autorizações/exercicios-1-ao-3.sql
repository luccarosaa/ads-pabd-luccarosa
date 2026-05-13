/*
Questão 01. Crie as contas de usuário User_A, User_B, User_C, User_D e User_E.
*/

CREATE USER User_A WITH PASSWORD = 'PT3037479x';
CREATE USER User_B WITH PASSWORD = 'PT3037479x';
CREATE USER User_C WITH PASSWORD = 'PT3037479x';
CREATE USER User_D WITH PASSWORD = 'PT3037479x';
CREATE USER User_E WITH PASSWORD = 'PT3037479x';

/*
Questão 02. Considere o esquema de banco de dados relacional university.

O User_A poderá selecionar ou modificar qualquer relação, exceto CLASSROOM, 
e pode conceder qualquer um desses privilégios a outros usuários.
*/

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO User_A;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.CLASSROOM FROM User_A;

/*
Questão 03. Liste as permissões do User_A.
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
AND princ.name = 'User_A'
ORDER BY princ.name;
