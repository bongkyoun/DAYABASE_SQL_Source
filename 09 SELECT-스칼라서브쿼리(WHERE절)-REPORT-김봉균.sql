/*
1. 사원 테이블에서 BLAKE보다 급여가 많은 사원들의 사번, 이름, 급여를 검색하시오.
*/
select empno, ename, sal from emp where sal> 
                                    (select sal 
                                    from emp 
                                    where ename='BLAKE');
/*
2. 사원 테이블에서 MILLER보다 늦게 입사한 사원의 사번, 이름, 입사일을 검색하시오.
*/
select empno, ename, hiredate from emp where hiredate>
                                        (select hiredate
                                        from emp
                                        where ename = 'MILLER');
/*
3. 사원테이블에서 사원 전체 평균 급여보다 급여가 많은 사원들의 사번, 이름, 급여를 검색하시오.
*/
select empno, ename, sal from emp where sal >
                                    (select avg(sal)
                                    from emp);
/*
4. 사원 테이블에서 CLARK와 같은 부서이며, 사번이 7698인 직원의 급여보다 많은 급여를 받는 
   사원들의 사번, 이름 , 급여를 검색하시오.
*/
select empno, ename, sal from emp where deptno = 
                                   (select deptno
                                   from emp
                                   where ename = 'CLARK')
                                    and sal >
                                    (select sal
                                    from emp
                                    where empno = 7698);
                                    
/*
5. 사원 테이블에서 부서별 최대 급여를 받는 사원들의 사번, 이름, 부서코드, 급여를 검색하시오.
*/
select empno, ename, deptno, sal from emp where sal = 
                                                (select max(sal) 
                                                from emp 
                                                where deptno=10) or 
                                                sal=(select max(sal) 
                                                from emp 
                                                where deptno=20) or 
                                                sal=(select max(sal)
                                                from emp 
                                                where deptno=30);