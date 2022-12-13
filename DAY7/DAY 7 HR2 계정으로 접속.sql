SHOW USER;


--VIEW 의 정보를 저장하는 데이터 사전
SELECT * FROM USER_VIEWS;

--INDEX 정보를 저장하는 데이터 사전
SELECT * FROM USER_INDEXES;

/*
    VIEW : 가상의 테이블, 데이터가 저장되어있지 않다
            --실제 테이블의 값을 SELECT 하는 코드만 들어가 있다
            -- 목적 : 1. 보안을 위해서 사용하는 경우 : 실제 테이블의 특정 컬럼을 숨겨서 처리 
                    2. 편의성을 위해서 사용하는경우 : 복잡한 구문을 VIEW로 만들어서 처리
                                JOIN 구문, 복잡한 구문
*/


--VIEW 실습을 위한 샘플 테이블 생성
    --VIEW는 실제 테이블의 주로 SELECT 구문을 저장하고 있다
    --VIEW는 가상의 테이블 , 실제 데이터를 저장하고 있지 않다
    -- 실제 테이블의 실행 코드만 들어있다
 GRANT DBA TO C##HR2; -- SYSTEM계정으로 가서 권한 부여    

--보안을 위해서 생성한 VIEW : 실제테이블의 특정 컬럼을 가져옴 
--사용자한테 안보임 
CREATE VIEW V_EMP  --VIEW를 만들면 실제 테이블이 아니라 실행코드만 저장되어있음 
AS
SELECT ENO, ENAME, SALARY FROM EMPLOYEE;

--VIEW 를 실행 : SELECT * FROM 뷰명
SELECT * FROM V_EMP;

--VIEW 정보를 담은 데이터 사전
SELECT * FROM USER_VIEWS;

--VIEW 수정 : <주의> : ORACLE에서는 ALTER VIEW가 없다.
    -- CREATE OR REPLACE VIEW 구문을 사용 
CREATE OR REPLACE VIEW V_EMP
AS
(SELECT * FROM EMPLOYEE);

-- VIEW 삭제
DROP VIEW V_EMP;

--2. 편의성을 위해서 VIEW를 사용함. : 복잡한 JOIN 구문 
            --VIEW를 SELECT 하면 된다.
--사원이름, 상사이름을 바로 출력하는 쿼리 : SELF 조인을 사용해서     
            
CREATE VIEW V_EMP02
AS 
SELECT E.ENAME 사원이름, M.ENAME 상사이름
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER = M.ENO;

--VIEW 실행
SELECT * FROM V_EMP02;

--사원명 월급 부서번호 부서명 부서위치를 출력하는 VIEW를 생성
-- V_EMP_DEPT
CREATE OR REPLACE VIEW V_EMP_DEPT
AS
SELECT ENAME 사원명, SALARY 월급, E.DNO 부서번호, DNAME 부서이름, LOC 부서위치
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DNO;

--VIEW 실행
SELECT * FROM V_EMP_DEPT;

/*
    뷰의 처리 과정
        --VIEW는 가상의 테이블이고 값을 가지고 있지 않다 (SELECT , JOIN )
        -- 실행 쿼리만 가지고 있다. (SELECT)
        
        1. USER_VIEWS의 데이터사전에서 뷰이름에 대한 쿼리를 조회
        2. 접속한 게정이 실제 테이블에 접근할수있는 권한이 있는지 확인 
        3. 각 테이브렝 권하닝 있으면 쿼리를 실행
        4. 검색 ( 값을 가지고 온다.)
        5. 출력 
    
*/

--VIEW를 사용해서 값을 넣을수 있다
    --VIEW에는 값이 저장되지 않는다 코드만 존재함
    -- 값은 실제 테이블에 저장됨
    -- 실제 테이블의 제약 조건에 따라서 값이 저장될수도 있고 안될수도 있다
CREATE TABLE EMP100
AS
SELECT * FROM EMPLOYEE;
    
    
SELECT * FROM EMP100;

--테이블의 제약 조건을 확인 하는 데이터 사전
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP100');

--VIEW 생성
CREATE VIEW V_EMP10
AS
SELECT ENO, ENAME, SALARY FROM EMP100;

--뷰를 출력
SELECT * FROM V_EMP10;

--VIEW 에 값 넣기 : VIEW에 <== 실제 테이블에저장됨 (EMP100)
INSERT INTO V_EMP10
VALUES(8888, 'KORNAN',6000);
COMMIT;
--뷰를 출력
SELECT * FROM V_EMP10;

--VIEW에 값을 넣으면 실제 테이블에 값이 저장됨
SELECT * FROM EMP100; --KORNAN관련값이 저장되있음 

--VIEW에 값을 저장시 실제 테이블에 저장이 되면서 실제 테이블에 제약 조건에 따라서
        --값이 저장될수도 있고 그렇지 않을수도 있다 
        
        
--VIEW 를 사용해서 값을 삭제 : 실제 테이블 : EMP100
DELETE  V_EMP10
WHERE ENO = 8888;
COMMIT;

SELECT * FROM EMP100;


-- ALTER TABLE 을 사용해서 HIREDATE 컬럼에 NOT NULL 제약 조건을 축
    --NOT NULL, DEFAULT 수정할때는 MODIFY
    
ALTER TABLE EMP100
MODIFY HIREDATE CONSTRAINT EMP100_HIREDATE_NN NOT NULL;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP100';

--테이블에 제약 조건위배로 VIEW에서 값을 넣을떄 오류가 발생

SELECT *  FROM V_EMP10;

--HIREDATE컬럼의 제약 조건 위배 : NOT NULL
INSERT INTO V_EMP10
VALUES(9999,'KENDY',7000);


--VIEW를 사용해서 INSERT UPDATE DELETE 할때 실제 테이블의 제약 조건에 따라 달라진다

/*
    뷰:
        1. 단순뷰(SIMPLER VIEW) : 하나의 테이블로 생성된 VIEW
        2. 복합뷰(COMPLES VIEW ) : 두개이상의 테이블로 생성된 VIEW
                --뷰 내에서는 DISTICT, 그룹함수(SUM, AVG, MAX,MIN, GRUOP BY
                , ROWNUM 을 사용하지 못한ㄷ
                -- 단, 그룹함수를 사용 할 경우 반드시 별칭 이름을 사용하면 사용할수있다
*/

--ROWNUM : 레코드의 숫자를 출력 해줌. ROW의 넘버를 출력
    --MS-SQL, MYSQL : TOP N
--출력중에 10개만 출력 하라 
SELECT ROWNUM, ENO, ENAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 10;

-- 중복된 값을 제거 : 지급의 종류
SELECT DISTINCT JOB FROM EMPLOYEE;

--VIEW 내부에 ROWNUM 컬럼때문에 오류 발생 
CREATE OR REPLACE VIEW V_EMP30
AS 
SELECT ROWNUM, ENO, ENAME FROM EMP100;

--VIEW 내부에 ROWNUM 컬럼에 별치잉름을 사용 할 경우 사용가능 
CREATE OR REPLACE VIEW V_EMP30
AS 
SELECT ROWNUM 행번호, ENO, ENAME FROM EMP100;


-- 원래 전 버젼은 오류발생인데 이버젼은 ㄱㅊ은듯  버젼 21
--DISTINCT는 별칭 없이 잘됨 
CREATE OR REPLACE VIEW V_EMP31
AS
SELECT DISTINCT JOB FROM EMP100;


-- VIEW 내부에서 그룹 함수를 사용했을때 : SUM, AVG, MAX, MIN, COUNT(*)
--별명을 안지어줘서 오류가 발생 
--ORA-00998: 이 식은 열의 별명과 함께 지정해야 합니다
CREATE OR REPLACE VIEW V_EMP32
AS
SELECT SUM(SALARY), ROUND(AVG(SALARY)), MAX(SALARY), MIN(SALARY)
FROM EMP100;

--별칭을 쓰면 오류가 안생긴다

CREATE OR REPLACE VIEW V_EMP32
AS
SELECT SUM(SALARY) 합계, ROUND(AVG(SALARY)) 평균, MAX(SALARY) 최대값, MIN(SALARY) 최소값
FROM EMP100;



--VIEW 내부에서 GROUP BY를 사용할 경우<<==별칭이름을 사용: 오류발생되지 않음
--각 부서별로 웝글의 합계, 평균, 최대값, 최소값, COUNT(*)

CREATE OR REPLACE VIEW V_EMP33
AS
SELECT SUM(SALARY)부서별합계, ROUND(AVG(SALARY),2) 부서별평균, MAX (SALARY)부서별최대값, MIN(SALARY) 부서별최소, COUNT(*) 카운트
FROM EMP100
GROUP BY DNO;


/*
    뷰를 생성시 옵션 사용
        --FORCE 옵션 : 기존 테이블 생성유무에 상관없이 뷰를 생성
        --NOFORCE옵션 : 반드시 기존 테이블이 존재해야만 생성<<기본값>>
                
*/

CREATE OR REPLACE VIEW V_EMP34
AS
SELECT * FROM EMP101; --EMP101번 테이블은 존재하지 않으므로 VIEW 생성시 오류 발생

--FORCE 옵션을 사용해서 해당 테이블이 존재하지 않더라도 강제로 생성
    --해당 테이블은 나중에 만들수 있다
--경고: 컴파일 오류와 함께 뷰가 생성되었습니다. 이렇게 나옴 
CREATE OR REPLACE  FORCE VIEW V_EMP34
AS 
SELECT * FROM EMP101;

SELECT * FROM USER_VIEWS;


--VIEW 생성이후에 테이블 생성
CREATE TABLE EMP101
AS
SELECT * FROM EMPLOYEE;

SELECT * FROM V_EMP34;


 ----------------------------------------------------------
 /*
    index (인덱스, 색인)  : 테이블의 컬럼에 검색을 빠르게 하기위해 컬럼에 index를 생성 
        -- select 를 빠르게 하기 위해서 사용 
        -- 테이블 스캔 :검색할 내용을 첫 레코드 부터 마지막 레코드까지 순차적으로 검색
            -- 검색할 내용을 찾기위해서 책의 첫장부터 마지막 장까지 검색  
            index 가 생성되어있지 않는 컬럼의 내용을 검색 할때는 테이블 스캔을 한다. 
        -- index 정보를 사용한 스캔 :   <== 검색이 빠르다. 
            -- index를 사용해서 정보를 검색 
            -- 책의 색인,목차(index)
            
    자주 검색에서 사용되는 컬럼은 index를 생성해서 검색을 빠르게 한다. 
        where 절에서 사용되는 컬럼. 
        JOIN 시 ON 절에서 사용되는 컬럼 
        
        테이블의 Primary Key, Unique 컬럼은 자동으로 Index 가 생성됨 
        
        
        테이블의 index 정보를 출력하는 데이터 사전 
        select * from user_indexes 
            where table_name in ('EMPLOYEE', 'DEPARTMENT'); 
        select * from user_columns
            where table_name in ('EMPLOYEE', 'DEPARTMENT');
        select * from user_ind_columns 
            where table_name in ('EMPLOYEE', 'DEPARTMENT');
 */ 

SELECT * FROM USER_COLUMNS
WHERE TABLE_NAME IN ('TBL1', 'TBL2');

SELECT * FROM USER_INDEXES
        WHERE TABLE_NAME IN ('TBL1', 'TBL2');

-- INDEX 자동 생성되는 컬럼: PRIMARY KEY, UNIQUE 컬럼은 자동으로 INDEX 생성됨
CREATE TABLE TBL1(
    A NUMBER(4) CONSTRAINT TBLL_A_PK PRIMARY KEY,
    B NUMBER (4),
    C NUMBER (4)
);

CREATE TABLE TBL2(
A NUMBER (4) CONSTRAINT TBL2_A_PK PRIMARY KEY,
B NUMBER(4) CONSTRAINT TBL2_B_UK UNIQUE,
C NUMBER(4) CONSTRAINT TBL2_C_UK UNIQUE
);

--특정 컴럼에 INDEX 부여하기 , WHERE절이나 JOIN할떄 ON절에서 상ㅇ되는 컬럼
SELECT * FROM EMPLOYEE;

--EMPLOYEE 테이블의 ENAME컬럼은 검색을 자주 사용한다. 레코드가 10만개 있다 치면
    --컬럼에 INDEX를 생성하면 컬럼의 값을 가지고 INDEX 페이지를 생성한다 .
    --부하가 굉장히 많이 걸리는 작업이다 . 야간에 INDEX를 생성해한다

--DBA 과정에서 전문적으로 다룬다
    --INDEX는 DBMS를 잘이해하고 절생성해야한다
    --INDEX는 잘못만들면 오히려 성능이 떨어진다
    --주기적으로 INDEX 정보를 업데이트 해야 한다
        --REBUILD 
        
        
--INDEX가 테이블의 어떤 컬럼에 INDEX가 생성되었는지 확인
SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
        
--EMPLOYEE 테이블의 ENAME컬럼에 INDEX생성        
CREATE INDEX IDX_EMPLOYEE_ENAME
ON EMPLOYEE(ENAME);

/*
    INDEX는 생성후 지속적인 관리가 필요함
    EMPLOYEE 테이블의 ENAME 컬럼에 인덱스를 생성함 . 
        --ENAME 컬럼에 INSERT, UPDATE DELETE가 빈번하게 일어날경우 INDEX페이지가 조각난다
        -- 주기적으로 REBULID해줘야한다 . (INDEX 페이지를 업데이트해야 한다)
*/

--생성된 INDEX 정보를 새로이 업데이트
ALTER INDEX IDX_EMPLOYEE_ENAME REBUILD;
    --ENAME컬럼의 수정된 정보를 INDEX페이지에 새로이 업데이트 
    
SELECT * FROM EMPLOYEE;

--EMPLOYEE 테이블에서 JOB 컬럼을 빈번하게 검색 
CREATE INDEX IDX_EMPLOYEE_JOB
ON EMPLOYEE(JOB);

--EMPLOYEE 테이블의 JOB 컬럼이 빈번하게 (UPDATE, DELETE, INSERT)
    --주기적으로 수정될 경우 업데이트가 필요함. 
    --레코드가 적을때는 생성할 필요가 없다 10만건 이상되면 테이블 스캔으로 검색하는데
        --시간이 오래 걸릴 경우 INDEX 생성의 필요성이 있다 
ALTER INDEX IDX_EMPLOYEE_JOB REBUILD;

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

--생성된 INDEX 삭제 
DROP INDEX IDX_EMPLOYEE_ENAME;
DROP INDEX IDX_EMPLOYEE_JOB;


/* ERD : 데이터 베이스 모델링, 설계도 
        --테이블과 테이블의 관계
        --ER-WIN : 전 세계적으로 제일 많이 사용한 모델링 툴 
    모델링
    ===============================================================
    1. 요구사항 분석 ==> 2. 논리적 모델링 ==> 3.물리적 모델링 ==> 4. 구현
    
    1. 요구 사항 분석 : 업무 파악, 고객의협의, 프로젝트의 범위를 지정. <===
        테이블, 각 테이블의 속성, 테이블과 테이블의 관계 
        
        DB 설계 ====> APP을 개발 
    
    2. 논리적 모델링
        엔티티 (논리적 모델링): 테이블 ( 물리적 모델링)
        속성 (논리적 모델링)  : 컬럼 (물리적 모델링)
        관계 : 1:1관계 , 1:다, 다:다.
    
    3. 물리적 모델링 (영문으로, 테이블명, 컬럼명, 컬럼의 자료형을 적용, 테이블간의 관계)
    
    4. 구현 (ORACLE) <== 물리적 모델링을 
*/















