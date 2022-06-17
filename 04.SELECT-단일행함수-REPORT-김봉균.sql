/*
<<< 06.단일 함수.pdf >>>
1. 사원테이블에서 입사일이 12월인 사원의 사번, 사원명, 입사일 검색하시오
*/
select empno, ename, extract(month from hiredate)
from emp;
/*
2. 다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오.
*/
select empno, ename, sal+nvl(comm,0) "급여"
from emp;
replace(jumin,substr(jumin,1,6),'******')
/*
3 다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오.
*/
select empno, ename, hiredate "입사일"
from emp;

/*
4 . 사원 테이블에서 급여에 따라 사번, 이름, 급여, 등급을 검색하는 SQL 문장을 작
성하시오 ( CASE 함수 이용)
*/