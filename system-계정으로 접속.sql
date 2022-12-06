show user;
select * from mytbl;

insert into myTbl values ('1', '1234');


commit

-- 한 줄 주석 : 프로그램에서 해석되지 않는것 
/*
여러줄 주석

*/

select * from myTbl;
-- 1. HR 계정 생성 : 12버젼부터 게정을 생성시 계정명 앞에 c##을 붙여야한다
-- 계정을 생성할려면 system계정으로 접속한 쿼리창에서 명령어를 
-- 계정명 HR 비밀번호 1234
create user c##HR2 identified by 1234; 


--2. HR 계정의 권한 부여 : 
/*
 connect : 원겨에서 DB에 접속할수있는 권한 , 
 resource : 객체(resource) - Table, index, view store procedure, trigger , function을
 생성 수정, 삭제
*/

grant connect, resource to C##HR2;


--3. 테이블 스페이스를 사용할 권한 부여 
-- USERS 테이블 스페이스의 사용량을 무제한 사용할수 있도록 권한 부여 
alter user C##HR2 quota unlimited on USERS;


--4. HR 계정 삭제 - 연결 설정되이 되어 있는 경우 삭제가 안됨. 
-- ctrl + enter 블럭 잡고 거기만 실행 
show user;

drop user c##HR;


select * from tab;















