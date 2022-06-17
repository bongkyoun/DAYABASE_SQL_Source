/*
ORACLE JOIN
*/

--cross join
select empno, ename, e.deptno, d.deptno, dname, loc from emp e, dept d;

--equi join(동등조인)
/*
inner join :
    - 조인조건에 만족하는 행만 출력
    - 부서번호를 가진 사원만 출력(부서를 배정받은 사원 출력)
*/
select e.*, d.* 
from emp e, dept d 
where e.deptno = d.deptno;

/*
left outer join : 
    - 조인조건에 만족하지 않는 왼쪽 테이블의 행도 출력
    - 부서번호를 가지지 않는 사원도 출력(부서를 배정받지 못한 사원도 출력)

*/
select *
from emp e, dept d
where e.deptno = d.deptno(+);

/*
right outer join : 
    - 조인조건에 만족하지 않는 오른쪽 테이블의 행도 출력
    - 사원이 소속 되있지않은 부서정보도 출력
*/
select *
from emp e, dept d
where e.deptno(+) = d.deptno;

/*
full outer join : 
    - 조인 조건에 만족하지않는 오른쪽, 왼쪽 테이블의 행도 출력
    - 부서번호를 가지지 않는 사원도 출력(부서를 배정받지 못한 사원도 출력)
    - 사원이 소속 되있지않은 부서정보도 출력
*/
/*
select *
from emp e, dept d
where e.deptno(+) = d.deptno(+);
*/

select *
from emp e, dept d
where e.deptno = d.deptno(+)

union

select *
from emp e, dept d
where e.deptno(+) = d.deptno;

--non equi join(비동등조인)
select e.empno, e.ename, e.sal, g.grade 
from emp e, salgrade g
where e.sal >= g.losal and e.sal <= g.hisal;

--3개 테이블 조인
--student, department, professor

select s.studno, s.name, s.deptno1, d.dname, s.profno, p.name
from student s, department d, professor p
where s.deptno1 = d.deptno and s.profno = p.profno(+);

--self join
--inner join
select e.empno, e.ename, e.mgr, m.empno, m.ename
from emp e, emp m
where e.mgr = m.empno;

--left outer join(매니져가 없는 사원도 출력)
select e.empno, e.ename, e.mgr, m.empno, m.ename
from emp e, emp m
where e.mgr = m.empno(+);

/*
--right outer join(사원이 없는 매니져)
select e.empno, e.ename, e.mgr, m.empno, m.ename
from emp e, emp m
where e.mgr(+) = m.empno;
*/




