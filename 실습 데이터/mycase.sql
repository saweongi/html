CREATE TABLE EX2_1(
    col1 CHAR(10)
    ,col2 VARCHAR2(10)
    --�ϳ��� �÷����� �ϳ��� Ÿ�԰� ����� ����
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
    ,salary ����
    , department_id "�μ� ���̵�"
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

select employee_id  as �������̵�
    ,emp_name   as �����̸�
    ,salary / 30 as �ϴ�
    ,salary     as ����
    ,salary - salary *0.1 as �Ǽ��ɾ�
    ,salary *12 as����
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

select cust_name, cust_gender, case when cust_gender = 'M' THEN '����' when cust_gender = 'f' THEN '����'  else '??' END AS gender
from customers;

select employee_id,emp_name,
case when salary <=5000 then 'C���' when salary > 5000 and salary <=15000 then 'B���' else 'A���' 
end as grade
from employees;

select employee_id
    ,salary
    from employees
    where salary between 2000 and 2500;
    
select employee_id, salary, department_id
from employees
where department_id in(90,80,10);

select emp_name || ':' || employee_id as �̸����
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
insert into ex2_2 values('�浿');
insert into ex2_2 values('ȫ�浿');
insert into ex2_2 values('�浿ȫ');
insert into ex2_2 values('ȫ�浿��');

select *
from ex2_2
where nm like 'ȫ��_';
CREATE TABLE students (

stu_id VARCHAR2(12) /* �й� */
, stu_grade NUMBER(1)/* �г� */
, stu_semester NUMBER(1) /* �б� */
, stu_name VARCHAR2(10) /* �л� �̸� */
, stu_birth VARCHAR2(10) /* �л� ������� */
, stu_kor NUMBER(3) /* ���� ���� */
, stu_eng NUMBER(3) /* ���� ���� */
, stu_math NUMBER(3) /* ���� ���� */
, CONSTRAINTS stu_pk PRIMARY KEY (stu_id, stu_grade, stu_semester)
);

select *
from students
where stu_name like '��__'and stu_grade =1;

select stu_name, stu_grade, (stu_kor + stu_eng +stu_math)/3 as subject_avg
from students
where stu_grade =1
and (stu_kor + stu_eng +stu_math)/3 >= 90;

select cust_name, cust_gender,cust_year_of_birth,cust_marital_status,cust_street_address
from customers
where cust_city = 'Los Angeles' and cust_marital_status = 'single' and cust_gender ='F' and cust_year_of_birth >=1983
order by cust_year_of_birth desc, cust_name;




 

