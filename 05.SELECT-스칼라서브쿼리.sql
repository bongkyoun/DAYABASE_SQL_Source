--scalar subqueary(where위치)
select sal from emp where ename = 'SCOTT';
select sal from emp where ename = 'SMITH';

select * from emp where sal > 3000;

select * from emp where sal > (select sal 
                                from emp 
                                where ename= 'SCOTT');
                                
select * from emp where sal > 800 and sal < 3000;
                                
select * from emp where sal > (select sal 
                                from emp 
                                where ename = 'SMITH') 
                      and sal < (select sal 
                                from emp 
                                where ename = 'SCOTT');
                                
--scalar subqueary(columm 위치)
select empno, 
        ename, 
        (select dname 
            from dept 
            where e.deptno = dept.deptno)"dname",
            (select loc
            from dept
            where e.deptno = dept.deptno)"loc" 
from emp e;
                                
--join
select empno, ename, dname, loc 
from emp e
left outer join dept d
on e.deptno = d.deptno;

--단일행이 반환되는 서브쿼리
--단일행연산자(=, !=, >, <)
select empno, ename, job from emp
where job = (select job
            from emp
            where empno = 7844);

select empno, ename,sal
from emp
where sal=(select
            min(sal)
            from emp);

select deptno, min(sal) 
from emp
group by deptno
having min(sal) > (select min(sal)
                    from emp 
                    where deptno = 20);

--복수행이 반환되는 서브쿼리
--복수행 연산자(in, any, all)
select * from emp where sal in(950,800,1300);
select min(sal) from emp group by deptno;

--in
select * from emp where sal in(select min(sal)
                                from emp
                                group by deptno);

--all
select sal from emp where job = 'MANAGER';

select * from emp where sal < 2975 and sal < 2850 and sal < 2450;
select * from emp where sal < all(2975,2850,2450);

select * from emp where sal < all(select sal
                                    from emp 
                                    where job = 'MANAGER');

--any
select sal from emp where job = 'MANAGER';

select * from emp where sal > 2975 or sal > 2850 or sal > 2450;
select * from emp where sal > any(2975,2850,2450);
select * from emp where sal > any(select sal
                                    from emp
                                    where job = 'MANAGER');









