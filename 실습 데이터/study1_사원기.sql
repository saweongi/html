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

--  5������ 
select substr(substr(reservation.reserv_date,5),1,2) as ��
        ,count(reservation.cancel) as ��ҰǼ� 
from reservation
where reservation.cancel ='Y'
group by substr(substr(reservation.reserv_date,5),1,2)
order by 2 desc;







