CREATE TABLE EX2_1(
    col1 CHAR(10)
    ,col2 VARCHAR2(10)
    --하나의 컬럼에는 하나의 타입과 사이즈를 가짐
    );
    
    INSERT INTO ex2_1(coll, col2)
    VALUES('abc','abc');
    
    SELECT coll
        ,LENGTH(coll)
        ,col2
        ,LENGTH(col2)
        
    from ex2_1;
    
    
select *
from employees;

select emp_name 
        , email
from employees;

select emp_name as nm
    ,hire_date hd
    ,salary 봉급
    , department_id "부서 아이디"
from employees;

select emp_name
    ,salary
    ,department_id
from employees;
WHENEVER salary >=12000
ORDER BY department_id DESC;

select emp_name
    ,salary
from employees;
ORDER BY 2 DESC, 1 DESC;

select emp_name
    ,salary
from employees;
order by hire_date;

select employee_id  as 직원아이디
    ,emp_name   as 직원이름
    ,salary / 30 as 일당
    ,salary     as 월급
    ,salary - salary *0.1 as 실수령액
    ,salary *12 as연봉
from employees;

select * from employees where salary = 2600;
select * from employees where salary <> 2600;
select * from employees where salary != 2600;
select * from employees where salary < 2600;
select * from employees where salary > 2600;
select * from employees where salary <= 2600;
select * from employees where salary >= 2600;

select * from departments where department_id =30 or department_id =60;

select prod_name,prod_category,prod_min_price 
from products 
where prod_min_price >=30 and prod_min_price<50 
order by prod_category , prod_min_price desc;

select cust_name, cust_gender, case when cust_gender = 'M' THEN '남자' when cust_gender = 'f' THEN '여자'  else '??' END AS gender
from customers;

select employee_id,emp_name,
case when salary <=5000 then 'C등급' when salary > 5000 and salary <=15000 then 'B등급' else 'A등급' 
end as grade
from employees;

select employee_id
    ,salary
    from employees
    where salary between 2000 and 2500;
    
select employee_id, salary, department_id
from employees
where department_id in(90,80,10);

select emp_name || ':' || employee_id as 이름사번
from employees;

select emp_name
from employees
where emp_name like 'A%';

select emp_name
from employees
where emp_name like '%na%';

select emp_name
from employees
where department_id = :a
or department_id = :b;

select emp_name
from employees
where emp_name like '%'||:val||'%';

create table ex2_2(
nm varchar2(20)
);
insert into ex2_2 values('길동');
insert into ex2_2 values('홍길동');
insert into ex2_2 values('길동홍');
insert into ex2_2 values('홍길동상');

select *
from ex2_2
where nm like '홍길_';
CREATE TABLE students (

stu_id VARCHAR2(12) /* 학번 */
, stu_grade NUMBER(1)/* 학년 */
, stu_semester NUMBER(1) /* 학기 */
, stu_name VARCHAR2(10) /* 학생 이름 */
, stu_birth VARCHAR2(10) /* 학생 생년월일 */
, stu_kor NUMBER(3) /* 국어 점수 */
, stu_eng NUMBER(3) /* 영어 점수 */
, stu_math NUMBER(3) /* 수학 점수 */
, CONSTRAINTS stu_pk PRIMARY KEY (stu_id, stu_grade, stu_semester)
);

select *
from students
where stu_name like '김__'and stu_grade =1;

select stu_name, stu_grade, (stu_kor + stu_eng +stu_math)/3 as subject_avg
from students
where stu_grade =1
and (stu_kor + stu_eng +stu_math)/3 >= 90;

select cust_name, cust_gender,cust_year_of_birth,cust_marital_status,cust_street_address
from customers
where cust_city = 'Los Angeles' and cust_marital_status = 'single' and cust_gender ='F' and cust_year_of_birth >=1983
order by cust_year_of_birth desc, cust_name;




 

