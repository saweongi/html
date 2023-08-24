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

--8������
select substr(reserv_no,1,6)
,product_name
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'1',sales,0)) as �Ͽ���
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'2',sales,0)) as ������
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'3',sales,0)) as ȭ����
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'4',sales,0)) as ������
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'5',sales,0)) as �����
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'6',sales,0)) as �ݿ���
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'7',sales,0)) as �����
from item,order_info
where item.item_id=order_info.item_id
and item.item_id ='M0001'
group by substr(reserv_no,1,6),product_name
order by 1;
select *
from address;

select *
from customer;

select *
from item;

select *
from reservation;

--9������
select ADDRESS_DETAIL
  , count(distinct reservation.customer_id)
from  address,customer,reservation
where  address.zip_code = customer.zip_code
and customer.customer_id = reservation.customer_id
and reservation.cancel ='N'
group by ADDRESS_DETAIL
order by 2 desc;

------------------------------------------------
----  ���� ����(branch) �湮Ƚ���� �湮���� ���� ����Ͻÿ�.
-- �湮Ƚ���� 4�� �̻��� ����Ͻÿ�(������Ұ� ����)

select *
from address;

select *
from customer;

select *
from item;

select *
from reservation;

select reservation.customer_id,customer_name,branch,count(visitor_cnt) as �湮Ƚ��,sum(visitor_cnt) as �湮����
from reservation,customer
where reservation.customer_id = customer.customer_id
and reservation.cancel = 'N'
having count(visitor_cnt) >=4
group by reservation.customer_id,customer_name,branch
order by �湮Ƚ�� desc, �湮���� desc;

--���� �湮�� ���� �� ���� �׵��� ������ ǰ�� �ջ�ݾ��� ����Ͻÿ�
-- W1338910
SELECT reserv_no
FROM reservation
WHERE cancel = 'N'
AND customer_id='W1338910';

SELECT (SELECT product_name FROM item WHERE item_id = a.item_id) as category
    , SUM(a.sales) as �����հ�
FROM order_info a
WHERE reserv_no IN(SELECT reserv_no
FROM reservation
WHERE cancel = 'N'
AND customer_id=(select  customer_id
from(select reservation.customer_id,customer_name,branch,count(visitor_cnt) as �湮Ƚ��,sum(visitor_cnt) as �湮����
from reservation,customer
where reservation.customer_id = customer.customer_id
and reservation.cancel = 'N'
group by reservation.customer_id,customer_name,branch
order by �湮Ƚ�� desc, �湮���� desc
)
where rownum <=1))
group by item_id;



