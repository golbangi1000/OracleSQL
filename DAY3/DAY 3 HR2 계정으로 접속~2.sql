SHOW USER;


--CHAPTER04 : 그룹 함수

/*
 그룹함수 : 동일한 값에 대해서 그룹핑해서 처리하는 함수
    GROUP BY 절에 특정 컬럼을 정의할경우, 해당 컬럼의 동일한 값을 그룹핑해서 연산 처리 

집계함수 : 연산을 처리하는 함수
    -SUM : 합계를 구하는 함수
    -AVG : 평균을 구하는 함수
    -MAX : 최대값을 출력
    -MIN : 최소값을 출력
    -COUNT : 레코드수(한 라인의 값이 저장된) , ROW (행) 
    
    
    SELECT 컬럼명
    FROM 테이블명 
    WHERE 조건
    GROUP BY 그룹핑할컬럼
    HAVING GROUP BY를 사용해서 나온 결과에서 조건을 처리
    ORDER BY 정렬 
*/

--다른 컬럼을 찍게 되면 에러뜸 SALARY를 넣으면 여러행이 있어서 오류가 뜸 
--집계함수를 컬럼에 사용하면 단일행으로 출력됨 
SELECT SUM(SALARY) AS 합계 , AVG(SALARY) AS 평균,
    MAX(SALARY) AS 최대월급, MIN(SALARY) AS 최소월급
FROM EMPLOYEE;

--집계함수는 NULL을 0으로 자동으로 처리해서 연산 

SELECT COMMISSION
FROM EMPLOYEE;--COMMISSION은 NULL이 있다

SELECT SUM(COMMISSION), AVG(COMMISSION), MAX(COMMISSION), MIN(COMMISSION)
FROM EMPLOYEE;


--COUNT 함수 : 레코드수, ROW(행) 수,

--NULL은 카운트되지 않음 
SELECT COUNT(ENO) AS 레코드수
FROM EMPLOYEE;


--보너스를 받는 사원수
SELECT COUNT(COMMISSION) 
FROM EMPLOYEE;

--특정 컬럼을 COUNT함수를 사용하면 전체 레코드 수를 부정확하게 출력 할수있다
        --NOT NULL 로 정의된 컬러을 카운트해야한다.
    
DESC EMPLOYEE; --ENO컬럼은 NOTNULL 컬럼이라 NULL이 없음 그래서 전체레코드수를 정확히 카운트 가능 

SELECT * FROM EMPLOYEE;

-- 테이블의 전체 레코드 수를 출력시 : NOT NULL 지정된 컬럼이나, * 를 사용해서 COUNT 해야된다 
SELECT COUNT ( ENO) FROM EMPLOYEE;
SELECT COUNT (*) FROM EMPLOYEE;

--직업 갯수

SELECT COUNT( DISTINCT JOB)
FROM EMPLOYEE;


--부서의 갯수

SELECT COUNT(DISTINCT DNO) 부서갯수
FROM EMPLOYEE;


--부서별로 급여의 합계, 평균, 최댓값, 최솟값 구하기 : GROUP BY<== 컬럼에 동일한 값을 그룹핑해서 처리
SELECT * FROM EMPLOYEE
ORDER BY DNO ASC;


SELECT SUM(SALARY) 부서별월급합계, AVG(SALARY) 부서별월급평균, 
MAX(SALARY) 부서별최대궐급, MIN(SALARY) 부서별최소월급, DNO
FROM EMPLOYEE
GROUP BY DNO        --DNO컬럼의 동일한 값을 그룹핑 다 DNO 별로 그룹핑해서 한거 
ORDER BY DNO;




--직책별로 월급의 합계, 평균, 최대값, 최소값을 출력.

SELECT SUM(SALARY), MAX(SALARY),AVG (SALARY), JOB
FROM EMPLOYEE
GROUP BY JOB
ORDER BY JOB;



SELECT *
FROM EMPLOYEE
WHERE JOB = 'ANALYST';



--GROUP BY 에서 나온 결과를 조건으로 처리해서 출력: HAVING<조건>
-- 별칭이름을 사용해서 조건을 처리하면 오류가 발생


--직책별 평균월급이 2000만원 이상인것만 출력
SELECT SUM(SALARY), ROUND(AVG(SALARY)), MAX(SALARY), MIN(SALARY), JOB
FROM EMPLOYEE
GROUP BY JOB
HAVING  ROUND(AVG(SALARY)) >=2000 --GROUP BY를 사용해서 나온결과에 대한 조건 처리 
ORDER BY JOB;


--HAVING절에서 별칭을이름을 사용할경우 오류 발생  <주의>

--SELECT SUM(SALARY), ROUND(AVG(SALARY)), MAX(SALARY), MIN(SALARY), JOB
--FROM EMPLOYEE
--GROUP BY JOB
--HAVING  직책월급평균 >=2000 --GROUP BY를 사용해서 나온결과에 대한 조건 처리 
--ORDER BY JOB;


--WHERE : 테이블의 값을 조건을 주어서 가지고 올때 사용. 
--HAVING : GROUP BY를 사용해서 나온 결과를 조건으로 출력

--20번부서는 제외하고 부서별 합계, 평균, 최대값, 최소값을 구하되 부서별 최소월급이 1000만원이상인것만 출력
SELECT SUM(SALARY), TRUNC(AVG(SALARY)), MAX(SALARY), MIN(SALARY), DNO
FROM EMPLOYEE
WHERE DNO !=( 20)    --IN 이나 NOT IN 쓰면 여러개 넣을수있음  <== 조건을 사용해서 원하는 값만 테이블에서 가져온후
GROUP BY DNO
HAVING MIN(SALARY) >= 1000;

--두컬럼이상을 그룹핑하기 : 두컬럼 모두 동일할때 그룹핑 처리됨.

SELECT DNO, JOB
FROM EMPLOYEE
ORDER BY DNO, JOB;
--
--COUNT(*)를 사용하면 중복된 레코드가 몇개인지 확인 
SELECT SUM (SALARY), ROUND (AVG(SALARY),MAX(SALARY)), MIN(SALARY), DNO, JOB, COUNT(*)
FROM EMPLOYEE
GROUP BY DNO, JOB  --두컬럼에 걸쳐서 동일한 것을 그룹핑한다
ORDER BY DNO, JOB;

--group by 를 사용하면서 select 절에 출력할 컬럼 
    -- 집계함수 (sum, avg, max, min), count(*) 몇개가 그룹됐는지 알수있다 
        -- GROUP BY에 쓴 컬럼은 SELECT에 쓸수있음 


--ROLLUP : 마지막라인에 전체 합계, 전체 평균을 추가적으로 출력 : GROUP BY 절에서 사용됨
SELECT SUM(SALARY) , ROUND( AVG(SALARY)), MAX(SALARY), MIN(SALARY),DNO,COUNT(*)
FROM EMPLOYEE
GROUP BY DNO
ORDER BY DNO DESC;
--ROLLUP 사용 : 그룹핑한 집계함수도 출력, 마지막라인에 전체에 대한 집계 함수도 같이 출력됨
SELECT SUM(SALARY), ROUND (AVG(SALARY)), MAX(SALARY),MIN(SALARY), DNO, COUNT(*)
FROM EMPLOYEE
GROUP BY ROLLUP (DNO)
ORDER BY DNO ASC;



-- CUBE:
SELECT SUM(SALARY), ROUND (AVG(SALARY)), MAX(SALARY),MIN(SALARY), DNO, COUNT(*)
FROM EMPLOYEE
GROUP BY CUBE (DNO)
ORDER BY DNO ASC;


--===================================================
/*
 서브 쿼리 (SUB QUERY) : SELECT 문 내에 SELECT 문이 들어 있는 쿼리
*/

--ENAME 이 SCOTT인 사원과 동일한 부서의 사원을 출력

SELECT * FROM EMPLOYEE;
    --SUB QUERY 를 사용하지 않고 출력
            --1. SCOTT의 부서를 확인
SELECT ENAME, JOB FROM EMPLOYEE WHERE ENAME = 'SCOTT';

--2. SCOTT 의 부서와 동일한 부서를 조건을 사용해서 출력
SELECT ENAME, JOB FROM EMPLOYEE WHERE JOB = 'ANALYST';

--3. SUB QUERY를 사용해서 한라인에서 출력

SELECT ENAME, JOB FROM EMPLOYEE WHERE JOB = (SELECT JOB FROM EMPLOYEE WHERE ENAME = 'SCOTT');

SELECT * FROM EMPLOYEE;

--SMITH 와 동일한 직책의 사원들을 SUB QUERY를 사용해서 출력

SELECT ENAME, JOB FROM EMPLOYEE WHERE JOB = ( SELECT JOB FROM EMPLOYEE WHERE ENAME = 'SMITH');

--SCOTT보다 월급이 많은 사용자, 서브쿼리한 결과값이 단일 값으로 출력되어야 한다
SELECT ENAME, SALARY FROM EMPLOYEE WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE ENAME= 'SCOTT');


--SCOTT 과 동일한 부서에 근무하는 사원들 출력 하기
SELECT ENAME, DNO FROM EMPLOYEE WHERE DNO = (SELECT DNO FROM EMPLOYEE WHERE ENAME = 'SCOTT');


--최소 급여를 받는 사원의 이름, 담당 업무 , 급여 출력하기

SELECT ENAME, JOB, SALARY FROM EMPLOYEE 
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);


-- 각 부서의 최소급여가 30번 부서 DNO의 최소 급여보다 큰 부서를 출력
-- 각 부서의 최소급여를 구함
-- 30 부서의 최소급여 보다 큰 부서를 출력.
SELECT DNO , MIN (SALARY) , COUNT(*)
FROM EMPLOYEE
GROUP BY DNO
HAVING MIN (SALARY) > (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DNO = 30)  --30번 부서의 최소 급여를 
ORDER BY DNO;


--SUB QUERY에서 단일 값이 아니라 여러개의 값이 출력될 경우 : IN 연산다를 사용

--각 부서별로 최소 급여를 받는 사원의 사원 번호와 이름을 출력 

SELECT ENO 사원번호 , ENAME 사원명
FROM EMPLOYEE
WHERE SALARY IN (   --이건 =을 못씀 단일값이 아니니깐 IN은 여러값도 가능  --부서별로 비교하는거니깐  IN을 써서 비교 
    SELECT MIN(SALARY) FROM EMPLOYEE
    GROUP BY DNO
    --SUB QUERY: 부서별로 최소 월급을 출력 
);
SELECT MIN(SALARY) FROM EMPLOYEE --이걸로 확인해보면 여러값
    GROUP BY DNO;
    
--ALL 연산다 : SUB QUERY에서 반환하는 모든 값을 비교
/*
 ' > ALL' : 최대값 보다 큼을 나타냄
 ' < ALL' : 최소값 보다 작음을 나타냄
 
*/
--직급이 SALESMAN이 아니면서 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력 
SELECT * FROM EMPLOYEE
ORDER BY JOB ASC;

SELECT ENO, ENAME, JOB , SALARY
FROM EMPLOYEE
WHERE SALARY < ALL(SELECT SALARY FROM EMPLOYEE WHERE JOB = 'SALESMAN')
AND JOB <> 'SALESMAN';  -- <> 뜻은 아니다 

--담당 업무가 분석(ANALYST)인 사원보다 급여가 적으면서 업무 분석가가 아닌 사원들을 표시하시오

SELECT ENAME, JOB, SALARY FROM EMPLOYEE
WHERE SALARY < ALL(SELECT SALARY FROM EMPLOYEE WHERE JOB = 'ANALYST')
AND JOB <> 'ANALYST';

/*
ANY 연산자
서브쿼리가 반환하는 각각의 값과 비교함
< ANY 는 최대값보다 작음을 나타잼
> ANY는 최소값 보다 큼을 나타냄
= ANY는 IN과 동일함

*/



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
SELECT ENAME, SALARY, JOB,ENO
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















