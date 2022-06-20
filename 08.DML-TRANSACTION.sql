--DML TRANSACTION
/*
<<Transaction>>
    트랜젝션의 정의
      - 하나의 논리적기능(업무)를 실행하기위한 작업의단위
      - 데이타베이스 상태를 변화시키는 1개 또는 여러개의 DML(update,delete,insert)문으로구성
*/

delete emp where empno>=9000;
select * from emp;
rollback;

delete dept where dname = '영업팀';
rollback;

delete emp where empno>=9000;
select * from dept where deptno >=90;
commit;