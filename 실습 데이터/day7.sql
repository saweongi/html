SELECT *
FROM employees;

SELECT *
FROM departments;

-- inner join ��������(���������̶�� ��)
-- �� �÷��� ������ ���� ������ ����
SELECT employees.emp_name, departments.department_name
FROM employees, departments
where employees.department_id = departments.department_id;

--���̺� ��Ī
SELECT emp_name, b.department_name -- ������ʿ��� �ִ� �÷��� ��Ī �Ƚᵵ��(���̺��߿� �ϳ��� �������� �׳� ���� �ְ� ���̺��߿� �Ѵ� ������ ��Ī������� �������ȳ���)
FROM employees a, departments b    -- as�Ⱦ���  ����� �ؼ� ��Ī�� �Ѵ�
where a.department_id = b.department_id;


SELECT *
FROM member;
SELECT *
FROM cart;
--member �����뾾�� īƮ(�����̷�)�̷��� ����Ͻÿ�
SELECT mem_name,cart_no,cart_prod,cart_qty
FROM member a,cart b
WHERE a.mem_id = b.cart_member and  a.mem_name ='������';

/*ANSI JOIN : American National Standards Institute
              �̱� ǥ�� SQL ���� ���� (������ �� �ǹ����� �߾Ⱦ�)
              ���� ���� �ڵ��ε� �̱� ǥ�� ���� �ٲ۰���
*/
SELECT member.mem_name
    ,cart.cart_no
    ,cart.cart_prod
    ,cart.cart_qty
FROM member
INNER JOIN cart
ON(member.mem_id = cart.cart_member)
WHERE member.mem_name = '������';

--��ǰ ���� ���
select*
from cart;

select*
from prod;

SELECT mem_name,cart_no,cart_prod,cart_qty,prod.prod_name,prod.prod_sale
FROM member a,cart b,prod
WHERE a.mem_id = b.cart_member 
and b.cart_prod = prod.prod_id 
and a.mem_name ='������'; 

-- �����뾾�� ������ ��ü ��ǰ�� �հ� �ݾ���?  �׷���̸� ���� �� �׷����� �ɰ��� ����Ʈ�� �׷���̿� ǥ���Ǿ���ϰ� ǥ���ϰ�������� �ϳ��� ������ ����Ѵ�.
SELECT mem_name,mem_id,sum(prod.prod_sale * b.cart_qty) as �հ�ݾ�
FROM member a,cart b,prod
WHERE a.mem_id = b.cart_member 
and b.cart_prod = prod.prod_id 
and a.mem_name ='������'
group by mem_name, mem_id;

-- ������ ǥ����(ansi join ǥ����)
SELECT mem_name,mem_id,sum(prod.prod_sale * cart.cart_qty) as �հ�ݾ�
FROM member INNER JOIN cart
ON(member.mem_id = cart.cart_member)
INNER JOIN prod
ON (cart.cart_prod = prod.prod_id)
WHERE member.mem_name ='������'
GROUP BY member.mem_name, member.mem_id;

--employees, jobs ���̺��� Ȱ���Ͽ�
-- salary�� 15000 �̻��� ������ ���, �̸�, salary, ���� ���̵� ,�������� ����Ͻÿ�
SELECT *
FROM employees;

select *
FROM JOBS;

select  employees.employee_id
        ,employees.emp_name
        ,employees.salary
        ,employees.job_id
        ,jobs.job_title
from employees ,jobs 
where employees.job_id = jobs.job_id
    and employees.salary >=15000;
    
/* �������� (���� �ȿ� ����)
  1.��Į�� �������� (select ��)
  2.�ζ��� �� (from��)
  3.��ø ���� (where��)
*/
-- ��Į�� ���������� ������ ��ȯ(1�� 1 ���� �ɶ��� ���)
-- ���� �ڵ尪�� �̸��� �����ö� ���� ���
-- ���������� ���� �������̺��� �� �Ǽ� ��ŭ ���������� ��ȸ�ϱ� ������
-- ���������� ���̺��� �Ǽ��� ������ �ڿ��� ���� ����ϰԵ�.
-- (���� ���� ��� ������ �̿��ϴ°� �� ����)
SELECT a.emp_name
    , (SELECT department_name
        FROM departments
        where department_id = a.department_id)  as dep_name
    ,a.job_id
    ,(SELECT job_title
     FROM jobs
     WHERE job_id = a.job_id) as job_name
FROM employees a;

--��ø���� ����
--��ü ������ ���� ��� ���� ������ ū ������ ����Ͻÿ�
--���������� ��� ������ ���ؼ� �װ��� ����ϱ� ���ؼ� �Ʒ��� ��հ��� ���ؼ� �װ���������(Ư������ ã�Ƽ� �װ��� ���� ����Ѵ�)
--�������� ���� �������������
SELECT emp_name
    , salary
    FROM employees
where salary >=(select AVG(salary)
                FROM employees);
                

--���ÿ� 2���̻��� �÷� ���� ���� �� ��ȸ
select employee_id, emp_name, job_id
FROM employees
where (employee_id, job_id) in (select employee_id, job_id
                                from job_history);
                                
SELECT *
FROM member;

SELECT cart_member
FROM cart;

-- cart��� �̷��� ���� ȸ���� ��ȸ�Ͻÿ�
SELECT *
FROM member
WHERE mem_id NOT IN(SELECT cart_member
                    from cart);
                    
-- member �߿��� ��ü ȸ���� ���ϸ��� ��հ� �̻��� ȸ���� ��ȸ�Ͻÿ�
SELECT mem_name,mem_job,mem_mileage
FROM member
where mem_mileage >= (select avg(mem_mileage)
                    from member)
order by mem_mileage desc;

CREATE TABLE ���ǳ��� (
     ���ǳ�����ȣ NUMBER(3)
    ,������ȣ NUMBER(3)
    ,�����ȣ NUMBER(3)
    ,���ǽ� VARCHAR2(10)
    ,����  NUMBER(3)
    ,�����ο� NUMBER(5)
    ,��� date
);

CREATE TABLE ���� (
     �����ȣ NUMBER(3)
    ,�����̸� VARCHAR2(50)
    ,���� NUMBER(3)
);

CREATE TABLE ���� (
     ������ȣ NUMBER(3)
    ,�����̸� VARCHAR2(20)
    ,���� VARCHAR2(50)
    ,���� VARCHAR2(50)
    ,�ּ� VARCHAR2(100)
);

CREATE TABLE �������� (
    ����������ȣ NUMBER(3)
    ,�й� NUMBER(10)
    ,�����ȣ NUMBER(3)
    ,���ǽ� VARCHAR2(10)
    ,���� NUMBER(3)
    ,������� VARCHAR(10)
    ,��� DATE 
);

CREATE TABLE �л� (
     �й� NUMBER(10)
    ,�̸� VARCHAR2(50)
    ,�ּ� VARCHAR2(100)
    ,���� VARCHAR2(50)
    ,������ VARCHAR2(500)
    ,������� DATE
    ,�б� NUMBER(3)
    ,���� NUMBER
);


COMMIT;

ALTER TABLE �л� ADD CONSTRAINT pk_�л� PRIMARY KEY(�й�);
ALTER TABLE �������� ADD CONSTRAINT pk_�������� PRIMARY KEY(����������ȣ);
ALTER TABLE ���� ADD CONSTRAINT pk_���� PRIMARY KEY(�����ȣ);
ALTER TABLE ���� ADD CONSTRAINT pk_���� PRIMARY KEY(������ȣ);
ALTER TABLE ���ǳ��� ADD CONSTRAINT pk_���ǳ��� PRIMARY KEY(���ǳ�����ȣ);


ALTER TABLE �������� ADD CONSTRAINT FK_�л�_�й� FOREIGN KEY(�й�) REFERENCES �л�(�й�);
ALTER TABLE �������� ADD CONSTRAINT FK_����_�����ȣ FOREIGN KEY(�����ȣ) REFERENCES ����(�����ȣ);
ALTER TABLE ���ǳ��� ADD CONSTRAINT FK_����_������ȣ FOREIGN KEY(������ȣ) REFERENCES ����(������ȣ);
ALTER TABLE ���ǳ��� ADD CONSTRAINT FK_����_���ǰ����ȣ FOREIGN KEY(�����ȣ) REFERENCES ����(�����ȣ);
 






