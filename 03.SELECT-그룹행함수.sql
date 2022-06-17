--그룹함수
--emp테이블(전체사원그룹)
select sum(sal) "사원 전체 급여 합",
        min(sal) "사원 전체 최소 급여",
        max(sal) "사원 전체 최대 급여",
        avg(sal) "사원 급여 평균",
        avg(comm) "평균 커미션",
        count(empno) "사원 번호의 갯수",
        count(comm) "커미션 받는 사원의 수",
        count(*) "사원 수 null 포함"
from emp;

--부서별로 그룹핑(emp 테이블 안에서)

select deptno,
        count(*) "부서별 인원 수",
        round(avg(sal)) "부서별 급여 평균",
         max(sal) "부서별 최대급여",
         min(sal) "부서별 최소 급여",
         sum(sal) "부서별 급여 합"

from emp
where 1=1
group by deptno
order by deptno asc;

--having(grouping 이후에 filtering)
--부서별 인원 수 5명 이하인 부서 출력
select deptno, count(*) "부서별 인원 수"
from emp
group by deptno
having count(*)>=5
order by deptno;

--부서별 평균급여 2000이하인 부서 출력
select deptno, round(avg(sal)) "부서별 평균 급여"
from emp
group by deptno
having avg(sal)>=2000
order by deptno;

--직급별로 그룹핑
select job,
        count(*) "직급별 인원 수",
        round(avg(sal)) "직급별 급여 평균",
        sum(sal) "직급별 급여 합"
from emp 
group by job
order by job;

--having(grouping 이후 filtering)
--직급별 급여 평균이 3000이상인 직급
select job,
        count(*) "직급별 인원 수",
        round(avg(sal)) "직급별 급여 평균",
        sum(sal) "직급별 급여 합"
from emp 
group by job
having avg(sal)>=3000
order by "직급별 급여 평균" desc;

/*
2.사원테이블로부터 부서별,부서내에서 업무별 급여합계를 계산하고자
한다. 다음과 같은 결과를 출력할
수 있는 SQL문장 작성?
*/
select deptno ,job, sum(sal)
from emp
group by deptno,job
order by deptno;
/*
-----------------------
DEPTNO JOB    SUM(SAL) 
-----------------------
10	CLERK	   1300
10	MANAGER	   2450
10	PRESIDENT  5000
20	ANALYST	   6000
20	CLERK	   1900
20	MANAGER	   2975
30	CLERK	    950
30	MANAGER	   2850
30	SALESMAN    5600
*/

--가로출력

/*
----------------------------------------------------
DEPTNO  CLERK  MANAGER  PRESIDENT  ANALYST SALESMAN
----------------------------------------------------
   10     400    600      4000                3000
   20     299          
   30     390    500                 5000     4000
*/
select deptno, sum(sal) "CLERK", sum(sal) "MANAGER", sum(sal) "PRESIDENT", sum(sal) "ANALYST",sum(sal) "SALSEMAN"
from emp
group by deptno
order by deptno;


3. 사원테이블로부터 년도별 , 월별 급여합계를 출력할수 있는
   SQL문장 작성
*/
select to_char(hiredate,'YYYY') "년" , to_char(hiredate,'MM') "월", sum(sal) "급여 합계"
from emp
group by to_char(hiredate,'YYYY'), to_char(hiredate,'MM')
order by "년", "월";
/*
--------------------
 년     월  급여합계
--------------------
1980	12	800
1981	02	2850
1981	04	2975
1981	05	2850
1981	06	2450
1981	09	2750
1981	11	5000
1981	12	3950 

1982	01	1300
1987	04	3000
1987	05	1100
*/
