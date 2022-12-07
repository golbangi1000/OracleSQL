/*
모든 평균은 소숫점 2자리까지 출력하되 반올림 해서 출력 하시오.  
1.  10 번 부서를 제외하고 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
2.  직책의 SALSMAN, PRESIDENT, CLERK 을 제외한 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오.   	
3. SMITH 과 동일한 부서에 근무하는 사원들 의 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
4. 부서별 최소월급을 가져오되 최소월급이 1000 이상인 것만 출력하세요. 
5.  부서별 월급의 합계가 9000 이상것만 출력
6. 부서별 월급의 평균이 2000 이상만 출력
7. 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력 하라. 
8. sub query - 부서별로 최소 급여를 받는 사용자의 이름과 급여와 직책과 부서번호를 출력하세요. 
9. sub query - 부서별로  부서별 평균 급여보다 많이 받는 사용자의  이름과 급여와 직책과 부서번호를 출력하세요. 
10. sub query - 직급이 SALESMAN이 아니면서 면서 급여가 임의의 SalesMan 보다 작은 사원을 출력
            SALESMAN 의 최대 값이 1600 보다 작은 사원들을 출력
11. sub query - 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해 오름차순 정렬하시오. 

*/

--1
SELECT SUM(SALARY), MAX(SALARY),AVG(SALARY),MIN(SALARY)
FROM EMPLOYEE 
WHERE DNO <> 10
GROUP BY DNO;

--2
SELECT SUM(SALARY), AVG(SALARY),MAX(SALARY),MIN(SALARY)
FROM EMPLOYEE
WHERE JOB NOT IN ('SALESMAN','PRESIDENT','CLERK')
GROUP BY DNO;
--3
SELECT SUM(SALARY), AVG(SALARY),MAX(SALARY),MIN(SALARY)
FROM EMPLOYEE
WHERE DNO = (SELECT DNO FROM EMPLOYEE WHERE ENAME = 'SMITH');

--4
SELECT MIN(SALARY)
FROM EMPLOYEE
GROUP BY DNO
HAVING MIN(SALARY) > 1000;

--5
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DNO
HAVING SUM(SALARY) > 9000;

--6
SELECT ROUND(AVG(SALARY),2)
FROM EMPLOYEE
GROUP BY DNO
HAVING AVG(SALARY) > 2000;

--7
SELECT ROUND(AVG(SALARY),2)
FROM EMPLOYEE 
WHERE SALARY > 1500
GROUP BY DNO
HAVING AVG(SALARY) > 2500;



--8
SELECT ENAME, SALARY, JOB,ENO,DNO
FROM EMPLOYEE
WHERE SALARY IN (
    SELECT MIN(SALARY) FROM EMPLOYEE
    GROUP BY DNO
);

SELECT ENO 사원번호 , ENAME 사원명
FROM EMPLOYEE
WHERE SALARY IN (   --이건 =을 못씀 단일값이 아니니깐 IN은 여러값도 가능  
    SELECT MIN(SALARY) FROM EMPLOYEE
    GROUP BY DNO
    --SUB QUERY: 부서별로 최소 월급을 출력 
);


--9

SELECT ENAME, SALARY, JOB, DNO
FROM EMPLOYEE
WHERE SALARY > (
SELECT AVG(SALARY) FROM EMPLOYEE
)
ORDER BY DNO;


--10 

SELECT ENAME, JOB, SALARY FROM EMPLOYEE
WHERE SALARY < ANY(SELECT SALARY FROM EMPLOYEE WHERE JOB = 'SALESMAN' AND SALARY < 1600 )
AND JOB <> 'SALESMAN';


--11

SELECT ENAME, ENO, SALARY FROM EMPLOYEE
WHERE SALARY > (
SELECT AVG(SALARY) FROM EMPLOYEE
)
ORDER BY SALARY DESC;
