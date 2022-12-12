SHOW USER;

--1
SELECT D.DNO, DNAME,ENAME 
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO
AND E.ENAME = 'SCOTT';


--2
SELECT E.DNO, LOC, DNAME
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DNO = D.DNO;


--3
SELECT E.DNO, LOC, JOB, ENAME
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DNO = D.DNO
WHERE E.DNO = 10;


--4
SELECT ENAME, LOC, DNAME
FROM EMPLOYEE E NATURAL JOIN DEPARTMENT D;

--5
SELECT ENAME, DNAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO AND ENAME LIKE '%A%';


--6
SELECT ENAME, JOB,DNO, DNAME
FROM EMPLOYEE E NATURAL JOIN DEPARTMENT D
WHERE LOC = 'NEW YORK';

--7
SELECT E.ENAME 사원이름, E.ENO 사원번호,E.MANAGER 관리자번호, M.ENAME 관리자이름
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER = M.ENO;

--8
SELECT E.ENAME 사원이름, E.ENO 사원번호,E.MANAGER 관리자번호, M.ENAME 관리자이름
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER = M.ENO(+)
ORDER BY E.ENO DESC;


--9
SELECT E.ENAME 이름, E.DNO 부서번호, M.ENAME 
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.DNO = M.DNO AND E.ENAME = 'SCOTT' AND M.ENAME <> 'SCOTT';


--10 

SELECT D.HIREDATE, D.ENAME
FROM EMPLOYEE E, EMPLOYEE D
WHERE E.HIREDATE < D.HIREDATE AND E.ENAME = 'WARD'
ORDER BY D.HIREDATE;

SELECT HIREDATE FROM EMPLOYEE WHERE ENAME = 'WARD';

SELECT * FROM EMPLOYEE WHERE HIREDATE > '81/02/22';
--11
SELECT E.ENAME 사원이름,E.HIREDATE 사원입사일, D.ENAME 관리자이름, D.HIREDATE 관리자입사일
FROM EMPLOYEE E, EMPLOYEE D
WHERE E.MANAGER = D.ENO AND E.HIREDATE < D.HIREDATE;


--1
SELECT E.ENAME, D.JOB , D.ENAME
FROM EMPLOYEE E, EMPLOYEE D
WHERE E.JOB = D.JOB AND E.ENO = 7788 AND D.ENO <> 7788;

SELECT ENAME, JOB
FROM EMPLOYEE
WHERE JOB = (SELECT JOB FROM EMPLOYEE WHERE ENO = 7788) AND ENO <> 7788; 

--2

SELECT ENAME, JOB
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE ENO = 7499) AND ENO <> 7499; 


--3
SELECT SALARY, ENAME, JOB
FROM EMPLOYEE
WHERE SALARY IN(
    SELECT MIN(SALARY) FROM EMPLOYEE
    GROUP BY DNO
);

SELECT MIN(SALARY)
FROM EMPLOYEE
GROUP BY DNO;


--4

SELECT JOB, (SELECT AVG(SALARY) FROM EMPLOYEE)
FROM EMPLOYEE 
WHERE SALARY <( 
    SELECT AVG(SALARY) FROM EMPLOYEE
);


--5
SELECT SALARY, JOB , ENAME
FROM EMPLOYEE
WHERE SALARY IN (
SELECT MIN(SALARY) FROM EMPLOYEE
GROUP BY DNO
);


--6
SELECT ENO, ENAME, JOB, SALARY
FROM EMPLOYEE
WHERE SALARY <ANY(SELECT SALARY FROM EMPLOYEE WHERE JOB = 'ANALYST')
AND JOB <> 'ANALYST';

--7
SELECT ENAME
FROM EMPLOYEE
WHERE ENO <>ALL(SELECT NVL(MANAGER,0) FROM EMPLOYEE);

SELECT MANAGER FROM EMPLOYEE;


--8

SELECT ENAME
FROM EMPLOYEE
WHERE ENO =ANY(SELECT NVL(MANAGER,0) FROM EMPLOYEE);


--9
SELECT ENAME, HIREDATE
FROM EMPLOYEE
WHERE DNO = (SELECT DNO FROM EMPLOYEE WHERE ENAME = 'BLAKE') AND
ENAME <> 'BLAKE';

--10
SELECT ENO, ENAME 
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY  SALARY DESC; 


--11
SELECT ENO, ENAME
FROM EMPLOYEE
WHERE DNO =ANY(SELECT DNO FROM EMPLOYEE WHERE ENAME LIKE '%K%');

SELECT * FROM EMPLOYEE;
--12
SELECT  E.ENAME, E.DNO, E.JOB
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO AND D.LOC = 'DALLAS';

SELECT ENAME, ENO ,JOB
FROM EMPLOYEE
WHERE DNO =(SELECT DNO FROM DEPARTMENT WHERE LOC = 'DALLAS');



--13
SELECT ENAME, SALARY 
FROM EMPLOYEE 
WHERE MANAGER =ANY(SELECT ENO FROM EMPLOYEE WHERE ENAME = 'KING');


--14
SELECT DNO, ENAME, JOB
FROM EMPLOYEE
WHERE DNO = (SELECT DNO FROM DEPARTMENT WHERE DNAME = 'RESEARCH');



--15
SELECT ENO,ENAME, SALARY
FROM EMPLOYEE
WHERE SALARY >(SELECT AVG(SALARY) FROM EMPLOYEE) AND ENAME LIKE '%M%';

SELECT * FROM EMPLOYEE WHERE ENAME LIKE '%M%';
SELECT AVG(SALARY) FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;

--16
SELECT JOB
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--17
SELECT ENAME
FROM EMPLOYEE
WHERE DNO =ANY(SELECT DNO FROM EMPLOYEE WHERE JOB = 'MANAGER');




