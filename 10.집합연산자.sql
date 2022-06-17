/*drop table A;
drop table B;

create table A(val char);
create table B(num number,val char);

insert into A values('A');
insert into A values('B');
insert into A values('C');
insert into A values('D');
insert into A values('E');

insert into B values(1,'C');
insert into B values(2,'D');
insert into B values(3,'E');
insert into B values(4,'F');
insert into B values(5,'G');
commit;
*/

--집합연산자
select val from a;
select val from b;

--union 합집합(중복제거)
select val from a
union all
select val from b;

--intersect 교집합(중복제거)
select val from a
intersect
select val from b;

--minus 차집합
select val from a
minus
select val from b;