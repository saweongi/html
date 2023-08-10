/* TABLE ���� ALTER
*/

CREATE TABLE ex4_1(
    irum VARCHAR2(100) NOT NULL
    ,point NUMBER(5)
    ,gender CHAR(1)
    ,reg_date DATE
);
DESC ex4_1;

-- �÷��� ����
alter table ex4_1 rename column irum TO nm;

--Ÿ�Լ���(Ÿ�� ������ ���̺� �����Ͱ� �ִٸ� �����ؾ���)
ALTER TABLE ex4_1 MODIFY point NUMBER(10)

--���� ���� �߰�
ALTER TABLE ex4_1 ADD CONSTRAINT pk_ex4 PRIMARY KEY(nm);

--�÷� �߰�
ALTER TABLE ex4_1 ADD hp VARCHAR2(20);

--�÷� ����
ALTER TABLE ex4_1 DROP COLUMN hp;

---------------------- ���̺� comment
COMMENT ON TABLE tb_info IS '�츮��';
COMMENT ON COLUMN tb_info.info_no IS '�⼮��ȣ';
COMMENT ON COLUMN tb_info.pc_no IS '��ǻ�͹�ȣ';
COMMENT ON COLUMN tb_info.nm IS '�̸�';
COMMENT ON COLUMN tb_info.email IS '�̸���';
COMMENT ON COLUMN tb_info.hobby IS '���';
COMMENT ON COLUMN tb_info.mbti IS '�긯��';
select *
from all_tab_comments  --���̺� �ڸ�Ʈ
WHERE OWNER ='JAVA';

SELECT *
FROM all_col_comments  --���̺� �÷� �ڸ�Ʈ
WHERE comments LIKE '%�̸�%';

/* INSERT ������ ���� (DML��)

*/
CREATE TABLE ex4_2(
    val1 VARCHAR2(1)
    ,val2 NUMBER
    ,VAL3 DATE
);

--�Է� �÷��� �� �ۼ�
INSERT INTO ex4_2 (vall, val2, val3)
VALUES ('hi', 10, SYSDATE);  --���ڿ� ''   NUMBERŸ���� ����
INSERT INTO ex4_2(val3, val2)
VALUES (SYSDATE,10);      -- ���� �ۼ��� �÷� �������
                          -- value�� INSERT
SELECT * FROM ex4_2;
--���̺� ��ü�� ���� �����͸� �����Ҷ��� �÷��� �Ƚᵵ��

INSERT INTO ex4_2
VALUES ('hello', 20, SYSDATE);
INSERT INTO ex4_2
VALUES ('hello', 20, SYSDATE);
INSERT INTO ex4_2
VALUES (20, SYSDATE);  --����

create table ex4_3(
emp_id number
,emp_name varchar2(1000)
);

-- SELECT - INSERT
INSERT INTO ex4_3(emp_id, emp_name)
SELECT employee_id
    , emp_name
FROM employees
WHERE salary > 5000;

select * from ex4_3;

--���̺� ����
create table ex4_4 as
select nm, email
from tb_info;
select *
from ex4_4;

// update ������ ����

select *
from tb_info;
update tb_info
set hobby = '����'
    ,email = 'abc@mail.com'
WHERE INFO_NO =1;



delete ex4_4;  --��ü����

delete ex4_4
where nm ='���ؼ�';

-- �ߺ����� ������ ����
select distinct prod_category
from products;

-- �ǻ��÷� (���̺��� ������ �ִ°� ó�� ���) ,����Ŭ���� ����
select  rownum ,emp_name
    ,email
from employees
where rownum <=10;  // ������ Ư�� ������ ���� =5 �̷���
-- NULL (IS NULL or IS NOT NULL)
select *
from employees
where manager_id IS NULL;

select *
from departments
where department_id IN (30,60);
select *
from departments
where department_id not IN (30,60);

/*
oracle �����ͺ��̽� �����Լ�
���ڰ��� 
*/
select lower('I like mac') as lowers
    , UPPER('I like mac') as uppers
    , INITCAP('I like mac') as initcaps --�ܾ� ù���� �빮��
from dual;  --�ӽ����̺�

select *
from employees
where upper(emp_name) like '%' || upper ('Donald') ||'%';

-- substr (char, pos, len) ����ڿ� char�� pos ��°����
-- len ���� ��ŭ �ڸ��� ��ȯ
-- pos ������ 0 �̿��� ����Ʈ �� 1 �� ù��° ���ڿ�
-- ������ ���� ���ڿ��� �� ������ ������ ����� ��ġ
-- len ���� �����Ǹ� pos ��° ���ں��� ������ ��� ���ڸ� ��ȯ
select substr('ABCD EFG',1, 4)
    , substr('ABCD EFG',-3, 3)
    , substr('ABCD EFG',-3, 1)
    , substr('ABCD EFG',5)
from dual;

/* INSTR ��� ���ڿ����� ã�� ���ڿ��� ��ġ */
select instr('���� ���� �ܷο� ����, ���� ���� ���ο� ����', '����') --����Ʈ 1,1
        ,instr('���� ���� �ܷο� ����, ���� ���� ���ο� ����', '����',5)
        ,instr('���� ���� �ܷο� ����, ���� ���� ���ο� ����', '����',1,2)
        ,instr('���� ���� �ܷο� ����, ���� ���� ���ο� ����', '��') --������ 0����
from dual;

--���� �̸��� �ּ��� �̸��� �������� �и��Ͽ� ����Ͻÿ�
-- ex leeapgil@gmail.com -> id : leeapgil, domain:gmail.com
select cust_name
    , cust_email
from customers;

select  substr(cust_email,1,instr(cust_email,'@')-1)
    ,substr(cust_email,instr(cust_email,'@')+1)
from customers;


select nm
 ,MBTI
from tb_info;




