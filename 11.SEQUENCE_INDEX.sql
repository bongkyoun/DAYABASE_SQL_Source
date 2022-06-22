--sequence
drop sequence test_seq1;
create sequence test_seq1;

drop sequence test_seq2;
create sequence test_seq2
        start with 1
        maxvalue 9999999
        increment by 1
        nocycle
        nocache;

-- sequence 값 생성 - test_seq1.nextval
select test_seq1.nextval "발생 시퀀스 값" from dual;
select test_seq1.currval "현재 시퀀스 값" from dual;

select test_seq1.nextval "발생 시퀀스", test_seq1.currval "현재 시퀀스 값"from dual;
select test_seq1.currval "현재 시퀀스 값", test_seq1.nextval "발생 시퀀스"from dual;

/*
시퀀스 생성 이후 nextval을 한번도 호출하지 않았다면 currval을 사용할 수 없다
*/
select test_seq2.nextval from dual;
select test_seq2.currval from dual;

drop table freeboard;
create table freeboard(
    board_no number(10) primary key,
    board_title varchar2(512),
    board_content varchar2(2000),
    board_wday date default sysdate,
    board_read_count number(5) default 0
);
    
drop sequence freeboard_no_seq;
create sequence freeboard_no_seq;

insert into freeboard(board_no,board_title,board_content) 
            values(freeboard_no_seq.nextval,'제목'||freeboard_no_seq.currval,'내용'||freeboard_no_seq.currval);
            
select * from freeboard; 

drop table jumun;
create table jumun(
    j_code varchar2(20) primary key,
    j_title varchar2(100), 
    j_price number(10),
    j_date date default sysdate
);

drop sequence jumun_code_seq;
create sequence jumun_code_seq;

insert into jumun(j_code, j_title, j_price)
            values(to_char(sysdate, 'YYYY-MM-DD-')||lpad(to_char(jumun_code_seq.nextval), 4, '0'),
            '아이패드 외 3종...',
            890000);

select * from jumun;

--index

drop index emp_name_idx;
create index emp_name_idx on emp(ename);






























