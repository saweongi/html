/*
 �������� TRIM : ����, LTRIM : ����, RTRIM: ������
 ���ڿ� ���� ���߱�   LPAD : ���ʺ��� , RPAD : �����ʺ���
 */
 
SELECT LTRIM('   ABC   ')
        ,RTRIM('   ABC   ')
        , TRIM('   ABC   ')
FROM dual;

--LPAD(1, 5, '0') -> 00001 �Է��� 50�̸� ->00050
SELECT LPAD(123, 5, '0')
    ,LPAD(12310, 5, '0')
    ,LPAD(1, 5, '0')
    ,LPAD(111111, 5, '0')  --���� ����� ������ 2��° �Ű����� ���� ��ŭ(�����Ͱ� ©�� �� ����)
    ,RPAD(1, 5,'0')
FROM dual;
-- ** REPLACE
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����','�ʸ�') rep 
 ,TRANSLATE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʸ�') trn  -- ���� �̶���� �� �� ���� ã�Ƽ� �ʷ� �ٲ��ְ� �� �� ã�Ƽ� ���� �ٲ��ش� 
FROM dual;

-- LENGTH ���ڿ�����, LENGTHB ũ��
SELECT LENGTH('���ѹα�')
, LENGTHB('���ѹα�') -- ���ѹα��� ����Ʈ�� ������ش�(�ѱ��� �Ѱ��� 1����Ʈ)
, LENGTH('1234')   
, LENGTHB('1234')  -- ����,���� �� 1����Ʈ
FROM dual;  

/*��¥ �Լ�*/
SELECT SYSDATE
    , SYSTIMESTAMP   --����ð�
FROM dual;

-- ADD_MONTHS ���� �߰��ϰų� �� �� �ִ�.
SELECT ADD_MONTHS(SYSDATE,1)
 ,ADD_MONTHS(SYSDATE, -1)
 FROM dual;
 
 --LAST DAY,NEXT_DAY
 SELECT LAST_DAY(SYSDATE)  -- ���� ������ 
  ,NEXT_DAY(SYSDATE, '�ݿ���') --�ش� �������� �ݿ��� �̸� ���� �ݿ��� 
  ,NEXT_DAY(SYSDATE, '�����') -- �ش� ���� �����
  , SYSDATE +1 -SYSDATE as days
  , SYSDATE -2
FROM dual;

--�̹����� ���� ���������?
 SELECT (LAST_DAY(SYSDATE) - SYSDATE) ||'��' as D_DAY
 FROM dual;
 
 /* �����Լ� (�Ű����� ������)
    ABS: ���밪
    ROUND �ݿø�
    TRUNC ����
 */
 SELECT ABS(-10)
    ,ABS(10)
    ,ROUND(10.155, 1)
    ,ROUND(10.155, 2)
    ,ROUND(10) -- ����Ʈ 0
    ,TRUNC(114.999, 1)
FROM dual;

/* MODE(m ,n) m�� n���� ���������� ������ ��ȯ */
-- SQRT ������ ��ȯ
SELECT MOD(4,2)
 ,MOD(5,2)
 ,SQRT(4)
FROM dual;

/*��ȯ TO_CAHR : ���������� , TO_NUMBER : ����������, TO_DATE : ��¥������ */
    SELECT TO_CHAR(1234566, '999,999,999')
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD')
    , TO_CHAR(SYSDATE, 'YYYYMMDD')
    , TO_CHAR(SYSDATE, 'YYYYMMDD HH:MI:SS')
    , TO_CHAR(SYSDATE, 'YYYYMMDD HH24:MI:SS')
     , TO_CHAR(SYSDATE, 'day')
     , TO_CHAR(SYSDATE, 'dd')
     , TO_CHAR(SYSDATE, 'd') --������ ���ڷ� ��ȯ
FROM dual;

SELECT TO_DATE('230713', 'YYMMDD')
    --TO_DATE�� ��¥ ������Ÿ������ ����ȯ
    --�Է� ���˰� �����ϰ� ǥ���ؾ� DATE�� �ٲ�
 ,TO_DATE('2023 08 12 10:00:00', 'YYYY MM DD HH24:MI:SS')
FROM dual; 

CREATE TABLE tb_myday(
    title VARCHAR2(200)
    ,d_day DATE
);
INSERT INTO tb_myday VALUES ('������','20231226');
INSERT INTO tb_myday VALUES ('������','2023.12.26');
INSERT INTO tb_myday VALUES ('������','23.12.26');
INSERT INTO tb_myday VALUES ('������','23|12|26');
INSERT INTO tb_myday VALUES ('������','23|12|26 18');
INSERT INTO tb_myday VALUES ('������',TO_DATE('231226 18','YYMMDD HH24'));

CREATE TABLE ex5_1(
seq VARCHAR2(100)
,seq2 NUMBER
);
INSERT INTO ex5_1 VALUES('1234','1234');
INSERT INTO ex5_1 VALUES('99','99');
INSERT INTO ex5_1 VALUES('123456','123456');
SELECT *
FROM ex5_1
ORDER BY TO_NUMBER(seq) DESC;

SELECT *
FROM students;
-- students ���̺��� Ȱ���Ͽ� �й�,�л��̸�,���̸� ����Ͻÿ�
desc students;



desc customers;
SELECT  cust_name,cust_year_of_birth, TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - cust_year_of_birth as cust_year_AGE -- �׳� ���� �����̶� ���������� ������ ���ָ� ����̵ȴ�.
FROM  customers
ORDER BY cust_year_AGE;

-- RR�� �Էµ� ���ڸ� ���� ���� 50 ~�̻��̸� 20����� �ؼ�
--                          49���ϸ� 21����� �ؼ�.
SELECT stu_name, TO_DATE(stu_birth,'YYMMDD')
, TO_CHAR(TO_DATE(stu_birth, 'YYMMDD'),'YYYY')
, TO_DATE(stu_birth, 'RRMMDD')
, TO_CHAR(TO_DATE(stu_birth, 'RRMMDD'),'YYYY')
FROM students;

--employees�� hire_date �÷��� Ȱ���Ͽ� �ټ� ������ ����Ͻÿ�.
desc employees;

SELECT emp_name,hire_date, TO_CHAR(SYSDATE, 'YYYY') -TO_CHAR(hire_date, 'YYYY') AS �ټӿ���
from employees
ORDER BY �ټӿ��� desc,1;

-- null���� null�̶� ���� ���ϸ� null�� �����⶧���� null�����Լ� nvl�� ġȯ���༭ ����Ѵ�
-- **NVL(null,��ȯ��)
SELECT emp_name,salary, commission_pct
,salary * NVL(commission_pct,0)
FROM employees;

--DECODE ��ȯ (case�� ������)
SELECT cust_id, cust_name

        -- ����    ,��, ������, �׹ۿ�
    , DECODE(cust_gender, 'M','����','����') AS gender
    
        -- ����      ,��,������ , ��2, ������ , �׹ۿ�
    , DECODE(cust_gender, 'M','����','F','����','??') AS gender2
FROM customers;

/*
�� ���̺�(CUSTOMERS)����
���� ����⵵( CUST_YEAR_OF_BIRTH) �÷����ִ�.
������ �������� ���÷��� Ȱ���� 30�� , 40��, 50�븦 ������ ����ϰ�, ������ ���ɴ�� '��Ÿ�� ����ϴ� ������ �ۼ��غ���
*/
desc CUSTOMERS;

SELECT  cust_name,cust_year_of_birth, DECODE(substr(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - cust_year_of_birth,1,1),'3','30��','4','40��','5','50��','��Ÿ') as cust_year_AGE
FROM  customers
order by cust_year_of_birth desc;
