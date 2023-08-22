-- 1번 문제 
select *
from customer
where customer.job in('자영업','의사') and  to_number(substr(customer.birth,1,4)) >= 1988
order by customer.birth desc;

-- 2번문제 
select customer_name
    ,phone_number
from customer ,address
where customer.zip_code = address.zip_code
and address.address_detail ='강남구';

--3번 문제 
select customer.job
    ,count(customer.job) as 직원수 
from customer
having count(customer.job) >=1
group by customer.job
order by 2 desc;


-- 4-1 문제 
select TO_CHAR(customer.first_reg_date,'day') as 요일
        ,count(TO_CHAR(customer.first_reg_date,'day')) as 건수
from customer 
group by TO_CHAR(customer.first_reg_date,'day')
having count(TO_CHAR(customer.first_reg_date,'day')) = (select max(count(TO_CHAR(customer.first_reg_date,'day')))
                                                        from customer
                                                        group by TO_CHAR(customer.first_reg_date,'day'));
                                                        
                
-- 4-2번 문제 
select  
    nvl(DECODE(customer.sex_code, 'M','남자','F','여자','미등록'),'합계') AS gender
     , count(DECODE(customer.sex_code, 'M','남자','F','여자','미등록')) AS cnt
from customer
group by  rollup (DECODE(customer.sex_code, 'M','남자','F','여자','미등록'));

--  5번문제 
select substr(substr(reservation.reserv_date,5),1,2) as 월
        ,count(reservation.cancel) as 취소건수 
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

