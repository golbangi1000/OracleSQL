show user;
select * from mytbl;

insert into myTbl values ('1', '1234');


commit

-- �� �� �ּ� : ���α׷����� �ؼ����� �ʴ°� 
/*
������ �ּ�

*/

select * from myTbl;
-- 1. HR ���� ���� : 12�������� ������ ������ ������ �տ� c##�� �ٿ����Ѵ�
-- ������ �����ҷ��� system�������� ������ ����â���� ��ɾ 
-- ������ HR ��й�ȣ 1234
create user c##HR identified by 1234; 


--2. HR ������ ���� �ο� : 
/*
 connect : ���ܿ��� DB�� �����Ҽ��ִ� ���� , 
 resource : ��ü(resource) - Table, index, view store procedure, trigger , function��
 ���� ����, ����
*/

grant connect, resource to C##HR;


--3. ���̺� �����̽��� ����� ���� �ο� 
-- USERS ���̺� �����̽��� ��뷮�� ������ ����Ҽ� �ֵ��� ���� �ο� 
alter user C##HR quota unlimited on USERS;


--4. HR ���� ���� - ���� �������� �Ǿ� �ִ� ��� ������ �ȵ�. 
-- ctrl + enter �� ��� �ű⸸ ���� 
show user;

drop user c##HR;


select * from tab;















