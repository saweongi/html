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
where customer.job in('�ڿ���','�ǻ�') and  to_number(substr(customer.birth,1,4)) >= 1988
order by customer.birth desc;

select customer_name
    ,phone_number
from customer ,address
where customer.zip_code = address.zip_code
and address.address_detail ='������';

select customer.job
    ,count(customer.job) as ������ 
from customer
having count(customer.job) >=1
group by customer.job
order by 2 desc;

select TO_CHAR(customer.first_reg_date,'day') as ����
        ,count(TO_CHAR(customer.first_reg_date,'day')) as �Ǽ�
from customer 
group by TO_CHAR(customer.first_reg_date,'day');

select  
    DECODE(customer.sex_code, 'M','����','F','����','�̵��') AS gender
     , count(DECODE(customer.sex_code, 'M','����','F','����','�̵��')) AS cnt
from customer

group by  rollup (DECODE(customer.sex_code, 'M','����','F','����','�̵��'));

select substr(substr(reservation.reserv_date,5),1,2) as ��
        ,count(reservation.cancel)
from reservation
having reservation.cancel ='Y'
group by substr(substr(reservation.reserv_date,5),1,2);







