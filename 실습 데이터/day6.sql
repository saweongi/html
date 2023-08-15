SELECT mbti,count(*) as cnt
FROM tb_info
group by mbti
order by 2 desc;

select hobby,count(*) as cnt
from tb_info
group by hobby
order by 2 desc;


/*집계 함수 대상 데이터를 특정 그룹으로 묶은 다음 그룹에 대한
  총합, 평균, 최댓값, 최솟값 등을 구하는 함수.
  count(expr) 로우 수를 반환하는 집계함수.
  */
select count(*)  --null포함
      , count(department_id) --default all (all을 안써도됨 항상 이거라서)
      , count(all department_id) --중복 포함 null x
      , count(distinct department_id) --중복제거
      , count(employee_id)   -- 기본키라서 null 이 없음
from employees;

-- 그룹바이는 우리가 집계할 대상을 그룹으로 묶어준다.
-- select 절에 오는 컬럼은 집계함수를 제외하고
-- group by 절에 포함되어야함.
select department_id
    ,sum(salary) --합계
    ,avg(salary) --평균
    ,round(avg(salary),2) -- 2째짜리까지 반올림 해서 평균
    ,max(salary) --최대
    ,min(salary) --최소
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
, sum(loan_jan_amt) as 잔액
from kor_loan_status
where period like '2013%'
group by period
order by 1;

select *
from kor_loan_status;
 
select region
, sum(loan_jan_amt) as 잔액
from kor_loan_status
where period like '2013%'
group by region  
order by 1;


select region
,gubun
, sum(loan_jan_amt) as 잔액
from kor_loan_status
where period like '2013%'
group by region , gubun
order by 1;

--년도별 대출의 총 합계
select substr(period,1,4) as 년도
    ,sum(loan_jan_amt) as 총잔액
    from kor_loan_status
group by substr(period,1,4)
order by 1;

--년도별 지역별 대출의 총 합계
select substr(period,1,4) as 년도
    ,region
    ,sum(loan_jan_amt) as 총잔액
    from kor_loan_status
group by substr(period,1,4) , region
order by 1;

-- employees 직원들의 고용 년도별 직원수를 출력하시오

desc employees;

select *
from employees;

select to_char(hire_date,'yyyy') as 입사년도
 ,count(*) as 직원수
from employees
group by to_char(hire_date,'yyyy')
order by 1;

-- 그룹핑 대상의 데이터에 대해 검색조건을 쓰려면   --> 원래라면 where로 조건을 하지만 그룹핑한 데이터에 대해 조건을 걸수가없어서(select문 실행 순서로 인해)
-- having 사용
-- 입사직원이 10명 이상인 년도와 직원수
-- select문 실행순서
-- from --> where -> group by -> having ->select -> order by  : 우선순위처럼 먼저 실행되는 순서들
select to_char(hire_date,'yyyy') as 입사년도
 ,count(*) as 직원수
from employees
group by to_char(hire_date,'yyyy')
having count(*)>=10
order by 1;

-- number 테이블을 활용하여
-- 직업별 마일리지 평균금액을 구하시오 (소수점 2째 자리까지 반올림하여 출력)

desc member;

select *
from member;

select mem_job
    ,round( avg(mem_mileage),2)
from member
group by mem_job
order by 2 desc;

select mem_job
    ,round( avg(mem_mileage),2) as 평균마일리지
from member
group by mem_job
having round( avg(mem_mileage),2)>=3000
order by 2 desc;

---------------------------
-- 직업별 마일리지의 합계 마일리지 전체합계를 출력하시오
select nvl( mem_job,'합계') as 직업
    ,count(mem_id) as 회원수
    ,sum(mem_mileage) as 합계
from member
group by rollup(mem_job); --롤업 말아올린다는 뜻으로 집계 결과의 합을 출력함, 총합이 필요할때 사용

--products 상품테이블의 카테고리별 상품수와 전체 상품 수를 출력하시오

desc products;

select *
from products;

select nvl(prod_category,'합계') as카테고리
    ,prod_subcategory as 서브카테고리
    ,count(prod_id) as 상품수
from products
group by rollup(prod_category,prod_subcategory);

select cust_id
, cust_name
, cust_gender
,cust_year_of_birth
from customers;

-- 년도별 회원수를 출력하시오 단(남, 녀 구분하여서)  -->하나의 컬럼으로 남녀가 있는데 두개의 컬럼을으로 나눠준다.
select cust_year_of_birth
, sum(Decode(CUST_GENDER,'M',1,0)) as 남자
, sum(Decode(CUST_GENDER,'F',1,0)) as 여자
from customers
group by rollup(cust_year_of_birth)
order by 1;


--지역과 각 년도별 대출 총잔액을 구하는 쿼리를 작성해보자(kor_loan_staus)

select *
from kor_loan_status;

select region
, sum(decode(substr (period,1,4),'2011',loan_jan_amt)) as AMT_2011
, sum(decode(substr (period,1,4),'2012',loan_jan_amt)) as AMT_2012
, sum(decode(substr (period,1,4),'2013',loan_jan_amt)) as AMT_2013
from kor_loan_status
group by rollup(region);