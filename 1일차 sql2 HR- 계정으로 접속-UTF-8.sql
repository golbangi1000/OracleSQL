--모든 테이블 출력 하기
select * from tab;
show user;

--테이블의 구조 확인 하기
/*
 select : 출력하기
 
 select 컬럼명 
 from 테이블이름 
 
 1. employee 테이블의 모든 컬럼을 출력하라 
    --근로자 (고용자)에대한 정보를 저장 
*/
select * 
from employee;

/*
ENO 사원번호
ENAME 사원이름
JOB 직책
NANAGER 상관
HIREDATE : 입사일
COMMISSION : ㅂ노서ㅡ
DNO 부서 번호 

*/

select ENO from employee;
--2.deapartment 테이블의 모든 컬럼을 선택

--부서에 대한 정보를 저장하는 테이블 
select * from department;
/*
    DNO 부서번호
    DNAME : 부서명
    LOC : 부서의 위치 
*/


--3. salgrade 테이블의 모든 컬럼(필드,엔티티)를 출력
    --판매 순위를 저장하는 테이블. 
select * from salgrade;
/*
GRADE : 순위
LOSAL : 제일 낮은 연봉
HISAL : 제일 높은 연봉 
*/


--select : 출력하라
--컬럼 필드 엔티티
--레코드 : 각컬럼에 들어간 값 1라인 
-- 레코드 셋 : 레코드들의 집합

select * 
from employee;

--특정 컬럼만 출력 하기
select eno 
from employee;

--특정 컬럼 여러개 출력 하기
select eno, ename, salary
from employee;

--모든 컬럼 출력 하기
select eno, eno, eno, ename, job,manager, hiredate, salary, commission ,dno,dno
from employee;

--특정 컬러만 출력시 여러번 출력 하기
select eno, ename, salary, ename, ename
from employee;

--테이블의 구조 확인 하기
describe employee;
desc employee;


--컬럼을 별칭으로 출력하기 ( as 별칭) 
select eno as 사원번호, ename as 사원명, job as 직책
from employee;


--별칭 할때 as 없어도 가능한듯 별칭 띄어쓰기 넣을려면 ""로 감싸주기 
select eno 사원번호, ename 사원명, job 직책 , manager 상관번호, hiredate 입사일, salary "월 급",
commission 보너스, dno "부서 번호" 
from employee;

--조건을 사용하여 출력하기 : where


select *
from employee
where eno = 7499; --조건을 사용해서 출력 할 경우 , eno 컬럼의 값이 7499

-- <== employee테이블의 구조를 확인
desc employee;            


--값을 출력시 : number 데이터 타입의 값은 ''없이 출력
--          number 이외의 데이터 타입은 '' : char, varchar, date

select * from employee  
where job = 'MANAGER' ; --job (varchar2), 값을 가져올때는 대소문자를 구별함



desc employee;

select * from employee
where dno = 20;

--<문제>
-- salary (월급) 2000만원 이상인 사용자만 출력 
--이름이 clark 인 사용자의 월급만 출력
-- 사원 번호 (ENO) 7788인 이름과 입사 날짜를 출력 <==컬럼 이름을 별칭으로 출력

desc employee;
select * from employee 
where salary >= 2000;

select salary 월급 from employee where ename = 'CLARK';

select ename 이름, hiredate "입사 날짜" from employee where eno = 7788;

-- select 문의 전체 구조 -------------------------------------------------


/*
select -- 컬럼명 : * (모든 컬럼) , 
distinct  -- (없어도되는거) 중복된 값을 제거해서 출력해라 (생략 가능) 
from    -- 테이블명, 뷰이름,
where --조건
group by --컬럼명 : 특정 컬럼의 동일한 값을 그룹핑 
having -- group by에서 나온 결과를 조건을 처리
order by --정렬해서 출력 할 컬럼, asc: 내림차순 정렬, desc : 오름차순 정렬 
*/

select * from employee;

select distinct dno 부서번호
from employee;

select 
distinct
dno
from employee;


select eno, ename, salary as 월급, salary * 12, salary
from employee;

--전체 연봉 구하기 : 월급 * 12 + 보너스 = 전체 연봉

select eno, ename, salary, commission, salary * 12 as 연봉, (salary * 12) + commission as 전체연봉
from employee;


--전체 연봉을 계산할떄 null이 들어간 컬럼을 0으로 변경후 연산을 적용해야한다
    --nvl 함수 : null 이 들어간 컬럼을 다른 값으로 변화 해서 처리해 주는 함수
    --nvl ( commission , 0 ) <== commission 컬럼에 null을 0으로 수정해서 처리해라 
    
select eno, ename, salary, commission, salary * 12 as 연봉, (salary *12) + nvl(commission,0) as 전체연봉
from employee;

-- null 이 들어간 컬럼을 출력 하기 < == 주의

select *
from employee
where commission = null;

select *
from employee
where commission is null;

select * 
from employee
where commission is not null;

--where 조건에서 and , or 사용 하기 

--부서번호가 20이나 30인 모든 컬럼 

select * from employee where dno = 30 or dno = 20;

select * from employee
where dno = 20 or salary >= 1500;


--job 직책 manager이면서 월급이 2000이상인

select * from employee where job = 'MANAGER' and salary > 2000;


/*
<문제1>commission 보너스 null인 값만 출력하되 사원번호 사원이름 입사날짜를 출력
<문제2> dno(부서번호)가 20이고 입사날짜가 81년 4월이후 사원의 이름과 직채고가 입사날짜를 출력
<문제3> 연봉을 계산해서 사원보호 사원이름 월급 보너스 전체 연봉 출력
<문제4> commission 이 null이 아닌 사용자의 이름만 출력
<문제5> manager (직급상사) 7698인 사원이름과 직책을 출력
<문제6> 월급이 1500이상이고 부서가 20인 사원의 사원이름과 입사날짜, 부서번호 월급을 출력
<문제7> 입사날짜가 81년4월이상이고 81년 12월 말일까지인 사원 이름과 입사날짜를 출력
<문제8> 직책 job salesman이면서 연봉이 2000 이상이면서 부서번호가 20인 사원명을 출력
<문제9> 월급이 1500이하이면서 부서번호가 20번이 아닌 사원이름과, 월급과, 부서번호를 출력
<문제10> 사원번호(eno) 가 7788, 7782인 부서번호와 이름과 직책을 출력 
*/
--<문제1>commission 보너스 null인 값만 출력하되 사원번호 사원이름 입사날짜를 출력
select commission 보너스, eno 사원번호, ename 사원이름, hiredate 입사날짜 from employee where commission is null;

--<문제2> dno(부서번호)가 20이고 입사날짜가 81년 4월이후 사원의 이름과 직채고가 입사날짜를 출력
select ename 사원이름, hiredate 입사날짜, eno 사원번호 from employee
where dno = 20 and hiredate > '81/04/01';

desc employee;
--<문제3> 연봉을 계산해서 사원보호 사원이름 월급 보너스 전체 연봉 출력
select eno 사원번호, ename 사원이름, salary 월급, commission 보너스, (salary * 12) 연봉,
(salary *12 + nvl(commission,0)) as 전체연봉 from employee;

--<문제4> commission 이 null이 아닌 사용자의 이름만 출력
select * from employee where commission is not null;

--<문제5> manager (직급상사) 7698인 사원이름과 직책을 출력
select ename 사원이름, job 직책 from employee where job = 'MANAGER' and eno = 7698;

--<문제6> 월급이 1500이상이고 부서가 20인 사원의 사원이름과 입사날짜, 부서번호 월급을 출력
select ename 사원이름, hiredate 입사날짜, dno 부서번호, salary 월급 from employee 
where salary >= 1500 and dno = 20;

--<문제7> 입사날짜가 81년4월이상이고 81년 12월 말일까지인 사원 이름과 입사날짜를 출력

select ename 사원이름, hiredate 입사날짜 from employee 
where hiredate >= '81/04/01' and hiredate <= '81/12/31';

--<문제8> 직책 job salesman이면서 연봉이 1500 이상이면서 부서번호가 30인 사원명을 출력
select ename 사원이름 from employee where job = 'SALESMAN' and salary >=2000 and dno = 30;
--없음 
select * from employee;

--<문제9> 월급이 2000이하이면서 부서번호가 20번이 아닌 사원이름과, 월급과, 부서번호를 출력
select ename 사원이름, salary  월급, dno 부서번호 from employee where salary <= 2000 and dno != 30;

--<문제10> 사원번호(eno) 가 7788, 7782인 부서번호와 이름과 직책을 출력 
select ename 이름, job 직책 from employee where eno = 7788 or eno = 7782;






































































































