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










