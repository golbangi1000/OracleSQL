show user;


/*
    조인, 뷰, 인덱스 
*/

/* 
    조인(Join): 두개 이상의 테이블의 컬럼을 출력시 join을 사용해서 컴럼의 정보를 가져온다
        --EMPLOYEE, DEPARTMENT 테이블은 원래 하나의 테이블이었다
        --모델링을(중복제거, 성능향상) 을 사용해서 두테이블로 분리되었습니다 
        -- 두개 이상의 테이블에 컬럼을 가져오기 위해서는JOIN 문을 사용해서 출력
        -- 두 테이블을 JOIN하기 위해서는 두 테이블에서 공통의 키 컬럼이 존재 해야한다
        --ANSI 호환 JOIN : 모든 SQL에서 공통으로 사용하는 JOIN 구문 
            ORACLE, MYSQL, MS SQL, MARIA DB 
*/


-- EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN, <==오라클에서만 사용.
    --ANSI 호환의 SQL 구문에서 INNER JOIN 과 같은 구문
        -- 두 테이블에서 공통으로 적용된 값만 출력해줌. <교집합>
        
    --FROM  절에 JOIN 할 테이블을 명시 , ' , ' 를 사용해서 나열
    --WHERE 절에 두테이블의 공통의 KEY 컬럼을 찾아서 ' = ' 
    --AND 절에서 조건을 처리 
    --두 테이블의 공통의 키컬럼을 SELECT 문에서 출력 할때
        --명시하지 않으면 오류 발생
SELECT ENO AS 사원번호, ENAME AS 사원명, EMPLOYEE.DNO AS 부서번호, DNAME 부서명, LOC 부서위치
FROM EMPLOYEE, DEPARTMENT                   -- 조인할 테이블 나열: ,
WHERE EMPLOYEE.DNO = DEPARTMENT.DNO         -- 두 테이블의 공통의 키 컬럼을 찾아서 : '=' 로처리 
AND EMPLOYEE.DNO >= 20;                     -- 조건을 처리 

--공통 KEY컬럼 이외에는 생략해도됨
SELECT  EMPLOYEE.ENO,EMPLOYEE.ENAME , EMPLOYEE.DNO, DNAME, LOC
FROM EMPLOYEE, DEPARTMENT 
WHERE EMPLOYEE.DNO = DEPARTMENT.DNO
AND EMPLOYEE.DNO >=20;

--테이블 이름을 알리어스 (별칭) GOTJ TKDYD <== 주로 사용

--중복 자주되는것들은 메모리낭비니깐 테이블을 따로 둠 
SELECT ENO, ENAME, SALARY, HIREDATE, LOC, DNAME,  E.DNO
FROM EMPLOYEE E, DEPARTMENT D     --별칭으로 바꿨으니깐 별칭을 써야됨 
WHERE E.DNO = D.DNO;


--ANSI 호환의INNER JOIN <== 모든 SQL에서 공통으로 사용되는 SQL 구문
        --ORACLE EQUI 조인과 동일한 구문 
    -- 두 테이블의 공통인 값만 출력 <교집합> 
    --FROM 절에 : INNER JOIN 키를 사용해서 JOIN 
    --ON 절에 공통의 키 컬럼을 ' = ' 로 처리
    --WHERE 에서 조건을 처리함
    
    
SELECT ENO 사원번호, ENAME 사원명, E.DNO 부서번호, DNAME 부서명, LOC 부서위치
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DNO = D.DNO;

--EMPLOYEE,DEPARTMENT 테이블의 사원명과 월급과 입사일, 부서위치, 부서명을 출력하되
-- 월급이 2000 이상 

SELECT ENAME, SALARY, HIREDATE, E.DNO, LOC, DNAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO
AND SALARY >= 2000;

SELECT ENAME, SALARY, HIREDATE, E.DNO, LOC, DNAME
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DNO = D.DNO
AND SALARY >=2000;


-- 두 테이블을 JOIN해서 부서별 월급의 최대값을 출력(EMPLOYEE, DEPARTMENT)
--부서이름 부서번호
SELECT  MAX(SALARY), D.DNO,DNAME, COUNT(*)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO
GROUP BY D.DNO, DNAME;


-- INNER JOIN
SELECT  MAX(SALARY), D.DNO,DNAME
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DNO = D.DNO
GROUP BY D.DNO, DNAME;

--NATURAL JOIN : ORACLE 9I 지원
    --두 테이블을 JOIN시 두 테이블에서 공통의 키 컬럼을 찾아야 한다 
    --두 테이블의 공통의 키 컬럼을 ORACLE 내부에서 찾아서 처리함
    -- EQUI JOIN 에서 WHERE 절의 두 테이블의 공통의 키 컬럼을 명시하지 않아도 됨. (WHERE 절 없엠)
    -- WHERE 절 생략시 오라클에서 두 테이블의 공통 키 컬럼을 자동으로 찾아줌
    -- 두 테이블의 공통 키 컬럼은 동일한 타입이어야 한다. 
    -- SELECT 절에서 공통 키 컬럼을 출력시 테이블명을 명시하면 오류 발생됨
    --FROM 절에 NATURAL JOIN을 사용함. 
    
    
--NATURAL JOIN을 사용해서 출력 하기
--<<주의>>SELECT문에서 두 테이블의 공통의 키 컬럼을 출력시 테이블 이름을 명시하면 오류 발생
--
SELECT ENO, ENAME, SALARY, DNO, DNAME, LOC
FROM EMPLOYEE E NATURAL JOIN DEPARTMENT D;
--WHERE 절이 생략되어 자동으로 ORACLE 내부에서 KEY 컬럼을 자동으로 찾음. 
/*
    SELECT 절에서 두 테이블의 공통의 키 컬럼 출력시
        --EQUI JOIN (INNER JOIN) -- 반드시 키 컬럼 앞에 테이블명을 명시해야함
        -- NATURAL JOIN  -- 키 컬럼 앞 테이블 이름을 명시하면 오류 발생 
*/

--<문제> 사원이름, 월급, 부서이름, 부서번호를 출력 하되 월급이 2000이상인 사용자만 출력
--EQUI JOIN
SELECT ENAME, SALARY, DNAME, D.DNO
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO
AND SALARY >=2000;

--NATURAL JOIN
SELECT ENAME, SALARY, DNAME, DNO
FROM EMPLOYEE E NATURAL JOIN DEPARTMENT D
WHERE SALARY >=2000;

--ANSI 호환
SELECT ENAME, ENO, SALARY, DNAME, E.DNO
FROM EMPLOYEE E INNER JOIN DEPARTMENT D 
ON E.DNO = D.DNO
AND SALARY >= 2000;


-- NON EQUI JOIN : ORACLE 에서만 적용
    -- FROM 절에 테이블을 , 로 나열 
    --WHERE 절에 ' = ' 을 사용하지 않는 JOIN 구문 <== 공통 키 컬럼 없이 JOIN
    
    
    
    --월급에 대해서 등급을 출력하는 테이블
    SELECT * FROM SALGRADE; 
    
    --사원 정보를 출력하는 테이블
    SELECT * FROM EMPLOYEE;
    
    --사원의 부서정보를 저장하는 테이블
    SELECT * FROM DEPARTMENT;
    
    
    
    --NON EQUI JOIN : EQUI JOIN 구문에서 WHERE 절의 공통 키컬럼 없이 JOIN : '='
    --EMPLOYEE , SALGRADE 테이블을 JOIN 해서 각 사원의 월급의 등급을 출력 
    SELECT ENAME, SALARY, GRADE
    FROM EMPLOYEE E , SALGRADE S
    WHERE SALARY BETWEEN LOSAL AND HISAL;
    
    --3개 테이블 JOIN
    -- EMPLOYEEE DEPARTMENT SALGRADE 테이블 조인
        --사원이름 부서이름 월급 월급의 등급 
        
    SELECT ENAME, DNAME , SALARY, GRADE
    FROM EMPLOYEE E, DEPARTMENT D, SALGRADE S
    WHERE E.DNO = D.DNO         --EMPLOYEE 테이블, DEPARTMENT 테이블 
    AND SALARY BETWEEN LOSAL AND HISAL
    ORDER BY GRADE;
    
    
    
    --ENO, HIREDATE , DNO, SALARY, GRADE, DNAME
    SELECT ENO, HIREDATE , E.DNO, SALARY, DNAME, GRADE
    FROM EMPLOYEE D, DEPARTMENT E, SALGRADE
    WHERE D.DNO = E.DNO
    AND SALARY BETWEEN LOSAL AND HISAL
    ORDER BY GRADE;
/*
    INNER JOIN : 90%, 두테이블에서 공통의 내용을 출력  (E.DNO = D.DNO) 
        --EQUI JOIN , NATURAL JOIN : ORACLE
        --INNER JOIN : ANSI 호환 (모든 DBMS에서 공통으로 사용되는 구문) 
*/
/*
    SELF JOIN : 자신의 테이블(원본) 을 가상의 테이블 (원본을 복사한 테이블) JOIN함
        --자신의 테이블을 다시한번 조인 
        --반드시 별칭을 만들고 별칭을 사용해서 JOIN해줘야됨 
*/

--MANAGER가 7788인ENO ENAME MANGER

SELECT ENO, ENAME, MANAGER 
FROM EMPLOYEE
WHERE MANAGER = 7788
ORDER BY ENAME ASC;


--직속상관의 정보를 출력
SELECT ENO, ENAME , MANAGER
FROM EMPLOYEE
WHERE ENO = 7788;


--SELF JOIN을 사용해서 자신의 테이블을 JOIN해서 사원에 대한 직속상관 정보를 한번에 출력

--EQUI JOIN을 사용해서 출력
/*
 
*/
SELECT E.ENAME,E.MANAGER, M.ENAME, M.ENO
FROM EMPLOYEE E, EMPLOYEE M --두 테이블 모두 EMPLOYEE 테이블 
WHERE E.MANAGER = M.ENO
ORDER BY E.ENAME ASC;

SELECT * FROM EMPLOYEE
ORDER BY ENAME ASC;


SELECT ENO, ENAME, MANAGER, ENO, ENAME, MANAGER
FROM EMPLOYEE;

--ANSI 호환 구문을 사용해서 SELF JOIN
--EMPLOYEE 테이블을SELF JOIN해서 사원에 대한 직속 상관을 출력

SELECT E.ENAME || '의 직속상관은  '||M.ENAME || ' 입니다'
FROM EMPLOYEE E INNER JOIN EMPLOYEE M
ON E.MANAGER = M.ENO
ORDER BY E.ENAME ASC;


/*
    OUTER JOIN:
        --특정 컬러의 내용은 두 테이블에 공통적이지 않는 내용도 출력 해야 할떄
        -- NULL 출력
        -- + 를 사용해서 OUTER JOIN : ORACLE
        -- ANSI 호환 구문을 사용할때는 : OUTER JOIN 구문을 사용함
                --LEFT OUTER JOIN, LEFT JOIN
                --RIGHT OUTER JOIN, RIGHT JOIN
                -- FULL OUTER JOIN, FULL JOIN 

*/

--EQUI JOIN 을 사용하여 INNER JOIN
SELECT E.ENAME, M.ENAME
FROM EMPLOYEE E, EMPLOYEE M 
WHERE E.MANAGER = M.ENO (+)
ORDER BY E.ENAME ASC; --M.ENO컬럼의 내용은 E.MANAGER의 값이 없더라도 무조건 출력 


--ANSI 호환에서 OUTER JOIN
                --LEFT OUTER JOIN, LEFT JOIN  : 왼쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
                --RIGHT OUTER JOIN, RIGHT JOIN : 오른쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
                -- FULL OUTER JOIN, FULL JOIN  :  왼쪽 오른쪽  모두 매치오디지 않는 내용도 무조건 출력 

SELECT E.ENAME , M.ENAME
FROM EMPLOYEE E LEFT OUTER JOIN EMPLOYEE M
ON E.MANAGER= M.ENO
ORDER BY E.ENAME ASC;


/*
    카디시안 곱 : 왼쪽 테이블의 하나의 레코드에서 오른쪽 테이블의 모든 레코드를 곱하다. 
    EMPLOYEE : 14
    DEPARTMENT 4
    카디시안 곱 : 14 * 4 = 56 레코드 출력

*/
SELECT * FROM
EMPLOYEE, DEPARTMENT;


--EMPLOYEE(14) , DEPARTMENT (4) 카디시안 곱 : 56
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO (+);  -- (+) 있으니깐 OUTER JOIN 








