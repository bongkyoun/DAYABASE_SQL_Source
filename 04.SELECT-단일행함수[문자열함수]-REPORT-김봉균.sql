/*
1. Student 테이블에서 jumin 컬럼을 이용해서 1전공이
   101번인 학생들의이름과 태어난월일,생일을 출력하시요
*/
--결과 1
select name, substr(jumin, 3, 4) "Birthday" from student where deptno1=101;
--결과 2
select name, substr(jumin, 3 ,2)||'월'||substr(jumin, 4, 2)||'일' "Birthday" from student where deptno1=101;
/*
2. Student 테이블을 참조해서  1전공이(deptno1 컬럼) 
   201번인 학생의이름과 전화번호와 지역번호를 출력하세요
   단 지역번호는 숫자만나오게하세요
 */
 select name, tel, substr(tel, 1, instr(tel, ')')-1) "AREA CODE" from student where deptno1 like '201';
/*
3. Student 테이블에서 학생들의 이름과
   주민등록번호를 아래와같이 출력하세요.
*/
--결과 1
select name, jumin, replace(jumin, substr(jumin, 7, 13),'*******')"REPLACE" from student;
--결과 2
select name, jumin, replace(jumin, substr(jumin, 7, 13),'-*******')"REPLACE" from student;
/*
4.Student 테이블에서  학생들의 이름과
  전화번호와 전화번호에서 지역번호와 국번을 제외한 나머지
  번호를 * 로 표시해서 출력하세요
  */
select name, tel, replace(tel, substr(tel, instr(tel, '-')+1), '****') "REPLACE" from student;