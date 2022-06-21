--테이블제약조건(constraint)
/*
1. not null
2. unique 
3. primary key(unique + not null)
4. foreign key(다른테이블의 primary key 컬럼의 데이타만저장가능)
5. check(컬럼의 값의제한) 
*/
/*************************************
1. not bull(컬럼 수준에서만 정의 가능)
**************************************/
drop table sawon1; --삭제

create table sawon1(
    no number(4),
    name varchar2(50) not null,
    hiredate date constraint sawon1_hiredate_nn not null
);
desc sawon1;
/*
이름       널?       유형           
-------- -------- ------------ 
NO                NUMBER(4)    
NAME     NOT NULL VARCHAR2(50) 
HIREDATE NOT NULL DATE      
*/
select * from user_constraints where table_name = 'SAWON1';

insert into sawon1 values(1, '홍길동', sysdate);

insert into sawon1 values(2, '홍길서',null);
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON1"."HIREDATE")

insert into sawon1 values(3, null,sysdate);
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON1"."NAME")

insert into sawon1(no, name) values (4, '홍길북');
--RA-01400: cannot insert NULL into ("SCOTT"."SAWON1"."HIREDATE")

/*************************************
1. unique(중복 값 허용안함/null은 허용)
**************************************/
--컬럼수준(컬럼정의할때 선언)
drop table sawon2;

create table sawon2(
    no number(4),
    id varchar2(10) unique not null,
    name varchar2(50),
    email varchar2(50) constraint sawon2_email_uq unique
);
select * from sawon2;

insert into sawon2 values(1, 'guard', '이순신', 'aaa@gmail.com');
insert into sawon2 values(2, 'guard', '삼순신', 'bbb@gmail.com');
--ORA-00001: unique constraint (SCOTT.SYS_C007056) violated
insert into sawon2 values(3, 'melon', '사순신', 'aaa@gmail.com');
--ORA-00001: unique constraint (SCOTT.SAWON2_EMAIL_UQ) violated

insert into sawon2 values(4, 'tomato', '오순신', null);
insert into sawon2 values(5, 'orange', '육순신', null);
insert into sawon2 values(6, null, '칠순신', null);
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON2"."ID")

--테이블수준(컬럼정의 한 후 선언)
drop table sawon3;

create table sawon3(
    no number(4),
    id varchar2(10) not null,
    name varchar2(50),
    email varchar2(50),
    unique(id),
    constraint sawon3_email_uq unique(email)
);
select * from sawon3;

/************************
3. primary key(ubique + not null)
    - 테이블당 1개의 pk만 설정
***********************/
--컬럼레벨
drop table sawon4;
create table sawon4(
    no number (4) primary key,
    name varchar2(50) not null,
    sal number(10,1) default 0 not null
);

drop table sawon5;
create table sawon5(
    no number (4) constraint sawon5_no_pk primary key,
    name varchar2(50) not null,
    sal number(10,1) default 0 not null
);  
insert into sawon5 values(1, '일소라', 20000.8);
insert into sawon5 values(2, '이소라', 45000.8);

insert into sawon5 values(2, '투소라', 99000.8);
--ORA-00001: unique constraint (SCOTT.SAWON5_NO_PK) violated
insert into sawon5 values(null, '널소라', 56000.8);
--ORA-01400: cannot insert NULL into ("SCOTT"."SAWON5"."NO")

--테이블레벨
drop table sawon6;
create table sawon6(
    no number (4),
    name varchar2(50) not null,
    sal number(10,1) default 0 not null,
    primary key(no)
);  
drop table sawon7;
create table sawon7(
    no number (4),
    name varchar2(50) not null,
    sal number(10,1) default 0 not null,
    constraint sawon7_no_pk primary key(no)
);

/*********테이블생성 이후에 primary key 추가 제거***************/
drop table sawon8;
create table sawon8(
    no number (4),
    name varchar2(50) not null,
    sal number(10,1) default 0 not null
);
-- primary key 추가(add constraint)
alter table sawon8 add constraint sawon8_no_pk primary key(no);
-- primary key 제거(drop constraint)
alter table sawon8 drop constraint sawon8_no_pk;


/**************************************
primary key가 복합 키인 경우
    - 컬럼 여러개가 primary key인 경우
**************************************/
drop table student_locker;
create table student_locker(
    ban number(2),
    locker_no number(2),
    name varchar2(20),
    constraint student_locker_pk primary key(ban, locker_no)
);

insert into student_locker values(1,1,'KIM');
insert into student_locker values(1,2,'JIM');
insert into student_locker values(1,3,'LIM');

insert into student_locker values(2,1,'MIN');
insert into student_locker values(2,2,'NIM');
insert into student_locker values(2,3,'OIM');

insert into student_locker values(3,1,'SIM');
insert into student_locker values(3,2,'AIM');
insert into student_locker values(3,3,'XIM');
select * from student_locker;
commit;

insert into student_locker values(1,1,'CIM');
--ORA-00001: unique constraint (SCOTT.STUDENT_LOCKER_PK) violated

insert into student_locker values(1,null,'YIM');
--ORA-01400: cannot insert NULL into ("SCOTT"."STUDENT_LOCKER"."LOCKER_NO")

insert into student_locker values(null,3,'YIM');
--ORA-01400: cannot insert NULL into ("SCOTT"."STUDENT_LOCKER"."BAN")

select * from student_locker where ban=1 and locker_no = 1;
select * from student_locker where ban=1 and locker_no = 2;

select * from student_locker where ban=1;
select * from student_locker where locker_no=1;

/********************************************************
4.foreign key(외래키)
    parent table(dept) :부모테이블,참조되는테이블
    child  table(emp)  :자식테이블,참조하는테이블(foreign key column)
    
    - null허용
    - 중복허용
*********************************************************/

/***********case1 컬럼레벨***************/
--parent table
drop table dept2;
create table dept2(
    deptno number(4) primary key,
    dname varchar2(30) not null,
    loc varchar2(100)
);
insert into dept2 values(10,'인사','서울');
insert into dept2 values(20,'생산','울산');
insert into dept2 values(30,'영업','대구');
insert into dept2 values(40,'홍보','청주');

--child  table(FK)
drop table emp2;
create table emp2(
    empno number(4) primary key,
    ename varchar2(50),
    sal number(10),
    deptno number(4) constraint emp2_deptno_fk references dept2(deptno)
);
insert into emp2 values(1111,'KIM',3000,10);
insert into emp2 values(2222,'LIM',4500,10);
insert into emp2 values(3333,'MIM',6000,10);

insert into emp2 values(4444,'NIM',1200,20);
insert into emp2 values(5555,'OIM',6700,20);

insert into emp2 values(6666,'PIM',2300,30);
insert into emp2 values(7777,'QIM',9900,30);

insert into emp2 values(8888,'RIM',1000,null);
insert into emp2 values(9999,'SIM',2000,null);
select * from emp2;

--select * from emp2  join dept2 on emp2.deptno=dept2.deptno;

insert into emp2 values(1000,'TEN',8000,90);
--ORA-02291: integrity constraint (SCOTT.EMP2_DEPTNO_FK) violated - parent key not found
--deptno 10 --> 40
update emp2 set deptno=40 where empno=1111;

--deptno 40 --> 90
update emp2 set deptno=90 where empno=1111;
--ORA-02291: integrity constraint (SCOTT.EMP2_DEPTNO_FK) violated - parent key not found

/***********case2 테이블레벨***************/
--parent table
drop table dept3;
create table dept3(
    deptno number(4) primary key,
    dname varchar2(30) not null,
    loc varchar2(100)
);
insert into dept3 values(10,'인사','서울');
insert into dept3 values(20,'생산','울산');
insert into dept3 values(30,'영업','대구');
insert into dept3 values(40,'홍보','청주');

select * from dept3;
--참조되지않는부서 40은 삭제가능
delete from dept3 where deptno=40;
--참조되는부서 30은 삭제불가능
delete from dept3 where deptno=30;
--RA-02292: integrity constraint (SCOTT.EMP3_DEPTNO_FK) violated - child record found

--child table(FK)
drop table emp3;
create table emp3(
    empno number(4) primary key,
    ename varchar2(50),
    sal number(10),
    deptno number(4),
    constraint emp3_deptno_fk foreign key(deptno) references dept3(deptno)
);  

insert into emp3 values(1111,'KIM',3000,10);
insert into emp3 values(2222,'LIM',4500,10);
insert into emp3 values(3333,'MIM',6000,10);

insert into emp3 values(4444,'NIM',1200,20);
insert into emp3 values(5555,'OIM',6700,20);

insert into emp3 values(6666,'PIM',2300,30);
insert into emp3 values(7777,'QIM',9900,30);

insert into emp3 values(8888,'RIM',1000,null);
insert into emp3 values(9999,'SIM',2000,null);

select * from emp3;

/**********************************************************************************************************************
FOREIGN KEY OPTION
  1. NO ACTION	       : 부모 테이블(dept)의 행을 참조하는 자식 테이블(emp)의 행이존재하면 부보테이블행을 삭제불가능하다.
  2. ON DELETE CASCADE : 부모 테이블(dept)의 행이 삭제되면 자식 테이블(emp)의 관련 행도 삭제된다. 
  3. ON DELETE SET NULL: 부모 테이블(dept)의 행이 삭제되면 자식 테이블(emp)의 관련 행의 속성(deptno)값을 NULL로 변경한다.
**********************************************************************************************************************/

--1.foreign key option(on delete cascade)
--parent table
drop table dept4;
create table dept4(
    deptno number(4) primary key,
    dname varchar2(30) not null,
    loc varchar2(100)
);
insert into dept4 values(10,'인사','서울');
insert into dept4 values(20,'생산','울산');
insert into dept4 values(30,'영업','대구');
insert into dept4 values(40,'홍보','청주');

--child table(FK)
drop table emp4;
create table emp4(
    empno number(4) primary key,
    ename varchar2(50),
    sal number(10),
    deptno number(4),
    constraint emp4_deptno_fk foreign key(deptno) references dept4(deptno) on delete cascade
);  

insert into emp4 values(1111,'KIM',3000,10);
insert into emp4 values(2222,'LIM',4500,10);
insert into emp4 values(3333,'MIM',6000,10);
insert into emp4 values(4444,'NIM',1200,20);
insert into emp4 values(5555,'OIM',6700,20);
insert into emp4 values(6666,'PIM',2300,30);
insert into emp4 values(7777,'QIM',9900,30);
insert into emp4 values(8888,'RIM',1000,null);
insert into emp4 values(9999,'SIM',2000,null);

select * from dept4;
select * from emp4;

--부서 10번 삭제 시 소속된 사원도 모두 삭제
delete dept4 where deptno = 10;
delete dept4 where deptno = 20;
delete dept4 where deptno = 30;

--2.foreign key option(on delete set null)
drop table dept5;
create table dept5(
    deptno number(4) primary key,
    dname varchar2(30) not null,
    loc varchar2(100)
);
insert into dept5 values(10,'인사','서울');
insert into dept5 values(20,'생산','울산');
insert into dept5 values(30,'영업','대구');
insert into dept5 values(40,'홍보','청주');

--child table(FK)
drop table emp5;
create table emp5(
    empno number(4) primary key,
    ename varchar2(50),
    sal number(10),
    deptno number(4),
    constraint emp5_deptno_fk foreign key(deptno) references dept5(deptno) on delete set null
);  

insert into emp5 values(1111,'KIM',3000,10);
insert into emp5 values(2222,'LIM',4500,10);
insert into emp5 values(3333,'MIM',6000,10);

insert into emp5 values(4444,'NIM',1200,20);
insert into emp5 values(5555,'OIM',6700,20);

insert into emp5 values(6666,'PIM',2300,30);
insert into emp5 values(7777,'QIM',9900,30);

insert into emp5 values(8888,'RIM',1000,null);
insert into emp5 values(9999,'SIM',2000,null);

select * from dept5;
select * from emp5;

--부서 삭제 시 소속된 사원의 부서를 set null
delete dept5 where deptno = 10;
delete dept5 where deptno = 20;
delete dept5 where deptno = 30;

/****************테이블 생성 이후에 foreign key 추가, 제거***************/
drop table dept6;
create table dept6(
    deptno number(4),
    dname varchar2(30),
    loc varchar2(100)
);
drop table emp6;
create table emp6(
    empno number(4),
    ename varchar2(50),
    sal number(10),
    deptno number(4)
);

--pk 설정
alter table dept6 add constraint dept6_deptno_pk primary key(deptno);
--not null설정
alter table dept6 modify dname not null;

--pk설정
alter table emp6 add constraint emp6_empno_pk primary key(empno);
--not null
alter table emp6 modify ename not null;
--foreign key 설정
alter table emp6 add constraint emp6_deptno_fk foreign key(deptno) references dept6(deptno);

/**************************
5. check constraint
**************************/
drop table emp7;
create table emp7(
    empno number(4) primary key,
    ename varchar2(50) not null,
    sal number(10),
    gender char(1) default 'f',
    constraint emp7_sal_ck check(sal>=500 and sal<=1000),
    constraint emp7_gender_ck check(gender = 'm' or gender = 'f')
);

select * from emp7;
insert into emp7 values(1, 'KIM', 800, 'f');
insert into emp7 values(2, 'FIM', 1000, 'm');

insert into emp7 values(3, 'CIM', 2000, 'm');
--ORA-02290: check constraint (SCOTT.EMP7_SAL_CK) violated

insert into emp7 values(4, 'AIM', 1000, 's');
--ORA-02290: check constraint (SCOTT.EMP7_GENDER_CK) violated

/*
 - drop : 테이블을 삭제하는 명령어(복구 할 수 없다)
*/
create table emp8(
    empno number(4) primary key,
    ename varchar2(50) not null,
    sal number(10),
    gender char(1) default 'f'
);
drop table emp8;

















