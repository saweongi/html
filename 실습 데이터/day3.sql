/*
 ���� Ÿ��(number)
 number(p, s) p�� �Ҽ����� �������� ��� ��ȿ���� �ڸ����� �ǹ���.
              s�� �Ҽ��� �ڸ����� �ǹ���. (s�� ����Ʈ 0)
              s�� 2�̸� �Ҽ��� 2�ڸ� ���� �ݿø�.
              s�� ���� �̸� �Ҽ��� ���� ���� �ڸ�����ŭ �ݿø�
*/

-- ���̺� ����
drop table ex3_1;

--���̺� �⺻ �Ӽ����� ��ȸ(�÷���,Ÿ��,������)
desc ex3_1;
create table ex3_1(
    num1 number(3),    --����3�ڸ�
    num2 number(3,2),  -- ��ü ���� 1�ڸ� �Ҽ��� 2�ڸ�
    num3 number(5,-2),   -- ���� �ڸ����� �ݿø� �� (7�ڸ�)
    num4 number
);

insert into ex3_1 (num1) values(0.7898);
insert into ex3_1 (num1) values(99.5);
insert into ex3_1 (num1) values(1004);    --����

select *
from ex3_1;
insert into ex3_1 (num2) values(0.7898);
insert into ex3_1 (num2) values(1.2345);
insert into ex3_1 (num2) values(32);   --����

insert into ex3_1 (num3) values(12345.2345);
insert into ex3_1 (num3) values(123459.2345);
insert into ex3_1 (num3) values(12345679.2345);   --���� ��ü 7�ڸ�

/*
��¥ ������ Ÿ�� (date(����Ͻú���), timestamp(����Ͻú��ʹи���))
*/
create table ex3_2(
    datel date
    ,date2 timestamp
 );
 
 -- sysdate ����ð�
 INSERT INTO ex3_2 values (sysdate, systimestamp);
 
 select *
 from ex3_2;
 
create table ex3_3(
    user_id varchar2(100)
    ,create_dt date default sysdate
);
insert into ex3_3 (user_id) values('a001');
select *
from ex3_3;

/*
    ��������
    not null ���� ������� �ʰڴ�.
    unique �ߺ��� ������� �ʰڴ�.
    check Ư�������͸� �ްڴ�
    primary key �⺻Ű(�ϳ��� ���̺� 1���� ��������)
                �� ���� �����ϴ� �ĺ��ڷ� ��� pk�� �����ϸ� unique&not null �����
    foreign key �ܷ�Ű �ٸ����̺��� pk�� �����ϴ� Ű 
 */
 create table ex3_4(
        mem_id varchar2(100) not null unique
        , mem_nm varchar2(100)
        , mem_email varchar2(100) not null
        , constraint uq_ex3_4 unique(mem_email)
);
insert into ex3_4(mem_id, mem_email) values('a001', 'a001@gmail.com');
insert into ex3_4(mem_id, mem_email) values('a001', 'a001@gmail.com'); --���� unique
insert into ex3_4(mem_nm) values('�ؼ�'); -- ���� id,eamil notnull
select * from ex3_4;
select*
from user_constraints
where constraint_name like '%EX%';

--check��������
create table ex3_5(
nm varchar2(100)
,age number
,gender varchar2(1)
,CONSTRAINT ck_ex3_5_age check(age between 1 and 150)
,CONSTRAINT ck_ex3_5_gender check(gender in('F','M'))
);
insert into ex3_5 values ('�ؼ�', 10, 'M');
insert into ex3_5 values ('�ؼ�', 10, 'A'); -- ���� F or M check
insert into ex3_5 values ('�ؼ�', 151, 'M'); -- ���� age ������
select * from ex3_5;

/*
    foreing key ���� �����ϴ� ���̺��� �÷��� �⺻Ű�� ���� �Ǿ��־����.
    primary key�� �� ���̺� 1��, key�� ������ 1 ~n���� ����Ű�� ��������  
*/
CREATE TABLE dep(
    deptno NUMBER(3) CONSTRAINT dep_pk_deptno PRIMARY KEY ,
    deptname VARCHAR2(20) ,
    floor NUMBER(5)
);

CREATE TABLE emp(
    empno NUMBER(5) CONSTRAINT emp_pk_employee PRIMARY KEY ,
    empname VARCHAR2(20) ,
    title VARCHAR2(20) ,
    dno NUMBER(3) CONSTRAINT emp_fk_dno REFERENCES dep(deptno),
    salary NUMBER(10)
);
COMMIT;

INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (1, '����', 8);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (2, '��ȹ', 10);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (3, '����', 9);


INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (2106, '��â��', '�븮', 2, 2000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3426, '�ڿ���', '����', 3, 2500000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3011, '�̼���', '����', 1, 3000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (1003, '������', '�븮', 1, 2000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3427, '����ö', '���', 3, 1500000);

--���������� �ݿ�
commit;

--��� (commit ���ϸ� �ѹ��� ����) �μ�Ʈ�κ��� �̻��ϰ� �־����� ���°�
rollback;


select *
from emp;
select *
from dep;

-- �����ϰ� �ִ� ���̺� �ֱ� ������ �׳�drop���ȵ�  
--���� ���� ���� �� ���̺� ����
drop table dep cascade constraints;

--�����ʹ� ���� �ϰ��ִ� �ͺ��� �־��ְ� �����޴´���� �������ִ�.


select emp.empname -- ������ ������ ���� �ٸ��� �׳ɽᵵ �ȴ� empnameó��
    , emp.title
    , dep.deptname
from emp, dep 
where emp.dno = dep.deptno -- join �ڿ��� ��ﳻ�� ���̺� ���踦 �δ¹��
and emp.empname = '�̼���';

drop table TB_INFO cascade constraints;
CREATE TABLE TB_INFO(
   INFO_NO NUMBER(3)  not null
   , PC_NO VARCHAR2(10)  not null unique
    , NM VARCHAR2(20)
    , EMAIL VARCHAR2(50)
    , HOBBY VARCHAR2(1000)
    , MBTI VARCHAR2(4)
);

SELECT *
from tb_info



