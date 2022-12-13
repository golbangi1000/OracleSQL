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

SELECT DNO, LOC, JOB  
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
USING (DNO)  --INNER JOIN 할때는 USING도 가능 
WHERE E.DNO = 10;

--4
SELECT ENAME, LOC, DNAME
FROM EMPLOYEE E NATURAL JOIN DEPARTMENT D
WHERE COMMISSION IS NOT NULL;

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

SELECT E.ENAME 사원이름, E.ENO 사원번호,E.MANAGER 관리자번호, M.ENAME 관리자이름
FROM EMPLOYEE E JOIN EMPLOYEE M
ON E.MANAGER = M.ENO;

--8
SELECT E.ENAME 사원이름, E.ENO 사원번호,E.MANAGER 관리자번호, M.ENAME 관리자이름
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER = M.ENO (+)
ORDER BY E.ENO DESC; --이건 OUTER JOIN 

SELECT E.ENAME 사원이름, E.ENO 사원번호,E.MANAGER 관리자번호, M.ENAME 관리자이름
FROM EMPLOYEE E LEFT OUTER JOIN EMPLOYEE M   --LEFT OUTER JOIN 
ON E.MANAGER = M.ENO
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


select ename 사원이름, job 담당업무
from employee
where job = (select job
             from employee
             where eno = '7788');
--2

SELECT ENAME, JOB
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE ENO = 7499) AND ENO <> 7499;
                                                            --> 이니깐 어차피 포함안되서 안써도됨

select ename 사원이름, job 담당업무
from employee
where salary > (select salary
               from employee
               where eno = '7499');

--3
SELECT SALARY, ENAME, JOB
FROM EMPLOYEE
WHERE SALARY IN(
    SELECT MIN(SALARY) FROM EMPLOYEE
);
select ename 사원이름, job 담당업무, salary 급여
from employee
where salary in (select min(salary)
                from employee
                group by job);



--4

SELECT JOB, TRUNC((SELECT AVG(SALARY) FROM EMPLOYEE)) AS AVG, SALARY
FROM EMPLOYEE 
WHERE SALARY <( 
    SELECT AVG(SALARY) FROM EMPLOYEE
);

SELECT JOB, TRUNC((SELECT MIN(SALARY) FROM EMPLOYEE)) AS AVG, SALARY
FROM EMPLOYEE 
WHERE SALARY =( 
    SELECT MIN(SALARY) FROM EMPLOYEE
);

select min(salary) 급여, job 직급
from employee
group by job
having avg(salary)  <= all (select avg(salary)
                            from employee
                            group by job);
select min(salary) 급여, job 직급
from employee
group by job;

--5
SELECT SALARY, JOB , ENAME,DNO
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY) 
                FROM EMPLOYEE
                GROUP BY DNO
);
select ename 사원이름, salary 급여, dno 부서번호
from employee
where salary in (select min(salary)
                 from employee
                 group by dno);



--6
SELECT ENO, ENAME, JOB, SALARY
FROM EMPLOYEE
WHERE SALARY <ANY(SELECT SALARY FROM EMPLOYEE WHERE JOB = 'ANALYST')
AND JOB <> 'ANALYST';

select eno 사원번호, ename 사원이름, job 담당업무, salary 급여
from employee
where salary < all (select salary
                    from employee
                    where job = 'ANALYST')
and job <> 'ANALYST';

--7
SELECT ENAME
FROM EMPLOYEE
WHERE ENO <>ALL(SELECT NVL(MANAGER,0) FROM EMPLOYEE);

SELECT MANAGER FROM EMPLOYEE;

select ename
from employee
where eno in (select m.eno
              from employee e right outer join employee m
              on e.manager = m.eno
              where e.eno is null);      


--8

SELECT ENAME
FROM EMPLOYEE
WHERE ENO =ANY(SELECT NVL(MANAGER,0) FROM EMPLOYEE)
ORDER BY ENAME;


select ename
from employee
where eno in (select distinct manager
              from employee)
ORDER BY ENAME;

--9
SELECT ENAME, HIREDATE
FROM EMPLOYEE
WHERE DNO = (SELECT DNO FROM EMPLOYEE WHERE ENAME = 'BLAKE') AND
ENAME <> 'BLAKE';

select ename 사원이름, hiredate 입사일, dno 부서번호
from employee
where dno = (select dno
             from employee
             where ename ='BLAKE')
and ename <> 'BLAKE';




--10
SELECT ENO, ENAME 
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY  SALARY ASC; 


select eno 사원번호, ename 사원이름, salary 급여
from employee
where salary > (select avg(salary)
                from employee)
order by salary asc;

--11
SELECT ENO, ENAME
FROM EMPLOYEE
WHERE DNO =ANY(SELECT DNO FROM EMPLOYEE WHERE ENAME LIKE '%K%');

SELECT * FROM EMPLOYEE;

select eno 사원번호, ename 사원이름, dno 부서번호
from employee
where dno in (select dno
             from employee
             where ename like '%K%');
             
             
--12
SELECT  E.ENAME, E.DNO, E.JOB
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO AND D.LOC = 'DALLAS';

SELECT ENAME, ENO ,JOB
FROM EMPLOYEE
WHERE DNO =(SELECT DNO FROM DEPARTMENT WHERE LOC = 'DALLAS');

select ename 사원이름, dno 부서번호, job 담당업무
from employee
where dno in (select dno
              from department
              where loc = 'DALLAS');

--13
SELECT ENAME, SALARY 
FROM EMPLOYEE 
WHERE MANAGER =ANY(SELECT ENO FROM EMPLOYEE WHERE ENAME = 'KING');

select ename 사원이름, salary 급여
from employee
where manager = (select eno
                from employee
                where ename = 'KING');
--14
SELECT DNO, ENAME, JOB
FROM EMPLOYEE
WHERE DNO = (SELECT DNO FROM DEPARTMENT WHERE DNAME = 'RESEARCH');


select dno 부서번호, ename 사원이름, job 담당업무
from employee
where dno = (select dno
            from department
            where dname = 'RESEARCH');
--15
SELECT ENO,ENAME, SALARY
FROM EMPLOYEE
WHERE SALARY >(SELECT AVG(SALARY) FROM EMPLOYEE) AND DNO =ANY(SELECT DNO
                                                            FROM EMPLOYEE
                                                            WHERE ENAME LIKE '%M%');


select eno 사원번호, ename 사원이름, salary 급여
from employee
where salary > (select avg(salary)
                from employee)
and dno in (select dno
           from employee
           where ename like '%M%');
--16
SELECT JOB
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

select job 업무
from employee
group by job
having avg(salary) <= all (select avg(salary)
                          from employee
                          group by job);
--17
SELECT ENAME
FROM EMPLOYEE
WHERE DNO =ANY(SELECT DNO FROM EMPLOYEE WHERE JOB = 'MANAGER');




