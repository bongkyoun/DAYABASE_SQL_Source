--IN LINE VIEW SUBSUERY

--VIEW(논리적테이블)
/*
ORA-01031: insufficient privileges
*/
create or replace view emp10_view
as
select empno, ename,job,sal
from emp
where deptno = 10;

select * from emp10_view;
--임시뷰(in-line view)
select * from (select empno, ename,job,sal
                from emp
                where deptno = 10);

/***********************************************************
부서별로 최소연봉을 가진 직원의 사번, 이름, 연봉 읽어오세요 
***********************************************************/
--부서별로 최소연봉
select deptno, min(sal) from emp group by deptno;
/*
30	950
20	800
10	1300
*/

--직원의 사번이름 연봉
select * from emp;
/*
7369	SMITH	CLERK	    7902	1980/12/17	800		    20
7499	ALLEN	SALESMAN	7698	1981/02/20	1600	300	30
7521	WARD	SALESMAN	7698	1981/02/22	1250	500	30
7566	JONES	MANAGER	    7839	1981/04/02	2975	    20
7654	MARTIN	SALESMAN	7698	1981/09/28	1250	400	30
7698	BLAKE	MANAGER	    7839	1981/05/01	2850		30
*/

select e2.empno, e2.ename, e2.sal, e2.deptno, e1.deptno, e1."min_sal"
from (select deptno, min(sal) "min_sal"
        from emp 
        group by deptno) e1  

join emp e2

on e1.deptno = e2.deptno and e1."min_sal" = e2.sal;
/***********************************************************
동일한 직급을 가진 사원의 평균연봉보다 연봉이 높은 사원들 출력 
***********************************************************/
--동일한 직급을 가진 사원 평균 연봉 테이블
 select job,avg(sal) "job_avg_sal" from emp group by job;
 /*
 ---------------------
  JOB      job_avg_sal
 ---------------------
 CLERK	    1037.5
 SALESMAN	1400
 PRESIDENT	5000
 MANAGER	2758.3
 ANALYST	3000
*/

 --2.사원테이블
 /*
7369	SMITH	CLERK	    7902	1980/12/17	800		    20
7499	ALLEN	SALESMAN	7698	1981/02/20	1600	300	30
...
*/               
                
--3.동일한직급을가진 사원의 평균연봉보다 연봉이 높은 사원들출력          
select e2.empno, e2.ename, e2.sal, e2.job, e1.job, round(e1."job_avg_sal")
from (select job, avg(sal) "job_avg_sal"
    from emp
    group by job) e1
join emp e2
on e1.job = e2.job and e1."job_avg_sal" < e2.sal;

/*
 rownum(pseudo(유사) column)
    - 오라클에서만 사용가능한컬럼
    - select시에 조건에맞는 행에 순차적부여
    - where 조건문에서 1번을 포함하는범위조건내에서는 사용가능
    - where 조건문에서 1번을 포함하지않는 범위조건내에서는 사용불가능
*/

select rownum, empno, ename, job, sal from emp order by sal desc; --XXX

select rownum, empno, ename, sal from (select empno, ename, job, sal
                                        from emp 
                                        order by sal desc);

select rownum, empno, ename, sal from (select  empno, ename, job, sal
                                        from emp 
                                        order by sal desc) e
where rownum >=6 and rownum <=10; --XXX

select e1."sal_rank", e1.empno, e1.ename, e1.job, sal from (select rownum "sal_rank", empno, ename, job, sal
                from (select empno, ename, job, sal
                        from emp
                        order by sal desc) e
                
                ) e1
where e1."sal_rank">=6 and e1."sal_rank"<=10;