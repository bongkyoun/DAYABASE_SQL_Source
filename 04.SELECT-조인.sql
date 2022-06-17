/****************SELECT문실행순서************************
- FROM, JOIN > WHERE, GROUP BY, HAVING > SELECT > ORDER BY
1.FROM과 JOIN
    JOIN이 먼저 실행되어 데이터가 SET으로 모아지게 됌.
    여기에는 서브쿼리도 함께 포함되어 임시적인 테이블을 만들 수 있게 도와줌.
2.WHERE
    데이터셋을 형성하게 되면 WHERE의 조건이 개별 행에 적용이 된다. 
    이 WHERE절의 제약 조건은 FROM절로 가져온 테이블에 적용이 될 수 있다.
3.GROUP BY
    WHERE의 조건 적용 후 나머지 행은 GROUP BY절에 지정된 열의 공통 값을 기준으로 그룹화된다. 
    쿼리에 집계 기능이 있는 경우에만 이 기능을 사용해야 한다.
4.HAVING
    GROUP BY 절이 쿼리에 있을 경우 HAVING 절의 제약조건이 그룹화된 행에 적용됌.
5.SELECT
    SELECT에 표현된 식이 마지막으로 적용됌.
6.DISTINCT
    표현된 행에서 중복된 행은 삭제됌
7.ORDER BY
    지정된 데이터를 기준으로 오름차순, 내림차순을 지정
*******************************************************************************/
--JOIN[ANSI, SQL3, SQL1999]
--CROSS JOIN
select * from emp cross join dept;

--NATURAL JOIN(같은이름을 가진 컬럼을 조인 조건으로 사용)
select * from emp natural join dept;


--JOIN ~ ON 을 이용한 JOIN
/*
 inner join : 조인조건에 만족하는 행만 출력
 outer join : 조인조건에 만족하지않는 행도 출력
*/
/*
inner join
   - 조인조건에 만족하는 행만 출력
*/
select emp.empno, emp.ename, emp.deptno"사원부서 번호", dept.deptno"부서 부서 번호", dept.dname, dept.loc
from emp
inner join dept 
on emp.deptno = dept.deptno;

/*
 outer join
    - 조인조건에 만족하지않는 행도 출력
    - 부서번호를 가지지 않는 사원도 출력(부서를 배정받지 못한 사원도 출력)
*/
left outer join
select emp.empno, emp.ename, emp.deptno"사원부서 번호", dept.deptno"부서 부서 번호", dept.dname, dept.loc
from emp
left outer join dept 
on emp.deptno = dept.deptno;

/*
 inner join
    - 조인조건에 만족하는 행만 출력
 */

select empno, ename, d.deptno, dname, loc
from emp e
inner join dept d 
on e.deptno = d.deptno;

/*
 right outer join
    - 조인조건에 만족하지않는 오른쪽 테이블의 행도 출력
    - 부서번호를 가지지 않는 사원도 출력(부서를 배정받지 못한 사원도 출력)
*/
select empno, ename, d.deptno, dname, loc
from emp e 
right outer join dept d
on e.deptno = d.deptno;

/*
full outer join
    - 조인조건에 만족하지 않는 오른쪽, 왼쪽 테이블의 행도 출력
    - 부서번호를 가지지 않는 사원도 출력(부서를 배정받지 못한 사원도 출력)
    - 사원이 소속되있지 않는 부서정보도 출력
*/
select * 
from emp e 
full outer join dept d 
on e.deptno = d.deptno;





select e.empno, ename, e.deptno, d.dname, loc
from emp e 
join dept d 
on e.deptno= d.deptno; 


select empno, ename, e.deptno, dname, loc
from emp e
join dept d
on e.deptno=d.deptno and e.deptno = 10;

--TEMP(dept_code) TDEPT(dept_code)
select emp_id, emp_name, e.dept_code, dept_name, area 
from temp e
join tdept d
on e.dept_code = d.dept_code;

--STUDENT(DEPTNO1), DEPARTMENT(DEPTNO)
select studno, name, s.deptno1, dname
from student s
join department d
on s.deptno1 = d.deptno;

--STUENT(DEPTNO1, DEPTNO2), DEPARTMENT(DEPTNO), DEPARTMENT(DEPTNO)
select studno, name, s.deptno1, d1.dname"주 전공", d2.dname "부 전공"
from student s
left outer join department d1
on s.deptno1 = d1.deptno
left outer join department d2
on s.deptno2 = d2.deptno;

--3개 테이블 join
--STUDENT(DEPTNO, PROFNO) + DEPARTMENT, PROFESSOR
/*
 join 순서
 1. student + department 조인
 2. student + department 조인된 결과 테이블과 professor 테이블 조인
*/
select studno,s.name, d.deptno, dname, p.name, position
from student s
left outer join department d
on s.deptno1 = d.deptno
left outer join professor p
on s.profno = p.profno;

--3개 테이블 조인
--emp + salgrade
select empno, ename, sal, grade, losal, hisal
from emp e left outer join salgrade g
on e.sal>=g.losal and e.sal<=g.hisal;

--emp + salgrade + dept
select empno, ename, sal, grade, dname, loc
from emp e left outer join salgrade g
on e.sal>=g.losal and e.sal<=g.hisal
join dept d
on e.deptno = d.deptno;

--self join
/*
사원과 매니저 이름출력
inner join(매니저가 존재하는 사원)
*/
select e.empno "사원번호" ,
        e.ename "사원이름", 
        e.mgr "사원매니저 번호", 
        m.empno "매니저 사원번호", 
        m.ename "매니저 사원이름"
from emp e inner join emp m
on e.mgr = m.empno;

/*
outer join(매니저가 존재하지않는 사원도 출력)
*/
select e.empno "사원번호" ,
        e.ename "사원이름", 
        e.mgr "사원매니저 번호", 
        m.empno "매니저 사원번호", 
        m.ename "매니저 사원이름"
from emp e left outer join emp m
on e.mgr = m.empno;

/*
 on join 조건 filtering 하는 경우와
 where 구문에서 filtering 하는 경우
 outer join시 차이 발생
*/
--inner join
select e.empno, e.ename, e.sal, d.dname, d.loc
from emp e 
inner join dept d
on e.deptno = d.deptno and e.sal>1000;

select e.empno, e.ename, e.sal, d.dname, d.loc
from emp e 
inner join dept d
on e.deptno = d.deptno
where e.sal>1000;

--outer join
select e.empno, e.ename, e.sal, d.dname, d.loc
from emp e 
left outer join dept d
on e.deptno = d.deptno and e.sal>1000;

select e.empno, e.ename, e.sal, d.dname, d.loc
from emp e 
left outer join dept d
on e.deptno = d.deptno
where e.sal>1000;
