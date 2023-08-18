desc customer;

select *
from customer;


select *
from address;

select *
from item;

select *
from order_info;
select *
from reservation;

select *
from customer
where customer.job in('자영업','의사') and  to_number(substr(customer.birth,1,4)) >= 1988
order by customer.birth desc;

select customer_name
    ,phone_number
from customer ,address
where customer.zip_code = address.zip_code
and address.address_detail ='강남구';

select customer.job
    ,count(customer.job) as 직원수 
from customer
having count(customer.job) >=1
group by customer.job
order by 2 desc;

select TO_CHAR(customer.first_reg_date,'day') as 요일
        ,count(TO_CHAR(customer.first_reg_date,'day')) as 건수
from customer 
group by TO_CHAR(customer.first_reg_date,'day');

select  
    DECODE(customer.sex_code, 'M','남자','F','여자','미등록') AS gender
     , count(DECODE(customer.sex_code, 'M','남자','F','여자','미등록')) AS cnt
from customer

group by  rollup (DECODE(customer.sex_code, 'M','남자','F','여자','미등록'));

select substr(substr(reservation.reserv_date,5),1,2) as 월
        ,count(reservation.cancel)
from reservation
having reservation.cancel ='Y'
group by substr(substr(reservation.reserv_date,5),1,2);







