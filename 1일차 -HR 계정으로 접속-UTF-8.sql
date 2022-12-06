--접속 유저 확인
show user;

--2. 테이블 생성
create table myTbl2(
    id varchar2(20),
    pass varchar2(20)
    );
    
--3. 테이블에 값넣기 : commit( 저장하라) 해줘야됨 
--보기 DBA 
insert into myTbl2 values('1','1234');
commit;     --DB에 영구적으로 저장하라 ( Insert, Update, Delete, 구문에서 사용해야됨 )
--commit 안하면 데이터 다날라감 
--4. 테이블의 값을 출력 하기 
 
 select * from mytbl2;
 
--5. 테이블 삭제 하기

drop table myTbl2;


--원격 접속한 Oracle 버젼확인

select * from v$version;

--접속한 Database에 존재하는 모든 테이블 보기 

select * from tab;











