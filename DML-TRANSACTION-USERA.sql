--usera
--developer00이 가지고 있는 dept, emp select
select * from jdeveloper00.dept;
select * from jdeveloper00.emp;

/*
usera
<< transaction >>
*/
--TRANSACTION 시작
select * from jdeveloper00.emp where ename = 'KING';
update jdeveloper00.emp set sal = 6000 where ename = 'KING';
select sal from jdeveloper00.emp where ename = 'KING';

--TRANSACTION 종료
commit;

select sal from jdeveloper00.emp where ename = 'KING';

--Transaction시작(DML-->insert, delete, update)
select * from jdeveloper00.dept;
insert into jdeveloper00.dept values(60, '기획팀', '제주');
insert into jdeveloper00.dept values(60, '영업팀', '청주');
select * from jdeveloper00.dept;

--TRANSACTION 종료
commit;

--Transaction 시작(DML-->insert, delete, update)
delete from jdeveloper00. dept where empno>=9003;
delete from jdeveloper00. dept where deptno>=90;
select * from jdeveloper00.emp;
select * from jdeveloper00.dept;

--update jdeveloper00.dept set dname = '홍보부' where deptno>=90;
--TRANSACTION 종료
rollback;





















