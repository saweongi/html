/* ȸ���� īƮ ���Ƚ���� ���� ����
���� �������� ���� ������ ����Ͻÿ� */

SELECT max(cnt) as max_cnt
, min(cnt) as min_cnt
FROM(
select a.mem_id
    ,a.mem_name
    ,count(distinct b.cart_no) cnt
from member a
 ,cart b
 where a.mem_id = b.cart_member
 group by a.mem_id
    ,a.mem_name
    );
    
SELECT *
FROM(select a.mem_id
    ,a.mem_name
    ,count(distinct b.cart_no) cnt
from member a
 ,cart b
 where a.mem_id = b.cart_member
 group by a.mem_id
    ,a.mem_name)
WHERE cnt =1
OR cnt = 8;

--WITH
WITH T1 AS (select a.mem_id
    ,a.mem_name
    ,count(distinct b.cart_no) cnt
from member a
 ,cart b
 where a.mem_id = b.cart_member
 group by a.mem_id
    ,a.mem_name
),T2 AS(
    SELECT MAX(T1.cnt) as max_cnt, MIN(T1.cnt) as min_cnt
    FROM T1
)
SELECT T1.mem_id, T1.mem_name, T1.cnt
FROM T1, T2
WHERE T1.cnt = T2.max_cnt
OR T1.cnt = T2.min_cnt;

WITH A as(
    SELECT *
    FROM member
)
SELECT *
FROM a;

-------
WITH T1 as (select a.�̸�
                , a.�й�
                , a.�б�
                , b.����������ȣ
                , b.�����ȣ
            from �л� a, �������� b
            where a.�й� = b.�й�(+)
), T2 as( 
    SELECT T1.�̸�, T1.�й�, COUNT(T1.����������ȣ)as �����̷°Ǽ�
    FROM T1
    GROUP BY T1.�̸�, T1.�й�
), T3 as (SELECT T1.�̸�, T1.�й�, SUM(����.����) AS ��ü��������
            FROM T1, ����
            WHERE T1.�����ȣ = ����.�����ȣ(+)
            GROUP BY T1.�̸�, T1.�й� 
)
SELECT t1.�й�,t1.�̸�, max(t2.�����̷°Ǽ�), max(t3.��ü��������)
FROM t1, t2, t3
where t1.�й� =t2.�й�
and t1.�й� =t3.�й�
group by t1.�й�, t1.�̸�;

/* WITH ��
   ��Ī���� ����� SELECT���� �ٸ� �������� ������ ����
   �ݺ��Ǵ� ���������� 1���� ����ó�� ��밡��
   ��������� Ʃ�׽� ���� ���
   **����
   -temp��� �ӽ� ���̺��� ����ؼ� ��ð� �ɸ��� ���� ����� �����ؼ�
   �׼���(����)������ �ں��ǰ� �Ǽ��� ���� ���̺��� ��ȸ�Ҷ� ������ ����.
   oracle 9���� �̻󿡼� ������.
   - �������� ���� ������ ����
   **����
   - �޸𸮿� ��ȸ����� �÷����� ����ϱ� ������ ������ ���ɿ� ������ �ټ�����
   - WITH�� �����ϴ� ������Ʈ�� �ֱ� ������(Ȯ�� �� ���)
*/

--------------------------------------------------
-- 2000�⵵ ��Ż������ ����� ����� ���� ū ���� ��� ������� '���', '�����'�� ����Ͻÿ�
SELECT *
FROM SALES;

select *
from customers;

select *
from countries;
desc sales;


with  t4 as(
select sales_month
,round(avg(amount_sold)) as �����
from sales,customers,countries
where sales.cust_id = customers.cust_id
and customers.country_id = countries.country_id
and country_name ='Italy'
and to_char(sales_date,'yyyy') = '2000'
group by sales_month
order by 1
), t5 as(
select round(avg(amount_sold)) as �����
from sales,customers,countries
where sales.cust_id = customers.cust_id
and customers.country_id = countries.country_id
and country_name ='Italy'
and to_char(sales_date,'yyyy') = '2000'
)
select sales_month,t4.�����
from t4,t5
where t4.����� > t5.�����
order by 2 desc;

with  T1 as(
select sales_month
,amount_sold 
from sales,customers,countries
where sales.cust_id = customers.cust_id
and customers.country_id = countries.country_id
and country_name ='Italy'
and to_char(sales_date,'yyyy') = '2000'
),T2 as (
    SELECT AVG(t1.amount_sold) as year_avg
    FROM T1
), T3 as (
SELECT t1.sales_month
        ,AVG(T1.amount_sold) as month_avg
        FROM T1
        GROUP BY t1.sales_month
    )
    
SELECT t3.sales_month
    ,t3.month_avg
FROM t2, t3
WHERE t3.month_avg > t2.year_avg;




