--DDL(Data Definition Language)
create table dept(
            deptno number(2),
            dname varchar2(50),
            loc varchar2(50)
);
--ORA-00955: name is already used by an existing object

create table dept2(
            deptno number(2),
            dname varchar2(50),
            loc varchar2(50)
);

insert into dept2 values(10, '개발팀', '서울');
insert into dept3 values(10, '기획팀', '부산');

--default
create table def_table1(
    num number(2) default null,
    writer varchar2(50) default null,
    write_day date default null
);
select * from def_table1;
insert into def_table1(num, writer, write_day) values(1, '강수지', sysdate);
insert into def_table1(num) values(2); --num 제외 null 삽입됌
insert into def_table1(writer)values('김수지'); --WRITER 제외 null 삽입됌

create table def_table2(
    num number(2),
    writer varchar2(50),
    write_day date
); --def_table1과 결과는 같음

create table def_table3(
    num number(2) default 0,
    writer varchar2(50) default 'guest',
    write_day date default sysdate
);

select * from def_table3;
insert into def_table3(num, writer, write_day) values(1, '김수한', to_date('2022/01/01', 'YYYY/MM/DD'));
insert into def_table3(num, writer, write_day) values(2, '김수미', sysdate);
insert into def_table3(num, writer, write_day) values(3, '김수양', sysdate-1);

insert into def_table3(num, writer) values(4, '김수우');
insert into def_table3(num, writer) values(5, '김수가');
insert into def_table3(num, writer) values(6, '김수나');

insert into def_table3(num) values(7);
insert into def_table3(num) values(8);
insert into def_table3(num) values(9);

drop table def_board;
create table def_board(
    no number(5),
    title varchar2(100),
    content varchar2(255),
    write_day date default sysdate,
    read_count number(5) default 0,
    is_secret varchar2(1) default 'F',
    write_user varchar2(30) default 'guest'
);

select * from def_board;

insert into def_board(no, title, content) values(1, '오늘은 월요일', '기뻐요');
insert into def_board(no, title, content) values(2, '오늘은 화요일', '많이 기뻐요');
insert into def_board(no, title, content) values(3, '오늘은 수요일', '아주 많이 기뻐요');
insert into def_board(no, title, content, write_day, read_count, is_secret, write_user)
                        values(4, '오늘은 목요일', '여전히 기뻐요', sysdate, 999, 'T', 'guard');
insert into def_board values(5, '오늘은 금요일', '완전 기뻐요', sysdate, 1, 'F', 'egg'); 
commit;

--column
drop table dae_type;--삭제

create table data_type(
        no number(4,0),
        name varchar2(20),
        gender char(1) default 'M',
        height number(5,2),
        weight number(4,1)      
);

desc data_type;
select * from data_type;

insert into data_type values(1234, '김경호', 'M', 185.32, 75.3);
insert into data_type values(1234.8989, '김경호', 'M', 185.328989778, 75.88888888);
--소숫점 이하 자리수는 반올림 후 삽입

insert into data_type values(12345, '김경수', 'M', 1854.32, 75.8);
--[number 값이 넘치는 경우] ORA-01438: value larger than specified precision allowed for this colum

insert into data_type values(3456, '김수한무거북이', 'F', 178.32, 75.8);
--[varchar2 값이 넘치는 경우] ORA-12899: value too large for column "SCOTT"."DATA_TYPE"."NAME" (actual: 21, maximum: 20)

insert into data_type values(7790, '김수한', 'Female', 178.32, 75.8);
--[char 값이 넘치는 경우] ORA-12899: value too large for column "SCOTT"."DATA_TYPE"."GENDER" (actual: 6, maximum: 1)

--date, timestamp

create table date_time(
    day1 date, 
    dat2 timestamp(6),
    day3 timestamp(9)
);
desc date_time;

select  to_char(day1,'YYYY/MM/DD HH24:MI:SS'),
        to_char(day2,'YYYY/MM/DD HH24:MI:SS.FF6'),
        to_char(day3,'YYYY/MM/DD HH24:MI:SS.FF9')  from date_time;

insert into date_time values(sysdate,systimestamp,systimestamp);

insert into date_time values(to_date('1998/12/01 05:30:45','YYYY/MM/DD HH24:MI:SS'),
                            to_timestamp('2020/05/04 03:25:45.123456','YYYY/MM/DD HH24:MI:SS.FF6'),
                            to_timestamp('2021/01/12 00:45:12.123456789','YYYY/MM/DD HH24:MI:SS.FF9'));

--서브쿼리 이용한 테이블 생성(CATS : Create table As Select)
create table depta
as
select deptno, dname from dept;

create table deptb
as
select deptno, dname, loc from dept;

create table deptc(no, name)
as
select deptno, dname from dept;

--table만 생성
create table deptd
as
select * from dept where 1=2;

--table만 생성
create table empa
as
select * from emp where 1=2;

--다른테이블로부터 데이터 입fur(ITAS : Insert Table as Select)
insert into empa
select * from emp;






