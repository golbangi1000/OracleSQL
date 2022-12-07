
--HR2 계정으로 쿼리

--현재 접속한 계정에서 모든 테이블을 출력

select * from tab;

--각 테이블의 구조 확인 : 컬럼 (자료형)
desc employee;
desc department;
DESCRIBE department;

select ename 사원명, salary 월급 from employee where salary > 1000;

SELECT * from employee WHERE salary > 1000;

SELECT * FROM employee 
where commission = 300 or commission = 500 or commission  = 1400;

--IN 연산자를 사용해서 출력
SELECT * from employee
where commission IN (300, 500, 1400);

--Between A and B : A 와 B사이의 값을 출력
--between between between between between between 
select ename, hiredate
from employee
where hiredate > = '81/01/01' and hiredate <= '81/12/31';



/*
 Like : 컬럼의 값을 검색해서 출력할때 사용
    --   ? : 한글자가 어떤값이 와도 상관없음
    --   % : 모든글자를 대치
*/
--이름이 A로 시작되는 모든 사원을 출력 

SELECT ename
from EMPLOYEE 
where ENAME like 'A%';

-- 글자 이름에 LL이 들어간 사원 찾기
SELECT ename 
FROM EMPLOYEE 
where ename like '%LL%';

--두전쨰 자릿수에 A문자가 있는 사원 검색
SELECT ename, job
from EMPLOYEE where ENAME like '_A%';

--job 컬럼의 MAN이 들어간 내용을 검색하기
SELECT job
from EMPLOYEE
WHERE job like '%MAN%';

--정렬해서 출력하기 : order by 정렬할컬럼 정렬방식 <=== selec t절에서 제일 마지막에 옮
    --asc : 내림차순 : 작은값 --> 큰값으로 출력, A --> Z
    --desc : 오름차순 : 큰값 --> 작은값으로 출력, Z ---> A
    
    --사원이름을 기준으로 ASC
    select * from EMPLOYEE
    order by ename asc;
    
    --사원이름을 기준으로 desc
      select * from EMPLOYEE
    order by ename desc;
    
--hiredate (입사날짜를 기준으로 정렬)
SELECT * 
from EMPLOYEE
order by hiredate; --기본은 낮은거 부터 높은거 까지 

--eno (사원번호)를 기준으로 내림차순 정렬 (desc) : 큰값 ---> 작은 값으로 출력
SELECT *
FROM EMPLOYEE
ORDER BY ENO ASC;

--조건을 적용해서 나온 결과를 정렬해서 출력 하기
--81년 입사한 사원만 출력하되 월급이 많은순으로 출력하기

SELECT ENO, ENAME, HIREDATE, SALARY
FROM EMPLOYEE 
WHERE HIREDATE LIKE '81%'
ORDER BY SALARY DESC;


--보너스가 없는 사원들만 출력하되 이름을 내림차순으로 정렬해서 출력
SELECT * FROM EMPLOYEE
WHERE COMMISSION IS NULL 
ORDER BY ENAME ASC;

--부서번호(DNO) 가 20인 사원이고 월급일 1500이상인 사원을 출력하되 월급이 많은순으로
SELECT * FROM 
EMPLOYEE 
WHERE DNO = 20 AND SALARY >= 1500 
ORDER BY SALARY;

--여러 컬럼을 정렬 할경우 : 게시판 질문답변형 게시판
--처음의 컬럼을 모두 정렬후 , 같은 값이 존재할경우 그 컬럼을 뒤에서 정렬
    
SELECT DNO, MANAGER, ENAME
FROM EMPLOYEE
ORDER BY DNO, MANAGER DESC, ENAME; --이렇게하면 DNO에서 중복된 항목에 대해서 MANAGER가DESC로 정렬됨


-- MANAGER ASC 정렬후 , ENAME 컬럼을 ASC정렬
SELECT MANAGER, ENAME
FROM EMPLOYEE
ORDER BY MANAGER, ENAME;


SELECT * FROM EMPLOYEE;


--부서별로 월급이 많은 사용자부터 출력

SELECT DNO,SALARY,ENAME FROM EMPLOYEE
ORDER BY DNO, SALARY DESC;
-- COMMISION 별로 월급이 많은 순으로 출력
SELECT COMMISSION, SALARY FROM EMPLOYEE
ORDER BY COMMISSION ASC, SALARY DESC;





--직책별로 입사일이 빠른순으로 출력
SELECT ENAME, JOB, HIREDATE FROM EMPLOYEE
ORDER BY JOB, HIREDATE ASC;

--중복 제거후 출력: DISTINCT : 중복을 제거할 컬럼앞에 넣는키


-- 회사에 존재하는 직책 : 중복을 제거후 출력 
SELECT DISTINCT JOB
FROM EMPLOYEE
ORDER BY JOB;


--회사에 존재하는 부서 : 중복을 제거후 출력
SELECT DISTINCT DNO
FROM EMPLOYEE
ORDER BY DNO;


--직속상관 (MANAGER)을 중복을 제거후 출력
SELECT DISTINCT MANAGER 
FROM EMPLOYEE
ORDER BY MANAGER;

/*
===========================================================================================
오라클에서 기본 제공해 주는 함수
*/
--1. 문자처리 함수
/*
LOWER : 소문자로 변환
UPPER : 대문자로 변환
INITCAP : 첫 글자만 대문자로 나머지는 소문자로 변환
*/
SELECT 'Oracle mania' AS 원본
    , UPPER('Oracle mania')
    , LOWER('Oracle mania')
    , INITCAP('Oracle mania')
FROM DUAL;      --가상의 테이블


select * from employee;


--값을 가져올때는 대소문자를 구별함
SELECT * FROM EMPLOYEE
WHERE ename = UPPER('smith');



/*
글자의 길이를 출력해 주는 함수
LENGTH : 글자수를 반환 (한글 1BYTE)
LENGTHB: 글자수를 반환 (한글 2BYTE)
*/

select lengthb ( 'Oracle mania') -- 12byte
    ,lengthb('오라클 매니아') --19byte
from dual;


SELECT ENAME, LENGTH (ENAME) AS 글자수,
    JOB, LENGTH(JOB) 글자수
    FROM EMPLOYEE;

/*
CONCAT : 문자열을 연결함수 
SUBSTR : 문자를 잘라주는 함수 (한글 1BYTE)
SUBSTRB: 문자를 잘라주는 함수 (한글 3BYTE)
INSTR : 특정 문자의 위치값을 반화 (한글 1BYTE)
INSTRB : 특정 문자의 위치값을 반화 (한글 3BYTE)
LPAD: 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (왼쪽)
RPAD: 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (오른쪽)
TRIM : 공백을 제거 
*/
select 'Oracle', 'mania',
    concat('Oracle', 'mania')
    from dual;
    
select substr('oracle mania', 4,3) --4번째 자리에서 3자를 잘라서 출력
from dual;

select substr('오라클 매니아', 4,3)
from dual;

-- instr 해당 문자가 존재하는 위치를 출력
select 'oracle mania',
    instr('oracle mania', 'a',4) --4번째 자리수에서 a를 검색
    from dual;
    
    
select ename, instr(ename, 'K')  --K라는 글자가 들어간 자릿수 
from employee;




--LPAD 
select RPAD(SUBSTR(ENO,1,2), 4, '*')--salary 칼럼의 값을 10자리 표현 비어있는 공백은 '*'로 왼쪽부터 채움
from employee;

--RPAD
select RPAD (salary, 10, '*')--salary 칼럼의 값을 10자리 표현 비어있는 공백은 '*'로 오른쪽부터 채움
from employee;

--TRIM : 앞뒤의 공백을 제거
select '                 oracle mania             ' as 원본,
trim ('                 oracle mania             ') as 공백제거
from dual;


--2. 숫자 함수

/*
 ROUND : 특정 자릿수에서 반올림
    ROUND (대상) : 소숫점 뒷자리에서 반올림 
    ROUND (대상, 소숫점자릿수) : 
        --양수일때 : 소숫점을 기준으로 오른쪽으로 이동해서 그 뒷자리에서 반올림 <== 주의
        --음수일때 : 소숫점을 기준으로 왼쪽으로 이동해서 그 자리에서 반올림 <== 주의
            --정수를 반올림. 그 뒤는 모두 버림 
 TRUNC : 특정 자릿수에서 잘라냄.
 MOD : 입력받은수를 나누고 나머지 값만 반환
 
 */
SELECT 98.7654 AS 원본 ,
    ROUND (98.7654),
    ROUND (98.7654, 2),
    ROUND (98.7654, -1),
    ROUND (98.7654, -2),
    ROUND (98.7654, -3),
    ROUND (98.7654, 3),
    ROUND (98.7654, -1),
    ROUND (12345.55555, -1)
FROM DUAL;


SELECT 12345.789 AS 원본,
    ROUND (12345.789),
    ROUND (12345.789, -3),
    ROUND (12345.789, 3)
FROM DUAL;


-- TRUNC : 잘라서 버림
SELECT 98.7654 AS 원본,
    TRUNC (98.7654),
    TRUNC (98.7654, 2),
    TRUNC (98.7654, -1)
    FROM DUAL;
    
    
-- MOD ( 대상, 나누는수) : 대상을 나누는수로 나누어서 나머지 
SELECT ENO, ENAME
FROM EMPLOYEE
WHERE MOD ( ENO ,2) = 0;-- 짝수만 출력 MODULUS




--3. 날짜 함수
/*
SYSDATE : 현재 시스템의 날짜와 시간을 출력
MONTHS_BETWEEN : 두 날짜 사이의 개월 수를 출력
ADD_MONTHS: 특정 날짜에 개월수를 더할때 
NEXT_DAY : 특정날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반화
LAST_DAY: 달의 마지막 날짜를 반환
ROUND : 날짜를 반올림, 15일 이상은 반올림 , 15일 미만은 버림
TRUNC : 날짜를 버림
*/

SELECT SYSDATE
FROM DUAL;

SELECT SYSDATE -1 AS 어제날짜, SYSDATE AS 오늘날짜, SYSDATE + 1 AS 내일날짜
FROM DUAL;

SELECT HIREDATE AS 입사날짜 , HIREDATE - 1 , HIREDATE + 10
FROM EMPLOYEE;


--입사일에서 현재 까지의 근일일수 구하기

SELECT ROUND(SYSDATE - HIREDATE) AS "총근무일수"
FROM EMPLOYEE;


SELECT ROUND(SYSDATE - HIREDATE,2) AS "총근무일수"
FROM EMPLOYEE;

--특정 날짜에서 월(MONTH)을 기준으로 버리기 

SELECT HIREDATE AS 원본, TRUNC (HIREDATE, 'MONTH')--월까지만 출력 날짜는 다 버림
FROM EMPLOYEE;

--특정 날짜에서 월(MONTH)을 기준으로 반올림 하기 15일 이상은 반올림, 15일 이하는 버림, 
SELECT HIREDATE AS 원본, ROUND ( HIREDATE, 'MONTH')
FROM EMPLOYEE; 


--MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜사이의 개월수를 출력

-- 입사일에서 현재까지 몇개월간 근무 했는지 출력.
SELECT ENAME, HIREDATE, MONTHS_BETWEEN(SYSDATE, HIREDATE) AS 근무개월수
FROM EMPLOYEE;

SELECT ENAME, HIREDATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS 근무개월수
FROM EMPLOYEE;

--ADD_MONTH(DATE1,개월수)

SELECT HIREDATE, ADD_MONTHS ( HIREDATE, 6)
FROM EMPLOYEE;

--입사후 100일이 지난 시점의 날짜.
SELECT HIREDATE, HIREDATE + 100 AS "입사후100일시점"
FROM EMPLOYEE;


-- NEXT_DAY (DATE, 요일) : DATE의 도래하는 요일을 출력
-- 오늘 날짜에서 도래하는 토요일의 날짜는 몇일 인지 출력
SELECT SYSDATE, NEXT_DAY (SYSDATE, '토요일')
FROM DUAL; 


--LAST _DAY (DATE) : DATE에 월의 마지막 날짜를 출력
SELECT HIREDATE, LAST_DAY ( HIREDATE) AS 월의마지막날짜
FROM EMPLOYEE;





--4. 변환 함수

/*
형 변환 함수 <== 중요 중요 중요 중요 중요 중요 중요 중요 중요

TO_CHAR : 날짜형 숫자형을 문자형으로 변환하는 함수
TO_DATE : 문자형을 날짜형으로 변환하는 함수
TO_NUMBER: 문자형을 숫자로 변환하는 함수
*/

--TO_CHAR(DATE, 'YYYYMMDD')
/*
 -- YYYY: 년도
 -- MM : 월
 -- DD : 일
 -- DY : 요일 
 
 -- DAY : 요일의 자세한정 ( 월요일, 화요일)
 -- DY : 요일 (월, 화)
 
 -- HH : 시간
 -- MI : 분
 -- SS : 초 


*/
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE, 'YYYY_MM_DD'), TO_CHAR(HIREDATE, 'YY-MM/DD'),
TO_CHAR(HIREDATE, 'YYYY--MM--DD DY'),
TO_CHAR(HIREDATE, 'YYYY-MM-DD DY HH:MI:SS')
FROM EMPLOYEE;


--현재 시스템의 오늘 날짜를 출력하되 시간:분:초 요일까지 출력
select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS DY')
from dual;


-- TO_CHAR : 숫자를 CHAR 형식으로 변환 
/*
    0: 자릿수를 나타내고 자릿수가 맞지 않으면 0으로 채움 .
    9: 자릿수를 나타내고 자릿수가 맞지 않으면 빈칸으로 채움
    L: 각 지역의 통화 기호를 출력
    . : 소숫점으로 표현
    , : 천단위 구분자
*/
--SALARY : NUMBER == > CHAR              999 9999는 의미는 없음 그냥 자릿수 나타내는용 
SELECT ENAME, SALARY, TO_CHAR(SALARY , 'L999,9999'), TO_CHAR(SALARY, 'L000,000')
FROM EMPLOYEE;


--TO_DATE('CHAR', 'FORMAT') : CHAR (문자) ==> 날짜형식으로 변환
--TO_DATE (NUMBER, 'FORMAT') : 숫자를 ==> 날짜형식으로 변환

SELECT SYSDATE , 
SYSDATE - TO_DATE(20000101,'YYYY-MM-DD')
FROM DUAL;


SELECT SYSDATE, 
SYSDATE - TO_DATE('2000-01-01', 'YYYY-MM-DD')
FROM DUAL;


--'02/10/22' : 22년 02월 10일 을 DATE 형식으로 바꾼다 '2000/01/01'
SELECT TO_DATE ('12/06/22', 'MM/DD/YY') - TO_DATE('2000/01/01', 'YYYY/MM/DD')
FROM DUAL;


SELECT TRUNC(SYSDATE - TO_DATE(20000101,'YYYYMMDD'))
FROM DUAL;


--EMPLOYEE 테이블에서 81년 2월 22일 입사한 사원을 검색하는데
    -- '1981-02-22' 문자열 포멧을 DATE형식으로 변환해서 검색 
    
SELECT ENAME 사원이름, HIREDATE 입사일 FROM EMPLOYEE
WHERE HIREDATE = TO_DATE('19810222');
SELECT ENAME 사원이름, HIREDATE 입사일 FROM EMPLOYEE
WHERE HIREDATE = TO_DATE('02-22-1981', 'MM-DD-YYYY'); --이런형식이다라고 알려주는것도 됨 


--2000년 12월 25부터 오늘까지 총 몇다링 지났는지 출력 소숫점이하는 모두 잘라내기 

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,  TO_DATE(20001225,'YYYY-MM-DD'))) AS 달의차
FROM DUAL;

SELECT TO_DATE('2022-12-07' , 'YYYY-MM-DD')
FROM DUAL;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY MON DD DY') --MON을 쓰니깐 월이 나옴 
FROM DUAL;


SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY MON DD DY HH:MI:SS')
FROM DUAL;


--숫자를 ==> DATE 타입으로 변환
SELECT TO_DATE ( 12072022, 'MMDDYYYY')
FROM DUAL;

--TO_NUMBER : 문자형 데이터를 수자형으로 변환

SELECT 10000- 5000
FROM DUAL;


SELECT '10000' - '5000' --자동으로 변환됨 : 문자열 ===> 숫자형으로
FROM DUAL;

SELECT '10,000'- '5,000'   --TO_NUMBER로 변환이 필요하댜ㅏ 이건 오류뜸
FROM DUAL;

SELECT TO_NUMBER('10,000', '999,999') - TO_NUMBER('5,001','9,999') AS 숫자변환계산  --뒤에 있는건 그냥 자릿수 알려주는거 9는 의미가 없다 
FROM DUAL;


--5. 일반 함수

--NVL , NVL2 , NULLIF,
--COALESCE

--NVL 함수 : NULLD을 처리하는 함수
        --NLV(컬럼명, 값) : 컬럼에 NULL이 존재할때 값으로 대치 
        -- 총연봉은 = 월급 * 12 + 보너스
        -- 보너스 컬럼에 null을 연산하면 null
        
SELECT ENAME, SALARY 월급, COMMISSION 보너스, 
    SALARY * 12 + NVL (COMMISSION , 0) AS 총연봉
    FROM EMPLOYEE;
    
    
--NVL2함수 : NULL을 처리하는 함수
    --NVL2(컬럼명, NULL이 아닐경우처리 , NULL경우 처리) 
    
    
SELECT ENAME, SALARY 월급, COMMISSION 보너스, 
                    --커미션이 NULL이 아닐때       NULL일때 
    NVL2 (COMMISSION, SALARY * 12 + COMMISSION, SALARY * 12) 총연봉
FROM EMPLOYEE;


--NULLIF 함수 : 두인자를 비교해서 동일한 경우 NULL을 반환하고
    --동일하지 않는 경우 첫번째 표현식을 반환
    --NULLIF (EXPR1, EXPR2)
    
    
SELECT NULLIF('A', 'A') , NULLIF('A', 'B')
FROM DUAL;



-- COALESCE 함수
    COALESCE (EXPR1, EXPR2, EXPR3...EXPR-N)
        --EXPR1 NULL 아니면 EXPR1 반환
        --EXPR1 NULL 이고 EXPR2가 NULL DL 아니면 EXPR2를 반환
        --EXPR1 NULL 이고 EXPR2가 NULL 이고 EXPR3가 NULL이 아니면 EXPR3를 반환
        
SELECT COALESCE ( 'ABC', 'BCD', 'CDE', 'DEF', 'EFG')
FROM DUAL;


SELECT COALESCE ( NULL, NULL, 'CDE', 'DEF', 'EFG')
FROM DUAL;


SELECT COALESCE ( NULL, NULL, NULL, NULL, 'EFG')
FROM DUAL;

--DECODE  함수 : SWITCH CASE 문과 동일한 함수

/*
    DECODE ( 표현식, 조건1, 결과1, 
        조건2, 결과2,
        조건3, 결과3,
        ...
            기본결과N

*/

/*
DNO 부서번호
10 ACCOUNTING
20 RESEARCH
30 SALES
40 OPERATIONS
DEFAULT



*/

SELECT ENAME, ENO, 
DECODE (DNO, 10, 'ACCOUNTING', 
20, 'RESERACH',
30,'SALES',
40, 'OPERATIONS',
'DEFAULT') AS 부서명
FROM EMPLOYEE;


--CASE : IF ~ ELSE IF, ELSE IF 와 비슷한 구문

/*
    CASE WHEN 조건1 THEN 결과1
    WHEN 조건2 THEN 결과2
    WHEN 조건3 THEN 결과3
    END
*/

--부서 번호에 대한 부서명 출력 : CASE

SELECT ENAME, DNO,
    CASE WHEN DNO= 10 THEN 'ACCOUNTING'
    WHEN DNO = 20 THEN 'RESERACH'
    WHEN DNO = 30 THEN 'SALES'
    WHEN DNO = 40 THEN 'OPERATIONS'
    ELSE 'DEFAULT' 
    END 부서명
FROM EMPLOYEE































