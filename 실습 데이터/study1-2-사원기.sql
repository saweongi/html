 -- 6번문제
select product_name
    ,sum(price * quantity) as 상품매출
from item,order_info
where item.item_id = order_info.item_id
group by product_name
order by 2 desc;

desc order_info;

--7번 문제
select substr(reserv_no,1,6) as 매출월
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

--8번문제
select substr(reserv_no,1,6)
,product_name
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'1',sales,0)) as 일요일
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'2',sales,0)) as 월요일
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'3',sales,0)) as 화요일
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'4',sales,0)) as 수요일
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'5',sales,0)) as 목요일
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'6',sales,0)) as 금요일
,sum(Decode(to_char(to_date(substr(reserv_no,1,8),'yyyymmdd'),'d'),'7',sales,0)) as 토요일
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

--9번문제
select ADDRESS_DETAIL
  , count(distinct reservation.customer_id)
from  address,customer,reservation
where  address.zip_code = customer.zip_code
and customer.customer_id = reservation.customer_id
and reservation.cancel ='N'
group by ADDRESS_DETAIL
order by 2 desc;

------------------------------------------------
----  고객별 지점(branch) 방문횟수와 방문객의 합을 출력하시오.
-- 방문횟수가 4번 이상합 출력하시오(예약취소건 제외)

select *
from address;

select *
from customer;

select *
from item;

select *
from reservation;

select reservation.customer_id,customer_name,branch,count(visitor_cnt) as 방문횟수,sum(visitor_cnt) as 방문객수
from reservation,customer
where reservation.customer_id = customer.customer_id
and reservation.cancel = 'N'
having count(visitor_cnt) >=4
group by reservation.customer_id,customer_name,branch
order by 방문횟수 desc, 방문객수 desc;

--가장 방문을 많이 한 고객의 그동한 구매한 품목별 합산금액을 출력하시오
-- W1338910
SELECT reserv_no
FROM reservation
WHERE cancel = 'N'
AND customer_id='W1338910';

SELECT (SELECT product_name FROM item WHERE item_id = a.item_id) as category
    , SUM(a.sales) as 구매합계
FROM order_info a
WHERE reserv_no IN(SELECT reserv_no
FROM reservation
WHERE cancel = 'N'
AND customer_id=(select  customer_id
from(select reservation.customer_id,customer_name,branch,count(visitor_cnt) as 방문횟수,sum(visitor_cnt) as 방문객수
from reservation,customer
where reservation.customer_id = customer.customer_id
and reservation.cancel = 'N'
group by reservation.customer_id,customer_name,branch
order by 방문횟수 desc, 방문객수 desc
)
where rownum <=1))
group by item_id;



