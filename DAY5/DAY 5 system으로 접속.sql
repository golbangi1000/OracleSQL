SHOW USER;

SELECT * FROM DBA_TABLES;
SELECT * FROM DBA_SEQUENCES;
SELECT * FROM DBA_CONSTRAINTS;

SELECT * FROM DBA_CONSTRAINTS
WHERE OWNER = 'C##HR2';

SELECT * FROM DBA_CONSTRAINTS
WHERE OWNER = 'C##HR2' AND TABLE_NAME = 'EMPLOYEE';