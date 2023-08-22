SELECT department_id

        -- level ���󿭷μ� Ʈ�� ������ � �ܰ����� ��Ÿ���� ������
    ,LPAD(' ',3*(level -1)) || department_name as �μ���
    ,parent_id
    ,level
FROM departments
START WITH parent_id IS NULL                --����
CONNECT BY PRIOR department_id = parent_id; -- ������ ��� ��������(����)

-- departments ���̺� 230 IT��������ũ ���� �μ���
--                    280     IT�������� �������ּ���
INSERT INTO departments(department_id,department_name,parent_id) VALUES(280,'IT������',230);

/*������ �������� ������ �Ϸ��� SIBLINGS BY�� �߰��ؾ���(Ʈ�������� �ȱ��� ����)*/
SELECT department_id

        -- level ���󿭷μ� Ʈ�� ������ � �ܰ����� ��Ÿ���� ������
    ,LPAD(' ',3*(level -1)) || department_name as �μ���
    ,parent_id
    ,level
FROM departments
START WITH parent_id IS NULL                --����
CONNECT BY PRIOR department_id = parent_id
ORDER SIBLINGS BY department_name; --SIBLINGS ���ÿ��� ���� �÷����θ� ���İ���(�μ��� ���Ұ�)

--�������� �Լ�
SELECT department_id

        -- level ���󿭷μ� Ʈ�� ������ � �ܰ����� ��Ÿ���� ������
    ,LPAD(' ',3*(level -1)) || department_name as �μ���
    ,parent_id
    ,level
    , CONNECT_BY_ISLEAF --����������1, �ڽ��� ������ 0 
    , SYS_CONNECT_BY_PATH(department_name, '>')-- ��Ʈ ��忡�� �ڽ������ �������� '>'�� ǥ��
    , CONNECT_BY_ISCYCLE --���ѷ����� ������ ã����(�ڽ��� �ִµ� ���ڽ� �ο찡 �θ��̸� 1, �ƴϸ� 0)
FROM departments
START WITH parent_id IS NULL                --����
CONNECT BY NOCYCLE PRIOR department_id = parent_id; 

--�������� �������踦 ����Ͻÿ�(���� ������ �̸� ��������)
SELECT employee_id
     ,LPAD(' ',3*(level -1)) || emp_name as ������
     ,manager_id
     ,level
      , SYS_CONNECT_BY_PATH(emp_name, '>') as ��������
FROM employees
START WITH MANAGER_ID IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY emp_name;
desc employees;

drop TABLE sa;
CREATE TABLE sa(
    sa_id NUMBER(6)
    ,sa_name VARCHAR2(40)
    ,sa_class VARCHAR2(20)
    ,sa_topid NUMBER(6)
);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(1,'�̻���','����',null);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(2,'�����','����',1);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(3,'������','����',2);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(4,'�����','����',3);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(5,'�ڰ���','����',3);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(6,'�̴븮','�븮',4);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(9,'�ֻ��','���',6);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(10,'�����','���',6);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(7,'��븮','�븮',5);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(11,'�ֻ��','���',7);
SELECT sa_name
     ,LPAD(' ',3*(level -1)) || sa_class as ������
     ,sa_topid
     ,level
FROM sa
START WITH sa_topid IS NULL
CONNECT BY PRIOR sa_id = sa_topid;



select period
    ,sum(loan_jan_amt) as �����հ�
from kor_loan_status
where substr(period, 1, 4) = 2013
group by period;

/* level�� ����-���μ� (connect by ���� �Բ� ���)
    ������ �����Ͱ� �ʿ��Ҷ� ���̻��.
*/
SELECT level || '��'
FROM dual
CONNECT BY LEVEL <=12;

-- 2013�� 1 ~12�� ������
SELECT '2013' || LPAD(level,2,'0') as ���
FROM dual
CONNECT BY LEVEL <=12;



SELECT a.���
  ,NVL( b.�����հ�,0) as �����հ�
FROM(
    SELECT '2013' || LPAD(level,2,'0') as ���
    FROM dual
    CONNECT BY LEVEL <=12
) a
, (
    select period as ���
    ,sum(loan_jan_amt) as �����հ�
    from kor_loan_status
    where substr(period, 1, 4) = 2013
    group by period
)b
where a.��� = b.���(+)
order by 1;

--202301~202312
SELECT substr(To_char(sysdate,'YYYY') || LPAD(level,2,'0'),5,6)||'��' as ���
FROM dual
CONNECT BY LEVEL <=12;

SELECT To_char(sysdate,'YYYYMM')|| LPAD(level,2,'0') as �����
FROM dual
CONNECT BY LEVEL <= substr(last_day(sysdate),7,8);


SELECT substr(To_char(sysdate,'YYYY') || LPAD(level,2,'0'),5,6) as ���
    FROM dual
    CONNECT BY LEVEL <=12;


--2023�� 1��~12�� ������
select *
from kor_loan_status;
SELECT a.���
  ,NVL( b.�����հ�,0) as �����հ�
FROM(
    SELECT '2013' || LPAD(level,2,'0') as ���
    FROM dual
    CONNECT BY LEVEL <=12
) a
, (
    select period as ���
    ,sum(loan_jan_amt) as �����հ�
    from kor_loan_status
    where substr(period, 1, 4) = 2013
    group by period
)b
where a.��� = b.���(+)
order by 1;

-- member ȸ���� ����(mem_bir) �� ���� ȸ������ ����Ͻÿ�(������ ��������)

select *
from member;
desc member;

select to_char(mem_bir,'mm') as ����_��
   ,count(to_char(mem_bir,'mm')) as ȸ����
from member
group by to_char(mem_bir,'mm')
order by 1;

select nvl(a.����_��,'�հ�')  as ����_��
   ,sum(nvl(b.ȸ����,'0')) as ȸ����
from (SELECT substr(To_char(sysdate,'YYYY') || LPAD(level,2,'0'),5,6) || '��' as ����_��
FROM dual
CONNECT BY LEVEL <=12) 
a,
(select to_char(mem_bir,'mm') || '��' as ����_��
   ,count(to_char(mem_bir,'mm')) as ȸ����
   from member
   group by to_char(mem_bir,'mm')
   
) b
where a.����_��= b.����_��(+)
group by rollup(a.����_��)
order by 1;




