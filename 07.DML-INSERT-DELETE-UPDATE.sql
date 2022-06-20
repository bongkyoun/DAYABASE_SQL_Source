/*
DML(Data Manipulation Language)
*/

desc dept;
/*
이름     널?       유형           
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)    
DNAME           VARCHAR2(14) 
LOC             VARCHAR2(13) 
*/
select * from dept;

insert into dept(deptno, dname, loc) values(90, '인사과', '서울');
insert into dept(loc, deptno, dname) values('부산', 91, '개발과');
insert into dept values(92, '홍보부', '인천');

-- null값 입력
insert into dept(deptno, dname, loc) values(93, null, null);
insert into dept(deptno, dname) values(94, '생산1과');
insert into dept(deptno, dname,loc) values(95,'생산2과', null);
insert into dept(deptno) values(96);

/*
insert시 오류나는 경우
*/
--primary key가 중복된 경우
insert into dept(deptno, dname, loc) values(96, '마케팅과', '제주');
--ORA-00001: unique constraint (SCOTT.PK_DEPT) violated


--primary key가 null인 경우
insert into dept(deptno, dname, loc) values(null, '마케팅2과', '충주');
--ORA-01400: cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")
insert into dept(dname, loc) values('마케팅3과', '전주');
--ORA-01400: cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

--데이터가 큰 경우
insert into dept(deptno, dname, loc) values(1000, '총무과', 'LA');
--ORA-01438: value larger than specified precision allowed for this column
insert into dept(deptno, dname, loc) values(97, '미래비젼팀', 'CA'); --한글 1글자(3바이트)
--ORA-12899: value too large for column "SCOTT"."DEPT"."DNAME" (actual: 15, maximum: 14)

--데이터 타입이 일치하지 않는 경우
insert into dept values('구십칠', '기획팀', '광주');
--ORA-01722: invalid number
insert into dept(deptno, dname, loc) values(97, 50000, '머구');
--숫자는 문자화 되서 삽입된다. 
commit;
desc emp;

/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2) 
*/

select * from emp;

insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(9000, '강감찬', 'MANAGER', 7389, to_date('2022/01/01','YYYY/MM/DD'),2000, 0, 40);

insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(9001, '홍길동', 'MANAGER', null, sysdate, 2000, null, 40);

insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(9002, '이순신', null, null, null, null, null, null);

insert into emp values(9003, null, null, null, null, null, null, null);
insert into emp(empno) values(9004);
/*
insert 시 오류나는 경우
*/
--ORA-00001: unique constraint (JDEVELOPER02.PK_EMP) violated
--insert into emp values(9004, '아무개', null, null, null, null, null, null);

--SQL 오류 : ORA-00947: not enough values
--insert into emp values(9005, '누구개', null, null, null, null, null);

--ORA-02291: integrity constraint (JDEVELOPER02.FK_DEPTNO) violated - parent key not found
--insert into emp values(9006, '김수한', null, null, null, null, null, 99);

commit;

--UPDATE
update dept set dname = '인사팀', loc = 'LA' where deptno = 90;
--1 행 이(가) 업데이트되었습니다.

update dept set dname = '인사팀', loc = 'LA' where deptno = 99;
--0개 행 이(가) 업데이트되었습니다.

update dept set loc='제주' where dname = '홍보부';
--1 행 이(가) 업데이트되었습니다.

update dept set loc='SEOUL' where loc is null;
--4개 행 이(가) 업데이트되었습니다.

update dept set dname= '영업팀' where dname is null;
--2개 행 이(가) 업데이트되었습니다.

--update dept set loc = 'SEOUL근교' where loc = 'SEOUL';
update dept set loc = loc||'근교' where loc = 'SEOUL';

update dept set dname = replace(dname, '과', '팀') where dname like '%과';

update dept set dname=loc||deptno||'팀' where deptno = 97;

update emp set ename = '최영',
                        job = 'ANALYST', 
                        mgr = null,
                        hiredate = to_date('2000/12/12', 'YYYY/MM/DD'),
                        sal = 9000,
                        comm = 1000,
                        deptno = 91
where empno = 9003;

update emp set hiredate = hiredate +7, sal = sal*1.1 where empno = 9000;

update emp set sal = 2000 where sal is null;

update emp set hiredate = sysdate where hiredate is null;

update emp set comm = 200 where comm is null or comm = 0;

update emp set mgr = 0 where mgr is null and empno != 7839;

update emp set job = 'SALEMAN' where job is null;

update emp set deptno = 40 where deptno is null;

update emp set ename = '아이티' where empno = 9004;

commit;

--delete
delete from dept where deptno = 90;

--delete dept where deptno = 91;
--ORA-02292: integrity constraint (JDEVELOPER02.FK_DEPTNO) violated - child record found

delete from dept where dname like '영업%';

delete from dept where deptno >= 92;

commit;

