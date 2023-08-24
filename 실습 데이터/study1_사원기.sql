-- 1�� ���� 
select *
from customer
where customer.job in('�ڿ���','�ǻ�') and  to_number(substr(customer.birth,1,4)) >= 1988
order by customer.birth desc;

-- 2������ 
select customer_name
    ,phone_number
from customer ,address
where customer.zip_code = address.zip_code
and address.address_detail ='������';

--3�� ���� 
select customer.job
    ,count(customer.job) as ������ 
from customer
having count(customer.job) >=1
group by customer.job
order by 2 desc;


-- 4-1 ���� 
select TO_CHAR(customer.first_reg_date,'day') as ����
        ,count(TO_CHAR(customer.first_reg_date,'day')) as �Ǽ�
from customer 
group by TO_CHAR(customer.first_reg_date,'day')
having count(TO_CHAR(customer.first_reg_date,'day')) = (select max(count(TO_CHAR(customer.first_reg_date,'day')))
                                                        from customer
                                                        group by TO_CHAR(customer.first_reg_date,'day'));
                                                        
                
-- 4-2�� ���� 
select  
    nvl(DECODE(customer.sex_code, 'M','����','F','����','�̵��'),'�հ�') AS gender
     , count(DECODE(customer.sex_code, 'M','����','F','����','�̵��')) AS cnt
from customer
group by  rollup (DECODE(customer.sex_code, 'M','����','F','����','�̵��'));

--grouping_id : group by ������ �׷�ȭ�� ������ ��, ���� �÷��� ����
--                         ���� ��Ż�� ���� �����ϱ� ���� �Լ�
select sex_code
, grouping_id(sex_code) as groupid
, count(*) as cnt
FROM customer
GROUP BY ROLLUP(sex_code);

--  5������ 
select substr(substr(reservation.reserv_date,5),1,2) as ��
        ,count(reservation.cancel) as ��ҰǼ� 
from reservation
where reservation.cancel ='Y'
group by substr(substr(reservation.reserv_date,5),1,2)
order by 2 desc;

select *
from address;

select *
from customer;

select *
from item;

select *
from reservation;

select *
from order_info;

 -- 6������
select product_name
    ,sum(price * quantity) as ��ǰ����
from item,order_info
where item.item_id = order_info.item_id
group by product_name
order by 2 desc;

desc order_info;

--7�� ����
select substr(reserv_no,1,6) as �����
 ,sum(Decode (item.item_id,'M0001',sales,0)) AS SPECIAL_SET
 ,sum(Decode (item.item_id,'M0002',sales,0)) AS PASTA
 ,sum(Decode (item.item_id,'M0003',sales,0)) AS PIZZA
,sum(Decode (item.item_id,'M0004',sales,0)) AS SEA_FOOD
,sum(Decode (item.item_id,'M0005',sales,0)) AS STEAK
,sum(Decode (item.item_id,'M0006',sales,0)) AS SALAD_BAR
,sum(Decode (item.item_id,'M0007',sales,0)) AS SALAD
,sum(Decode (item.item_id,'M0008',sales,0)) AS SANDWICH
,sum(Decode (item.item_id,'M0009',sales,0)) AS WINE
,sum(Decode (item.item_id,'M0010',sales,0)) AS JUICE
from order_info,item
where item.item_id = order_info.item_id
group by substr(reserv_no,1,6)
order by 1;

