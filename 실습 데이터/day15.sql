/*
    �μ��� ������ salary�� ������� ������ ����Ͻÿ�
    
*/
select * from(
select emp_name
    ,salary
    ,department_id
    ,rank() over(partition by department_id order by salary desc ) as rnak
from employees
)
where rnak =1;

--�л��� ������ ������ ���� ���� �л��� ������ ����Ͻÿ�
select * from(
select �й�,�̸�,�ּ�,����,������,�������,�б�,����,rank() over(partition by ���� order by ���� desc ) as rnak
from �л�
)
where rnak=1;

select * from(
select a.*
,rank() over(partition by a.���� order by a.���� desc ) as rnak -- ������ ���� ���� �Ҷ�
,rank() over( order by a.���� desc ) as ALL_rnak --��ü�� ����  ���� �Ҷ� 
, count(*) over() as ��ü�л���
, avg(a.����) over() as ��ü���
from �л� a
)
where rnak=1;

/*
    �ο�ս� ���� ���谪 ����
    PARTITION BY ���� window ���� Ȱ���Ͽ� ���� ���踦 �� �� ����.
    AVG,  SUM, MAX, MIN, COUNT, RANK, DENSE_RANK, LAG, ROW_BUMBER...
    PARTITION BY �� : ��� ��� �׷�
    ORDER BY     �� : ��� �׷쿡���� ����
    WINDOW       �� : ��Ƽ������ ��Ȱ�� �׷쿡 ���� �� ���� �׷����� ����
*/

--CART, FROD ��ǰ�� prod_sale �հ��� ���� 10�� ��ǰ�� ����Ͻÿ�.
select *
from(
select c.* 
, RANK() OVER(ORDER BY sale_sum desc) as rnk
from(
SELECT a.cart_prod  --��ǰ���̵�
    ,b.prod_name    --��ǰ�̸�

    ,sum(a.cart_qty * b.prod_sale) as sale_sum

from cart a
    ,prod b
where a.cart_prod = b.prod_id
group by  a.cart_prod  --��ǰ���̵�
    ,b.prod_name    --��ǰ�̸�

    )c
)
where rnk<=10;

select *
from(SELECT a.cart_prod, b.prod_name
    ,RANK()OVER(ORDER BY SUM(b.prod_sale * a.cart_qty) DESC) as rnk
    from cart a, prod b
    where a.cart_prod = b.prod_id
    group by a.cart_prod, b.prod_name
    )
where rnk <=10;

/*
    NTILE(expr) ��Ƽ�Ǻ��� expr ��õ� ����ŭ ������ ����� ��ȯ
    NTILE(3) 1 ~ 3�� ���� ��ȯ(�����ϴ� ���� ��Ŷ �� �����)
    NTILE(4) -> 100/4 -> 25%�� ���� ����
*/
SELECT emp_name, salary, department_id
 ,NTILE(2) OVER(PARTITION BY department_id ORDER BY salary DESC) group_num
 ,COUNT(*) OVER(PARTITION BY department_id) as �μ�������
 FROM employees
 WHERE department_id IN(30,50);
 
 --��ü ������ �޿��� 10������ ��������� 1������ ���ϴ� ������ ��ȸ�Ͻÿ�
 SELECT emp_name, salary
    ,NTILE(10) OVER(ORDER BY salary DESC) as ����
FROM employees;

SELECT nm
    ,NTILE(6) OVER(ORDER BY DBMS_RANDOM.VALUE) as team
FROM tb_info;

-- 202301 ~ 202312 ���� �� 1000���� ������ ����
CREATE TABLE tb_sample AS
SELECT ROWNUM as seq
    ,'2023' || LPAD(CEIL(ROWNUM/1000), 2, '0') AS month
    ,ROUND(DMS_RANDOM,VALUE(100, 1000)) as amt
FROM dual
CONNECT BY LEVEL <=12000;
-- ���ĺ� �빮�� 5�ڸ� ��������
SELECT DBMS_RANDOM.STRING('U',5) -- ���ĺ� �빮�� 5�ڸ� ��������
    ,DBMS_RANDOM.STRING('L', 5) -- �ҹ���
    ,DBMS_RANDOM.STRING('A', 5) -- ��ҹ���
    ,DBMS_RANDOM.STRING('X', 5) -- ���ĺ� �빮�� & ����
    ,DBMS_RANDOM.STRING('P', 5) -- ��ҹ���,����,Ư������
FROM dual;

/* �־��� �׷�� ������ �ٶ� row�� �ִ� ���� �����Ҷ� ���
 LAG(expr, offset, default_value) ����ο��� ������
 LEAD(expr, offset, default)value) ����ο��� �� ����
*/
SELECT emp_name, department_id, salary
    ,  LAG(emp_name, 1, '�������') OVER(PARTITION BY department_id
                                   ORDER BY salary DESC) as emp_lag
    ,  LEAD(emp_name, 1, '���峷��') OVER(PARTITION BY department_id
                                    ORDER BY salary desc) as emp_lead
FROM employees;

/*
    �л��� ������ �������� �Ѵܰ� ���� �л��� ������ ���̸� ����Ͻÿ�
    1��  �ؼ�  4.5 0
    2��  �浿  4.3 0.2
    3��  ����  3.0 1.3  
*/
select *
from �л�
order by ���� desc;

SELECT �й�,�̸�,ROUND (����,2) as ����
    ,LAG(�̸�,1,'����') OVER(ORDER BY ���� DESC ) as �����л��̸�
    ,round(LAG(����,1,����) OVER(ORDER BY ���� DESC ) - ����,2 )��������
    
FROM �л�;

drop table bbs;
CREATE TABLE bbs(
bbs_no NUMBER PRIMARY KEY
,parent_no NUMBER
,bbs_title VARCHAR2(1000) DEFAULT NULL -- ����� ��� NULL
,bbs_content VARCHAR2(4000) NOT NULL
,AUTHOR_ID varchar2(100)
,create_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP --����� ������ �ð�
,update_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT fk_prent FOREIGN KEY(parent_no) REFERENCES bbs(bbs_no)on DELETE CASCADE --�Խñ��� no�� �����ϰ� ���� ������ ������ ���� ����
 
,CONSTRAINT fk_user FOREIGN KEY(author_id) REFERENCES tb_user(user_id)ON DELETE CASCADE --���� Ż��� ���� ����
);

-- �Խñ۹�ȣ ������
drop SEQUENCE bbs_seq;
CREATE SEQUENCE bbs_seq START WITH 1 INCREMENT BY 1;

INSERT INTO bbs(bbs_no,bbs_title, bbs_content, author_id)
VALUES(bbs_seq.NEXTVAL, '��������', '������ �ݿ��� �Դϴ�.!!!!','a001');
INSERT INTO bbs(bbs_no,bbs_title, bbs_content, author_id)
VALUES(bbs_seq.NEXTVAL, '�Խñ�1', '�Խñ� 1�Դϴ�.','b001');
INSERT INTO bbs(bbs_no,parent_no, bbs_content, author_id)
VALUES(bbs_seq.NEXTVAL, 1, '�� �������̿���....','x001');
SELECT * FROM bbs;

SELECT level,bbs_no,parent_no,bbs_title,bbs_content,author_id,create_dt,update_dt
FROM bbs
START WITH parent_no IS NULL                --����
CONNECT BY PRIOR BBS_NO = parent_no;

SELECT *
from bbs
start with bbs_no = 1
CONNECT BY PRIOR BBS_NO = parent_no;

SELECT DECODE(level, 1, '���α�','���') as status
    , a.bbs_no as bbs_no
    , LPAD(' ', 3* (level-1)) || a.bbs_content  as bbs_content
    , a.author_id as author_id
    , a.update_dt   as update_dt
FROM bbs a
START WITH bbs_no =1
CONNECT BY PRIOR a.bbs_no = a.parent_no
ORDER SIBLINGS BY update_dt desc;

SELECT *
FROM tb_user;

SELECT *
FROM user_tab_columns
WHERE table_name = 'TB_USER';

SELECT USER_ID
,USER_PW
,USER_NM
,USER_MAIL
,USER_MILEAGE
FROM tb_user
where user_id = 'a001';

INSERT INTO tb_user(user_id,user_nm,user_pw,create_dt)
values (?,?,?, sysdate);
SELECT ROWNUM as rnum
    , count(*) OVER() as all_cnt
    ,a.*
FROM(
SELECT bbs_no
, bbs_title
, author_id
, TO_CHAR(update_dt,'YYMMDD HH24:MI:SS') as update_dt
FROM bbs
WHERE parent_no IS NULL
ORDER BY update_dt DESC
) a
;
select *
from tb_user;
desc tb_user;
select *
FROM bbs;
desc bbs;



SELECT ROWNUM         as rnum     , count(*) OVER() as all_cnt     ,a.bbs_no    as bbs_no     ,a.bbs_title as bbs_title     ,a.author_id as author_id     ,a.update_dt as update_dt FROM(  SELECT bbs_no , bbs_title , author_id , TO_CHAR(update_dt,'YYMMDD HH24:MI:SS') as update_dt FROM bbs WHERE parent_no IS NULL ORDER BY update_dt DESC ) a;