--SELECT
--계정이 소유한 테이블목록
select table_name from tabs;

--테이블구조
desc emp;
desc dept;

--모든컬럼 selection
select * from emp;
select * from dept;


--원하는 컬럼만 selection
select empno,ename from emp;
select empno,ename,job,hiredate,sal from emp;

select deptno,dname,loc from dept;
select dname from dept;
/*
오라클 리터럴
    1.숫자 :  90 , 1.234
    2.문자 : '문자','ABC','a'
*/

--컬럼연산(숫자,산술연산)

select empno,ename,sal,sal*1.1 from emp;
select empno,ename,sal,sal*12 from emp;
select empno,ename,sal,comm,sal+comm from emp;
select 1111,'김경호',ename from emp;

--컬럼별칭(alias)
select empno as 사원번호,ename as 사원이름,sal 사원월급,sal*12 사원연봉 from emp;
select empno as "사원 번호",ename as "사원 이름",sal as "사원 월급",sal*12  as "사원 연봉" from emp;

-- as생략가능
select empno "사원 번호",ename "사원 이름",sal "사원 월급",sal*12 "사원 연봉" from emp;
select deptno "부서번호",dname "부서이름",loc "부서위치" from dept;

--null값과의 연산 결과는 null
select empno,ename,sal,comm,sal+comm "총급여" from emp;

--컬럼연산(문자열 연결 연산자 || )

select '김'||'경호' from emp;
select 334||'문자열' from dept;

select '사번'||empno||'번 '||ename||' 님 의 직급은 '||job||' 입니다' "사원설명"  from emp;

/*
    'SMITH' 님의 급여는 800 입니다.
*/

select ''''||ename||''' 님의  급여는 '||sal|| ' 입니다.'from emp;
/*
dual table
*/
desc dual;
select * from dual;
select '''김경호''' from dual;
select 234123*324324 from dual;
select 60*60*24*365||'초'"일년을 초로 환산" from dual;

--DISTINCT(중복행 제거)

select job from emp;
select distinct job from emp; 
select distinct job, ename from emp;
/******************
데이터 제한과 정렬
******************/

--where

select empno, ename, job, deptno from emp where 1=1;
select empno, ename, job, deptno from emp where 2=1;
select empno, ename, job, deptno from emp where deptno = 30;
select * from emp where job = 'SALESMAN';
select * from emp where hiredate = '1981/11/17';

--비교연산자
--숫자비교
select * from emp where sal = 3000;
select * from emp where sal >=3000;
select * from emp where sal < 3000;

select * from emp where sal != 3000;
select * from emp where sal ^= 3000;
select * from emp where sal <> 3000;

--문자비교
select * from emp where job='SALESMAN';
select * from emp where job>='SALESMAN';
select * from emp where ename >='JAMES';

select * from emp where job !='SALESMAN';
select * from emp where job <>'SALESMAN';
select * from emp where job ^='SALESMAN';

--null 비교
select * from emp where comm is null;
select * from emp where comm is not null;

--between
select * from emp where sal between 1000 and 2000;
select * from emp where sal>=1000 and sal<=2000;

--in
select * from emp where empno in(7369, 7788,7839);
select * from emp where empno = 7369 or empno = 7788 or empno = 7839;

select * from emp where job in('SALESMAN','CLERK');
select * from emp where jon ='SALESMAN' or job='CLERK';

--like연산 [%(0개이상), _(1개)]
select empno, ename, sal from emp where ename like 'SMITH';
select empno, ename, sal from emp where ename like '_____';
select empno, ename, sal from emp where ename like 'S____';
select empno, ename, sal from emp where ename like '_L___';

select empno, ename, sal from emp where ename like 'A%';
select empno, ename, sal from emp where ename like '%T%';
select empno, ename, sal from emp where ename like '%T_';
select empno, ename, sal from emp where ename like '__L%';

/*
찾는 문자열
 MAR%TIN
*/
select * from emp where ename like '%\%%' ESCAPE '\';

/*
찾는 문자열
 _JAMES
*/
select * from emp where ename like '*_%' ESCAPE '*';

select * from emp where hiredate like '____/12/__';

--취미가 null이 아닌사람
select * from temp;
select * from temp where hobby is not null;

--취미가 있는 과장
select * from temp where hobby is not null and lev='과장';

--1996년도에 입사한 사원중 과장이 아닌 사람
select * from temp where emp_id like '1996___' and not lev!='과장';

--논리연산자(and, or, not)
select * from emp where job = 'SALESMAN' and sal >=1500;
select * from emp where sal >=2001 and sal<=3000;
select * from emp where sal >=2001 and sal<=3000 and job='MANAGER';
select * from emp where sal >=2001 and sal<=3000 or job='MANAGER';
select * from emp where job ='SALESMAN' or job= 'CLERK';
select * from emp where comm is not null;

--정렬
select * from emp where 1=1 order by empno; -- default asc
select * from emp where 1=1 order by empno asc;
select * from emp where 1=1 order by empno desc;

--숫자정렬
select empno, ename, sal from emp order by sal desc;
select empno, ename, sal*12 from emp order by sal*12 desc;
select empno, ename, sal*12 연봉 from emp order by 연봉 desc;--alias 정렬
select empno, ename, sal*12 연봉 from emp order by 3 desc; --컬럼 순서 번호(alias 연봉은 안넣어도 됌)

--문자정렬
select empno, ename, sal from emp order by ename asc;
select empno, ename, sal from emp order by ename desc;

--날짜정렬(현재와 가까운 시간이 더 크다)
select empno, ename, sal, hiredate from emp order by hiredate asc;
select empno, ename, sal, hiredate from emp order by hiredate desc;

select * from temp;
select * from temp order by birth_date asc;
select * from temp order by birth_date desc;

--2차 정렬
select * from emp order by sal desc, empno asc;
select * from emp order by sal desc, empno desc;