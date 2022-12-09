SHOW USER;

/*
 SQL ( Structured Query Language) : 구조화된 질의 언어 
    SELECT 컬럼
    FROM 테이블명 뷰명
    WHERE 조건
    GROUP BY  그룹핑할 컬럼명
    HAVING 나온결과에 대한조건
    ORDER BY 정렬할컬럼
    
    
    DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어, 객체를 생성, 수정, 삭제 
            객체 (OBJECT) - TABLE, VIEW , FUNCTION, INDEX STORE PROCEDURE, TRIGGER ......
        CREATE (생성) ALTER(수정)  DROP (삭제)
        RENAME(객체이름변경)  TRUNCATE(레코드 삭제)
        
        
    DML(DATE MANIPULATION LANUGAGE) : 데이터 조작 언어, 레코드를 생성, 수정 삭제
            INSERT (생성), UPDATE(수정) , DELETE(삭제)
            -트랜잭션을 발생시킴. COMMIT(DB에 영구저장) , ROLLBACK ( 원래 상태로 되돌림)
            
    DCL (DATA CONTROL LANGUAGE) - 데이터 제어 언어 계정을 생성 권한을 부여 삭제할때 사용 
            GRANT (권한 부여)     REVOKE (권한을 취소)
            
    
    DQL(DATA QUERY LANGUAGE) : 데이터 질의 언어 (출력) : SELECT
             
    
    DTL (TRANSACTION CONTROL LANGUAGE): 트랜잭션 제어 언어
                BEGIN TRANSACTION <== 트랜잭션 시작
                
                COMMIT            <== 트랜잭션을 종료 (DATABASE에 영구저장)
                ROLLBACK          <== 트랜잭션을 종료 (원래 상태로 되돌림, 트랜잭션 시작전 상태로 되돌림)
                SAVEPOINT     (트랜잭션내의 임시 저장 시점 설정)
       
*/


CREATE TABLE DEPT(              --생성할 테이블 명 
    DNO NUMBER(2) NOT NULL,   --숫자는 자릿수를 뜻함 
    DNAME VARCHAR2(4) NOT NULL,
    LOC VARCHAR2(13) NULL
);


-- 테이블 구조 확인
DESC DEPT;
DESCRIBE DEPT;

--테이블에 값넣기 (INSERT INTO 테이블명(명시할 컬럼명) VALUES (넣을값);
INSERT INTO DEPT (DNO, DNAME, LOC)
VALUES (10, 'ACCO','SEOUL');

--DATABASE에 영구적으로 저장 하라 
COMMIT; --영구저장 COMMIT하고 나서는 롤백이 안됨 
ROLLBACK;   --트랜잭션 시작 시점으로 되돌려라 

--데이터 검색 하기

SELECT * FROM DEPT;

--트랜잭션 (TRANSACTION) : 작업(일)을 처리하는 최소 단위 
    --DML (INSERT, UPDATE, DELETE 문을 사용하면 자동으로 트랜잭션이 시작됨
    --트랜잭션을 종료하지 않으면 외북에서 다른 사용자가 접근을 못함(LOCK)
    -- COMMIT을 해주지 않으면 다른사람이 테이블 접근을 못함 
    --트랜잭션 종료
        --COMMIT : DB에 영구 저장
        --ROLLBACK : 원래 상태로 되돌림 
        
    --트랜잭션의 4가지 특징
        --원자성(ATOMICITY) : 여러 구문을 하나의 작업 단위로 처리됨
        --일관성(CONSISTENCY): 트랜잭션에서 처리한 결과는 일관성을 가져야한다.
        --독립성(ISOLATION) : 하나의 트랜잭션이 처리되기 전까지는 다른 트랜잭션과 격리
        --
        
SELECT * FROM DEPT;
--컬럼과 값의 순서가 맞아야 한다.
INSERT INTO DEPT (DNO, LOC, DNAME)
VALUES (20, 'PUSAN', 'SALE');

--컬럼명을 생략시 값넣기, 컬럼명을 생략할시 모든 컬럼에 값을 넣어 줘야 한다 
INSERT INTO DEPT
VALUES(30, 'ABC','TAEGU');

SELECT * FROM DEPT;

DESC DEPT;

INSERT INTO DEPT (DNO, DNAME)

VALUES (30, 'ABC');

--명시적으로 NULL 넣기
INSERT INTO DEPT
VALUES (40, 'BCD', NULL);


COMMIT;


--회원 정보를 저장하는 테이블 생성 --이름 지을때 조심하기 
CREATE TABLE MEMBER1 (
    ID VARCHAR2(50) NOT NULL PRIMARY KEY , 
    PASSWORD VARCHAR2(50) NOT NULL ,
    ADDR VARCHAR2(100)  NOT NULL,
    PHONE VARCHAR(30) NULL,
    AGE NUMBER(3) NOT NULL,
    WEIGHT NUMBER (5,2) NOT NULL
);

/* 제약 조건 : 데이터의 무결성을 확보하기 위해서 테이블의 컬럼에 부여 
            -무결성: 오류없는 데이터, 원하는 데이터 
    --NOT NULL
    --FOREIGN KEY
    -- PRIMARY KEY : 테이블에서하나만 존재 할수있다
            --PRIMARY KEY가 적용된 컬럼은 중복된 값을 넣을 수 없다.
            -- 데이터를 수정 할떄, 삭제시 조건을 사용하는 컬럼. 
            --인덱스가 자동으로 생성된. <== 검색을 빠르게 할때 사용됨
            -- NULL을 넣을수 없다 
            
            
    --UNIQUE: 중복된 값을 넣을수 없다. 테이블에서 여러번 넣을 수 있다. 
        --NULL을 넣을 수 있다. 1번만 넣을수 있다 
        -- 인덱스가 자동으로 생성된. <== 검색을 빠르게 함.
        
    --CHECK : 값을 넣을떄 체크해서 값을 넣는다
    --NOT NULL : 컬럼에 NULL을 넣을수 없다 
*/
SELECT * FROM USER_CONSTRAINTS;

--원하는 테이블의 제약 조건 확인
SELECT * FROM USER_CONSTRAINTS





INSERT INTO MEMBER(ID, PASSWORD, ADDR, PHONE, AGE, WEIGHT)
VALUES ('BBBB','1234','서울 종로구', '010-1111-1111',20,50.55);



-- NULL 허용 컬럼에 NULL넣기
DESC MEMBER;
INSERT INTO MEMBER
VALUES ('DDD','1234','AMERICA', NULL, 30, 70.557);


INSERT INTO MEMBER ( PASSWORD, AGE, WEIGHT, ID)
VALUES('1234',40, 88.88,'EEE');


COMMIT;
ALTER TABLE MEMBER MODIFY ADDR VARCHAR2(100) NULL; --테이블 컬럼 변경 

-- 수정(UPDATE) <<=== 반드시 WHERE 절을 사용해서 수정 해야함
-- WHERE 절에 사용되는 컬럼은 중복되ㅣㅈ 안흔ㄴ 컬럼을 사용해서 수정 : PRIMARY KEY , UNIQUE 
/*
UPDATE 테이블명
SET 바꿀값= 컬럼명,  컬럼명= 바꿀값
WHERE 조건
*/

SELECT * FROM MEMBER;
UPDATE MEMBER
SET PHONE = '010-2222-2222', AGE = 55, WEIGHT=90.55;  --모든 PHONE AGE WEIGHT을 이값들로 바꿔버림


UPDATE MEMBER 
SET PHONE = '010-2222-2222', AGE = 55, WEIGHT=90.55
WHERE ID = 'BBBB';

SELECT * FROM MEMBER;
ROLLBACK;


--UPDATE 시 중복되지 않는 컬럼을 조건을 준 경우
UPDATE MEMBER
SET PHONE = '010-3333-3333', AGE = 80
WHERE PASSWORD = '1234'; --다 비번이 중복되서 다 바뀜 


UPDATE MEMBER
SET PHONE = '010-3333-3333', AGE = 80
WHERE ID = 'EEE';



--DELETE : 반드시 WHERE 조건을 사용해야 한다. 조건없이 삭제하면 모든 데이터가 삭제됨 
    --중복되지 않는 컬럼을 조건에 적용 : PRIMARY KEY, UNIQUE
    SELECT * FROM MEMBER;
    
DELETE MEMBER
WHERE ID = 'DDD';


--테이블 복사 

CREATE TABLE EMP AS
SELECT * FROM EMPLOYEE;
--복사된 테이블 
SELECT * FROM EMP;
DESC EMP;

/*
    Unique 제약 조건 : 중복된 데이터를 넣을 수 없다
        - NULL을 넣을수 있다. 한번만 넣을 수 있다
        -테이블에 특정 컬럼에 여러번 넣을 수 있다
        -인덱스를 자동으로 생성한다. <== 검색을 아주 빠르게 함
        - JOIN시 ON 절, WHERE 조건       
*/

CREATE TABLE CUSTOMER1 (
    ID VARCHAR(20) NOT NULL PRIMARY KEY, -- 오류 발생, PRIMARY KEY는 반드시 NOT NULL
    PASS VARCHAR(20) NOT NULL UNIQUE, -- 중복되지 않는 컬럼
    NAME VARCHAR(20) NULL UNIQUE,   -- NULL 허용 , 테이블에 여러번 넣을수 있다 
    PHONE VARCHAR(20) NULL UNIQUE,
    ADDR VARCHAR(20) NULL
);
DESC CUSTOMER1;

INSERT INTO CUSTOMER1 (ID, PASS, NAME, PHONE, ADDR)
VALUES ('AAA','1234','홍길동', '010-1111-1111', '서울 종로');

SELECT * FROM CUSTOMER1;

--제약 조건 확인 하기
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CUSTOMER1';


-- 테이블 생성시 제약조건의 이름을 부여하면서 테이블 생성
--제약조건 이름 생성 규칙 : 테이블이름_컬럼명_제약조건유형



CREATE TABLE EMP3 (
                              -- 제약 조건 이름 
        ENO NUMBER(4) CONSTRAINT EMP3_ENO_PK PRIMARY KEY,
        ENAME VARCHAR2 (10),
        SALARY NUMBER(7,2) CONSTRAINT EMP3_SALARY_CK CHECK (SALARY > 0)
);
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP3';

INSERT INTO EMP3 (ENO, ENAME, SALARY)
VALUES (1111, 'SMITH', 10);

SELECT * FROM EMP3;

--=================================================================================


CREATE TABLE EMP4 (
                              -- 제약 조건 이름 
        ENO NUMBER(4) CONSTRAINT EMP4_ENO_PK PRIMARY KEY,
        ENAME VARCHAR2 (10),
        SALARY NUMBER(7,2) CONSTRAINT EMP4_SALARY_CK CHECK (SALARY > 0),
        DNO NUMBER(2) CONSTRAINT EMP4_DNO_CK CHECK (DNO IN (10,20,30,40))
);

INSERT INTO EMP4
VALUES ( 2222, 'SCOTT', 300, 10);

SELECT * FROM EMP4;

COMMIT;


SELECT * FROM USER_CONSTRAINTS 
WHERE TABLE_NAME ='EMP4';


/*
    FOREIGN KEY (참조키) : 다른테이블 (부모)의 PRIMARY KEY, UNIQUE 컬럼을 참조해서 값을 할당
    
*/

SELECT * FROM EMPLOYEE; --DNO : FK ( DEPARTMENT 테이브르이 DNO를 참조)
DESC EMPLOYEE;


SELECT * FROM DEPARTMENT; --부모, DNO 
DESC DEPARTMENT;

INSERT INTO EMPLOYEE
VALUES(8888,'AAAA','AAAA', 7788, '22/12/07', 6000, NULL, 50);--부모에 없는 DNO숫자라서 에러뜸



--부모 테이블 생성 : FOREIGN KEY가 참조하는 컬럼은 PRIMARY KEY , UNIQUE 키컬럼을 참조함

CREATE TABLE PARENTTBL(
    NAME VARCHAR2(20),
    AGE NUMBER(3) CONSTRAINT PARENTTBL_AGE_CK CHECK (AGE > 0 AND AGE < 200),
    GENDER VARCHAR2(3) CONSTRAINT PARENTTBL_GENDER_CK CHECK (GENDER IN ('M','N')),
    INFONO NUMBER CONSTRAINT PARENTTBL_INFONO_PK PRIMARY KEY 
);

DESC PARENTTBL;
--부모 테이블에 값 넣기
INSERT INTO PARENTTBL
VALUES('홍길동',30,'M',1);
INSERT INTO PARENTTBL
VALUES('김똘똘',32,'M',2);
INSERT INTO PARENTTBL
VALUES('원빈',25,'M',3);
INSERT INTO PARENTTBL
VALUES('홍길순',40,'N',4);

SHOW USER;
SELECT * FROM PARENTTBL;


CREATE TABLE CHILDTBL(
    ID VARCHAR2(40) CONSTRAINT CHILDTBL_ID_PK PRIMARY KEY,
    PW VARCHAR2(40) , 
    INFONO NUMBER, CONSTRAINT CHILDTBL_INFONO_FK FOREIGN KEY (INFONO) REFERENCES PARENTTBL(INFONO)
);

--자식 테이블에 값넣기
INSERT INTO CHILDTBL
VALUES ('AAA',1234,1);

INSERT INTO CHILDTBL
VALUES ('BBB',1234,2);

INSERT INTO CHILDTBL
VALUES ('CCC',1234,2);

INSERT INTO CHILDTBL
VALUES ('AAA',1234,5); -- 존재하지 않는 FOREIGN키 넣으면 에러 

SELECT * FROM CHILDTBL;

COMMIT;


/*
    DEFAULT: 컬러므이 값을 넣지 않을떄 DEFAULT로 설정된 값이 기본적으로 들어간다.
        --제약 조건은 아니어서 제약 조건이름을 할당 할수 없다 


*/
CREATE TABLE EMP5(
    ENO NUMBER (4) CONSTRAINT EMP5_ENO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    SALARY NUMBER(7,2) DEFAULT 1000 --값을 넣지 않으면 DEFAULT로 설정된값이 들어감
);

INSERT INTO EMP5(ENO, ENAME)
VALUES(1111, 'AAAA'); 

INSERT INTO EMP5(ENO, ENAME)
VALUES(2222, 'BBBB'); 

INSERT INTO EMP5(ENO, ENAME)
VALUES(3333, 'CCCC'); 


--테이블 삭제
DROP TABLE MEMBER;

CREATE TABLE TB_ZIPCODE(
    ZIPCODE VARCHAR2(7) NOT NULL CONSTRAINT TB_ZIPCODE_ZIPCODE_PK PRIMARY KEY,
    SIDO VARCHAR2(30),
    GUGUM VARCHAR2(30),
    DONG VARCHAR2(30),
    BUNGI VARCHAR2(30)
);

INSERT INTO TB_ZIPCODE
VALUES('1','서울','GUGUM','동','BUNGI');

INSERT INTO TB_ZIPCODE
VALUES('2','서울','GUGUM','동','BUNGI');

INSERT INTO TB_ZIPCODE
VALUES('3','서울','GUGUM','동','BUNGI');

INSERT INTO TB_ZIPCODE
VALUES('4','서울','GUGUM','동','BUNGI');

INSERT INTO TB_ZIPCODE
VALUES('5','서울','GUGUM','동','BUNGI');


CREATE TABLE MEMBER(
    ID VARCHAR2(2) NOT NULL CONSTRAINT MEMBER_ID_PK PRIMARY KEY,
    PWD VARCHAR2(20),
    NAME VARCHAR2(50),
    ZIPCODE VARCHAR2(7), 
    CONSTRAINT MEMBER_ZIPCODE_FK FOREIGN KEY (ZIPCODE) REFERENCES TB_ZIPCODE(ZIPCODE),
    ADDRESS VARCHAR2(20),
    TEL VARCHAR2(13),
    INDATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER
VALUES ('AA','1234','홍길','1','서울','01012341234','99/12/01');
INSERT INTO MEMBER (ID, PWD, NAME, ZIPCODE, ADDRESS,TEL)
VALUES ('BB','1234','홍길동','2','서울','01012341234');
INSERT INTO MEMBER
VALUES ('CC','1234','홍길순','3','서울','01016641234','99/12/21');
INSERT INTO MEMBER
VALUES ('DD','1234','홍길박','4','서울','01012346334','99/12/11');
INSERT INTO MEMBER
VALUES ('EE','1234','홍길춘','5','서울','01019541234','99/12/11');

CREATE TABLE PRODUCTS(
    PRODUCT_CODE VARCHAR2(20) NOT NULL CONSTRAINT PRODUCTS_PRODUCT_CODE_PK PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(100),
    PRODUCT_KIND CHAR(1),
    PRODUCT_PRICE1 VARCHAR2(10),
    PRODUCT_PRICE2 VARCHAR2(10),
    PRODUCT_CONTENT VARCHAR2(1000),
    PRODUCT_IMAGE VARCHAR2(50),
    SIZEST VARCHAR2(5),
    SIZEET VARCHAR2(5),
    PRODUCT_QUANTITY VARCHAR2(5),
    USEYN CHAR(1),
    INDATE DATE
);

INSERT INTO PRODUCTS
VALUES('AAAAA','바나나','A','1234','12345','바나나','바나나사진','1','2','199','o','99/12/12');

INSERT INTO PRODUCTS
VALUES('AAABB','사과','A','1234','12345','사과','사과사진','1','2','199','o','99/12/12');

INSERT INTO PRODUCTS
VALUES('AAACC','파인애플','A','1234','12345','파인애플','파인애플','1','2','199','o','99/12/12');

INSERT INTO PRODUCTS
VALUES('AAADD','멜론','A','1234','12345','멜론','멜론','1','2','199','o','99/12/12');

INSERT INTO PRODUCTS
VALUES('AAAEE','수박','A','1234','12345','수박','수박사진','1','2','199','o','99/12/12');

SELECT * FROM PRODUCTS;

CREATE TABLE ORDERS(
    O_SEQ NUMBER(10) NOT NULL CONSTRAINT ORDERS_O_SEQ_PK PRIMARY KEY,
    PRODUCT_CODE VARCHAR2(20),
    CONSTRAINT ORDERS_PRODUCT_CODE_FK FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCTS(PRODUCT_CODE),
    ID VARCHAR2(16),
    CONSTRAINT ORDERS_ID_FK FOREIGN KEY (ID) REFERENCES MEMBER(ID),
    PRODUCT_SIZE VARCHAR2(5),
    QUANTITY VARCHAR2(5),
    RESULT CHAR(1),
    INDATE DATE
);

INSERT INTO ORDERS
VALUES(1111,'AAAAA','AA','123','11','A',SYSDATE);

INSERT INTO ORDERS
VALUES(2,'AAAAA','BB','123','11','A',SYSDATE);
INSERT INTO ORDERS
VALUES(3,'AAABB','CC','123','11','A',SYSDATE);
INSERT INTO ORDERS
VALUES(4,'AAABB','DD','123','11','A',SYSDATE);
INSERT INTO ORDERS
VALUES(5,'AAACC','EE','123','11','A',SYSDATE);
INSERT INTO ORDERS
VALUES(6,'AAADD','AA','123','11','A',SYSDATE);
INSERT INTO ORDERS
VALUES(7,'AAAEE','BB','123','11','A',SYSDATE);


COMMIT;


















