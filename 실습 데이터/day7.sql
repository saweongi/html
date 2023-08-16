SELECT *
FROM employees;

SELECT *
FROM departments;

-- inner join 내부조인(동등조인이라고도 함)
-- 각 컬럼에 동일한 값이 있을때 결합
SELECT employees.emp_name, departments.department_name
FROM employees, departments
where employees.department_id = departments.department_id;

--테이블 별칭
SELECT emp_name, b.department_name -- 어느한쪽에만 있는 컬럼은 별칭 안써도됨(테이블중에 하나만 있을경우는 그냥 쓸수 있고 테이블중에 둘다 있으면 별칭을써줘야 오류가안난다)
FROM employees a, departments b    -- as안쓰고  띄어쓰기로 해서 별칭을 한다
where a.department_id = b.department_id;


SELECT *
FROM member;
SELECT *
FROM cart;
--member 김은대씨의 카트(구매이력)이력을 출력하시오
SELECT mem_name,cart_no,cart_prod,cart_qty
FROM member a,cart b
WHERE a.mem_id = b.cart_member and  a.mem_name ='김은대';

/*ANSI JOIN : American National Standards Institute
              미국 표준 SQL 문법 형태 (구문이 길어서 실무에서 잘안씀)
              위랑 같은 코드인데 미국 표준 으로 바꾼거임
*/
SELECT member.mem_name
    ,cart.cart_no
    ,cart.cart_prod
    ,cart.cart_qty
FROM member
INNER JOIN cart
ON(member.mem_id = cart.cart_member)
WHERE member.mem_name = '김은대';

--상품 정보 출력
select*
from cart;

select*
from prod;

SELECT mem_name,cart_no,cart_prod,cart_qty,prod.prod_name,prod.prod_sale
FROM member a,cart b,prod
WHERE a.mem_id = b.cart_member 
and b.cart_prod = prod.prod_id 
and a.mem_name ='김은대'; 

-- 김은대씨가 구매한 전체 상품의 합계 금액은?  그룹바이를 쓸때 그 그룹으로 될것이 셀렉트와 그룹바이에 표현되어야하고 표현하고싶은것을 하나로 묶을때 사용한다.
SELECT mem_name,mem_id,sum(prod.prod_sale * b.cart_qty) as 합계금액
FROM member a,cart b,prod
WHERE a.mem_id = b.cart_member 
and b.cart_prod = prod.prod_id 
and a.mem_name ='김은대'
group by mem_name, mem_id;

-- 원래의 표현식(ansi join 표현법)
SELECT mem_name,mem_id,sum(prod.prod_sale * cart.cart_qty) as 합계금액
FROM member INNER JOIN cart
ON(member.mem_id = cart.cart_member)
INNER JOIN prod
ON (cart.cart_prod = prod.prod_id)
WHERE member.mem_name ='김은대'
GROUP BY member.mem_name, member.mem_id;

--employees, jobs 테이블을 활용하여
-- salary가 15000 이상인 직원의 사번, 이름, salary, 직업 아이디 ,직업명을 출력하시오
SELECT *
FROM employees;

select *
FROM JOBS;

select  employees.employee_id
        ,employees.emp_name
        ,employees.salary
        ,employees.job_id
        ,jobs.job_title
from employees ,jobs 
where employees.job_id = jobs.job_id
    and employees.salary >=15000;
    
/* 서브쿼리 (쿼리 안에 쿼리)
  1.스칼라 서브쿼리 (select 절)
  2.인라인 뷰 (from절)
  3.중첩 쿼리 (where절)
*/
-- 스칼라 서브쿼리는 단일행 반환(1대 1 맵핑 될때만 사용)
-- 보통 코드값에 이름을 가져올때 많이 사용
-- 주의할점은 메인 쿼리테이블의 행 건수 만큼 서브쿼리를 조회하기 때문에
-- 서브쿼리의 테이블의 건수가 많으면 자원을 많이 사용하게됨.
-- (위와 같은 경우 조인을 이용하는게 더 좋음)
SELECT a.emp_name
    , (SELECT department_name
        FROM departments
        where department_id = a.department_id)  as dep_name
    ,a.job_id
    ,(SELECT job_title
     FROM jobs
     WHERE job_id = a.job_id) as job_name
FROM employees a;

--중첩서브 쿼리
--전체 직원의 봉급 평균 보다 봉급이 큰 직원만 출력하시오
--쓰는이유는 어떠한 조건을 구해서 그것을 사용하기 위해서 아래는 평균값을 구해서 그것을쓸려고(특정값을 찾아서 그것을 값에 사용한다)
--동적으로 값을 가져오고싶을때
SELECT emp_name
    , salary
    FROM employees
where salary >=(select AVG(salary)
                FROM employees);
                

--동시에 2개이상의 컬럼 값이 같은 껀 조회
select employee_id, emp_name, job_id
FROM employees
where (employee_id, job_id) in (select employee_id, job_id
                                from job_history);
                                
SELECT *
FROM member;

SELECT cart_member
FROM cart;

-- cart사용 이력이 없는 회원을 조회하시오
SELECT *
FROM member
WHERE mem_id NOT IN(SELECT cart_member
                    from cart);
                    
-- member 중에서 전체 회원의 마일리지 평균값 이상인 회원만 조회하시오
SELECT mem_name,mem_job,mem_mileage
FROM member
where mem_mileage >= (select avg(mem_mileage)
                    from member)
order by mem_mileage desc;

CREATE TABLE 강의내역 (
     강의내역번호 NUMBER(3)
    ,교수번호 NUMBER(3)
    ,과목번호 NUMBER(3)
    ,강의실 VARCHAR2(10)
    ,교시  NUMBER(3)
    ,수강인원 NUMBER(5)
    ,년월 date
);

CREATE TABLE 과목 (
     과목번호 NUMBER(3)
    ,과목이름 VARCHAR2(50)
    ,학점 NUMBER(3)
);

CREATE TABLE 교수 (
     교수번호 NUMBER(3)
    ,교수이름 VARCHAR2(20)
    ,전공 VARCHAR2(50)
    ,학위 VARCHAR2(50)
    ,주소 VARCHAR2(100)
);

CREATE TABLE 수강내역 (
    수강내역번호 NUMBER(3)
    ,학번 NUMBER(10)
    ,과목번호 NUMBER(3)
    ,강의실 VARCHAR2(10)
    ,교시 NUMBER(3)
    ,취득학점 VARCHAR(10)
    ,년월 DATE 
);

CREATE TABLE 학생 (
     학번 NUMBER(10)
    ,이름 VARCHAR2(50)
    ,주소 VARCHAR2(100)
    ,전공 VARCHAR2(50)
    ,부전공 VARCHAR2(500)
    ,생년월일 DATE
    ,학기 NUMBER(3)
    ,평점 NUMBER
);


COMMIT;

ALTER TABLE 학생 ADD CONSTRAINT pk_학생 PRIMARY KEY(학번);
ALTER TABLE 수강내역 ADD CONSTRAINT pk_수강내역 PRIMARY KEY(수강내역번호);
ALTER TABLE 과목 ADD CONSTRAINT pk_과목 PRIMARY KEY(과목번호);
ALTER TABLE 교수 ADD CONSTRAINT pk_교수 PRIMARY KEY(교수번호);
ALTER TABLE 강의내역 ADD CONSTRAINT pk_강의내역 PRIMARY KEY(강의내역번호);


ALTER TABLE 수강내역 ADD CONSTRAINT FK_학생_학번 FOREIGN KEY(학번) REFERENCES 학생(학번);
ALTER TABLE 수강내역 ADD CONSTRAINT FK_과목_과목번호 FOREIGN KEY(과목번호) REFERENCES 과목(과목번호);
ALTER TABLE 강의내역 ADD CONSTRAINT FK_교수_교수번호 FOREIGN KEY(교수번호) REFERENCES 교수(교수번호);
ALTER TABLE 강의내역 ADD CONSTRAINT FK_과목_강의과목번호 FOREIGN KEY(과목번호) REFERENCES 과목(과목번호);
 






