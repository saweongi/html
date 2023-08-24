SELECT count(*)
FROM �л� a;

--�м� �Լ� over() �����Լ��� ���� �����´�.(row �ս� ���� ����ϰ� ������ ���)
SELECT a.*
, count(*) over() as ��ü�Ǽ�
FROM �л� a;

select emp_name
, department_id
, row_number() OVER( PARTITION BY department_id ORDER BY emp_name) as dep_row
, row_number() OVER( PARTITION BY department_id, job_id ORDER BY emp_name) as dep_job_row
,job_id
, row_number() OVER( PARTITION BY job_id ORDER BY emp_name) as job_row
from employees;

-- RANK(), DENSE_RANK() 
SELECT mem_id, mem_name, mem_job
    ,mem_mileage
    ,RANK() OVER(PARTITION BY mem_job ORDER BY mem_mileage DESC) as mem_rank
    ,DENSE_RANK() OVER(PARTITION BY mem_job
                        ORDER BY mem_mileage DESC) as mem_dense_rank
    FROM member;
SELECT emp_name
    , RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as rnak
    , DENSE_RANK() OVER(PARTITION BY department_id   --���ϼ����� ���� ��� �Ȱǳʶڴ�.
                                ORDER BY salary DESC) as densc_rnak
from employees; 

-- �μ��� salary�� ���� ū ������ ����Ͻÿ�
select * from(
select emp_name
    ,salary
    ,department_id
    ,rank() over(partition by department_id order by salary desc ) as rnak
from employees
)
where rnak =1;

