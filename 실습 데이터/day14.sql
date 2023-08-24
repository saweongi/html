SELECT count(*)
FROM 학생 a;

--분석 함수 over() 집계함수의 총을 가져온다.(row 손실 없이 출력하고 싶을때 사용)
SELECT a.*
, count(*) over() as 전체건수
FROM 학생 a;

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
    , DENSE_RANK() OVER(PARTITION BY department_id   --동일순서가 있을 경우 안건너뛴다.
                                ORDER BY salary DESC) as densc_rnak
from employees; 

-- 부서별 salary가 가장 큰 직원만 출력하시오
select * from(
select emp_name
    ,salary
    ,department_id
    ,rank() over(partition by department_id order by salary desc ) as rnak
from employees
)
where rnak =1;

