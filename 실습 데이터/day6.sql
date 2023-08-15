SELECT mbti,count(*) as cnt
FROM tb_info
group by mbti
order by 2 desc;

select hobby,count(*) as cnt
from tb_info
group by hobby
order by 2 desc;


/*���� �Լ� ��� �����͸� Ư�� �׷����� ���� ���� �׷쿡 ����
  ����, ���, �ִ�, �ּڰ� ���� ���ϴ� �Լ�.
  count(expr) �ο� ���� ��ȯ�ϴ� �����Լ�.
  */
select count(*)  --null����
      , count(department_id) --default all (all�� �Ƚᵵ�� �׻� �̰Ŷ�)
      , count(all department_id) --�ߺ� ���� null x
      , count(distinct department_id) --�ߺ�����
      , count(employee_id)   -- �⺻Ű�� null �� ����
from employees;

-- �׷���̴� �츮�� ������ ����� �׷����� �����ش�.
-- select ���� ���� �÷��� �����Լ��� �����ϰ�
-- group by ���� ���ԵǾ����.
select department_id
    ,sum(salary) --�հ�
    ,avg(salary) --���
    ,round(avg(salary),2) -- 2°¥������ �ݿø� �ؼ� ���
    ,max(salary) --�ִ�
    ,min(salary) --�ּ�
    from employees
    group by department_id
    order by 1;
   
select min(salary)
    ,max(salary)
from employees
where department_id = 50;

select mem_job
    ,count(*) as cnt
from member
group by mem_job
order by 2 desc;

select period
, sum(loan_jan_amt) as �ܾ�
from kor_loan_status
where period like '2013%'
group by period
order by 1;

select *
from kor_loan_status;
 
select region
, sum(loan_jan_amt) as �ܾ�
from kor_loan_status
where period like '2013%'
group by region  
order by 1;


select region
,gubun
, sum(loan_jan_amt) as �ܾ�
from kor_loan_status
where period like '2013%'
group by region , gubun
order by 1;

--�⵵�� ������ �� �հ�
select substr(period,1,4) as �⵵
    ,sum(loan_jan_amt) as ���ܾ�
    from kor_loan_status
group by substr(period,1,4)
order by 1;

--�⵵�� ������ ������ �� �հ�
select substr(period,1,4) as �⵵
    ,region
    ,sum(loan_jan_amt) as ���ܾ�
    from kor_loan_status
group by substr(period,1,4) , region
order by 1;

-- employees �������� ��� �⵵�� �������� ����Ͻÿ�

desc employees;

select *
from employees;

select to_char(hire_date,'yyyy') as �Ի�⵵
 ,count(*) as ������
from employees
group by to_char(hire_date,'yyyy')
order by 1;

-- �׷��� ����� �����Ϳ� ���� �˻������� ������   --> ������� where�� ������ ������ �׷����� �����Ϳ� ���� ������ �ɼ������(select�� ���� ������ ����)
-- having ���
-- �Ի������� 10�� �̻��� �⵵�� ������
-- select�� �������
-- from --> where -> group by -> having ->select -> order by  : �켱����ó�� ���� ����Ǵ� ������
select to_char(hire_date,'yyyy') as �Ի�⵵
 ,count(*) as ������
from employees
group by to_char(hire_date,'yyyy')
having count(*)>=10
order by 1;

-- number ���̺��� Ȱ���Ͽ�
-- ������ ���ϸ��� ��ձݾ��� ���Ͻÿ� (�Ҽ��� 2° �ڸ����� �ݿø��Ͽ� ���)

desc member;

select *
from member;

select mem_job
    ,round( avg(mem_mileage),2)
from member
group by mem_job
order by 2 desc;

select mem_job
    ,round( avg(mem_mileage),2) as ��ո��ϸ���
from member
group by mem_job
having round( avg(mem_mileage),2)>=3000
order by 2 desc;

---------------------------
-- ������ ���ϸ����� �հ� ���ϸ��� ��ü�հ踦 ����Ͻÿ�
select nvl( mem_job,'�հ�') as ����
    ,count(mem_id) as ȸ����
    ,sum(mem_mileage) as �հ�
from member
group by rollup(mem_job); --�Ѿ� ���ƿø��ٴ� ������ ���� ����� ���� �����, ������ �ʿ��Ҷ� ���

--products ��ǰ���̺��� ī�װ��� ��ǰ���� ��ü ��ǰ ���� ����Ͻÿ�

desc products;

select *
from products;

select nvl(prod_category,'�հ�') asī�װ�
    ,prod_subcategory as ����ī�װ�
    ,count(prod_id) as ��ǰ��
from products
group by rollup(prod_category,prod_subcategory);

select cust_id
, cust_name
, cust_gender
,cust_year_of_birth
from customers;

-- �⵵�� ȸ������ ����Ͻÿ� ��(��, �� �����Ͽ���)  -->�ϳ��� �÷����� ���డ �ִµ� �ΰ��� �÷������� �����ش�.
select cust_year_of_birth
, sum(Decode(CUST_GENDER,'M',1,0)) as ����
, sum(Decode(CUST_GENDER,'F',1,0)) as ����
from customers
group by rollup(cust_year_of_birth)
order by 1;


--������ �� �⵵�� ���� ���ܾ��� ���ϴ� ������ �ۼ��غ���(kor_loan_staus)

select *
from kor_loan_status;

select region
, sum(decode(substr (period,1,4),'2011',loan_jan_amt)) as AMT_2011
, sum(decode(substr (period,1,4),'2012',loan_jan_amt)) as AMT_2012
, sum(decode(substr (period,1,4),'2013',loan_jan_amt)) as AMT_2013
from kor_loan_status
group by rollup(region);