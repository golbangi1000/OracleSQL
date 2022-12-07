SHOW USER;
/*
1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여 데이터 형식을 일치 시키시오.
5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANALYST' 사원은 200 , 'SALESMAN' 사원은 180,
    'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 

8.   사원번호,
      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
      이름, 
       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"
9.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
	dual 테이블 사용

10. 사원번호, 사원명, 직속상관, 
	[직속상관의 사원번호가 없을 경우 : 0000
	 직속상관의 사원번호가  앞 2자리가 75일 경우 : 5555
	직속상관의 사원번호가  앞 2자리가 76일 경우 : 6666
	직속상관의 사원번호가  앞 2자리가 77일 경우 : 7777
	직속상관의 사원번호가  앞 2자리가 78일 경우 : 8888
	그외는 그대로 출력. ] 
*/

--1

SELECT ENAME, SUBSTR(HIREDATE,1,5) AS 입사년월
FROM EMPLOYEE;

--2
SELECT ENAME, HIREDATE 
FROM EMPLOYEE
WHERE SUBSTR(HIREDATE,4,2) = 04;

--3
SELECT MANAGER, ENAME FROM EMPLOYEE
WHERE MOD(MANAGER,2) = 1;


--3-1
SELECT ENAME, SALARY FROM EMPLOYEE
WHERE MOD(SALARY, 3) = 0;

--4
SELECT TO_CHAR(HIREDATE, 'YY-MON-DD DY')
FROM EMPLOYEE;


--5 
SELECT TRUNC(SYSDATE - TO_DATE(20220101,'YYYYMMDD'))
FROM DUAL;

SELECT TRUNC(SYSDATE - TO_DATE(20220101))
FROM DUAL;

--5-1
SELECT TRUNC(SYSDATE - TO_DATE(19951204))
FROM DUAL;

--5-2

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,TO_DATE(19951204)))
FROM DUAL;
--6
SELECT ENAME, NVL(MANAGER,0) FROM EMPLOYEE;

--7
SELECT DECODE(
JOB, 'ANALYST',SALARY + 200,
'SALESMAN', SALARY + 180,
'MANAGER', SALARY + 150,
'CLEARK' , SALARY + 100,
SALARY) 인상된급여, ENAME, JOB
FROM EMPLOYEE;
)


--8 



select RPAD(SUBSTR(ENO,1,2), 4, '*'),
RPAD(SUBSTR(ENAME,1,1),4,'*')
from employee;

                            --LENGTH를 넣는게 좋은듯
select RPAD(SUBSTR(ENO,1,2), LENGTH(ENO), '*'),
RPAD(SUBSTR(ENAME,1,1),4,'*')
from employee;


--9

SELECT 
RPAD(SUBSTR('801210-1032485',1,8),15,'*'),
RPAD(SUBSTR('010-1234-5678',1,6),13,'*')
FROM DUAL;

SELECT 
RPAD(SUBSTR('801210-1032485',1,8),LENGTH('801210-1032485'),'*'),
RPAD(SUBSTR('010-1234-5678',1,6),LENGTH('010-1234-5678'),'*')
FROM DUAL;



--10 

SELECT ENAME, ENO, MANAGER,
CASE WHEN MANAGER IS NULL THEN '0000'
WHEN SUBSTR(MANAGER,1, 2) = 75 THEN '5555'
WHEN SUBSTR(MANAGER,1, 2) = 76 THEN '6666'
WHEN SUBSTR(MANAGER,1, 2) = 77 THEN '7777'
WHEN SUBSTR(MANAGER,1, 2) = 78 THEN '8888'
ELSE TO_CHAR(MANAGER, '9999') --자릿수 표현해주는게 좋은듯 
END 번호
FROM EMPLOYEE;









