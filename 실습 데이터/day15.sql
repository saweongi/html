/*
    부서별 직원의 salary가 가장높은 직원을 출력하시오
    
*/
select * from(
select emp_name
    ,salary
    ,department_id
    ,rank() over(partition by department_id order by salary desc ) as rnak
from employees
)
where rnak =1;

--학생중 전공별 평점이 가장 높은 학생의 정보를 출력하시오
select * from(
select 학번,이름,주소,전공,부전공,생년월일,학기,평점,rank() over(partition by 전공 order by 평점 desc ) as rnak
from 학생
)
where rnak=1;

select * from(
select a.*
,rank() over(partition by a.전공 order by a.평점 desc ) as rnak -- 전공에 대해 평점 할때
,rank() over( order by a.평점 desc ) as ALL_rnak --전체에 대해  평점 할때 
, count(*) over() as 전체학생수
, avg(a.평점) over() as 전체평균
from 학생 a
)
where rnak=1;

/*
    로우손실 없이 집계값 산출
    PARTITION BY 에서 window 절을 활용하여 세부 집계를 할 수 있음.
    AVG,  SUM, MAX, MIN, COUNT, RANK, DENSE_RANK, LAG, ROW_BUMBER...
    PARTITION BY 절 : 계산 대상 그룹
    ORDER BY     절 : 대상 그룹에대한 정렬
    WINDOW       절 : 파티션으로 분활된 그룹에 대해 더 상세한 그룹으로 분할
*/

--CART, FROD 물품별 prod_sale 합계의 상위 10등 상품을 출력하시오.
select *
from(
select c.* 
, RANK() OVER(ORDER BY sale_sum desc) as rnk
from(
SELECT a.cart_prod  --상품아이디
    ,b.prod_name    --상품이름

    ,sum(a.cart_qty * b.prod_sale) as sale_sum

from cart a
    ,prod b
where a.cart_prod = b.prod_id
group by  a.cart_prod  --상품아이디
    ,b.prod_name    --상품이름

    )c
)
where rnk<=10;

select *
from(SELECT a.cart_prod, b.prod_name
    ,RANK()OVER(ORDER BY SUM(b.prod_sale * a.cart_qty) DESC) as rnk
    from cart a, prod b
    where a.cart_prod = b.prod_id
    group by a.cart_prod, b.prod_name
    )
where rnk <=10;

/*
    NTILE(expr) 파티션별로 expr 명시된 값만큼 분할한 결과를 반환
    NTILE(3) 1 ~ 3의 수를 반환(분할하는 수를 버킷 수 라고함)
    NTILE(4) -> 100/4 -> 25%로 행을 분할
*/
SELECT emp_name, salary, department_id
 ,NTILE(2) OVER(PARTITION BY department_id ORDER BY salary DESC) group_num
 ,COUNT(*) OVER(PARTITION BY department_id) as 부서직원수
 FROM employees
 WHERE department_id IN(30,50);
 
 --전체 직원의 급여를 10분위로 나우었을때 1분위에 속하는 직원을 조회하시오
 SELECT emp_name, salary
    ,NTILE(10) OVER(ORDER BY salary DESC) as 분위
FROM employees;

SELECT nm
    ,NTILE(6) OVER(ORDER BY DBMS_RANDOM.VALUE) as team
FROM tb_info;

-- 202301 ~ 202312 까지 월 1000건의 데이터 생성
CREATE TABLE tb_sample AS
SELECT ROWNUM as seq
    ,'2023' || LPAD(CEIL(ROWNUM/1000), 2, '0') AS month
    ,ROUND(DMS_RANDOM,VALUE(100, 1000)) as amt
FROM dual
CONNECT BY LEVEL <=12000;
-- 알파벳 대문자 5자리 랜덤생성
SELECT DBMS_RANDOM.STRING('U',5) -- 알파벳 대문자 5자리 랜덤생성
    ,DBMS_RANDOM.STRING('L', 5) -- 소문자
    ,DBMS_RANDOM.STRING('A', 5) -- 대소문자
    ,DBMS_RANDOM.STRING('X', 5) -- 알파벳 대문자 & 숫자
    ,DBMS_RANDOM.STRING('P', 5) -- 대소문자,숫자,특수문자
FROM dual;

/* 주어진 그룹과 순서에 다라 row에 있는 값을 참조할때 사용
 LAG(expr, offset, default_value) 선행로우의 값참조
 LEAD(expr, offset, default)value) 후행로우의 값 참조
*/
SELECT emp_name, department_id, salary
    ,  LAG(emp_name, 1, '가장높음') OVER(PARTITION BY department_id
                                   ORDER BY salary DESC) as emp_lag
    ,  LEAD(emp_name, 1, '가장낮음') OVER(PARTITION BY department_id
                                    ORDER BY salary desc) as emp_lead
FROM employees;

/*
    학생의 평점을 기준으로 한단계 위의 학생의 평점과 차이를 출력하시오
    1등  팽수  4.5 0
    2등  길동  4.3 0.2
    3등  동길  3.0 1.3  
*/
select *
from 학생
order by 평점 desc;

SELECT 학번,이름,ROUND (평점,2) as 평점
    ,LAG(이름,1,'없음') OVER(ORDER BY 평점 DESC ) as 상위학생이름
    ,round(LAG(평점,1,평점) OVER(ORDER BY 평점 DESC ) - 평점,2 )평점차이
    
FROM 학생;

drop table bbs;
CREATE TABLE bbs(
bbs_no NUMBER PRIMARY KEY
,parent_no NUMBER
,bbs_title VARCHAR2(1000) DEFAULT NULL -- 댓글의 경우 NULL
,bbs_content VARCHAR2(4000) NOT NULL
,AUTHOR_ID varchar2(100)
,create_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP --사용자 세션의 시간
,update_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT fk_prent FOREIGN KEY(parent_no) REFERENCES bbs(bbs_no)on DELETE CASCADE --게시글의 no를 참조하고 참조 데이터 삭제시 같이 삭제
 
,CONSTRAINT fk_user FOREIGN KEY(author_id) REFERENCES tb_user(user_id)ON DELETE CASCADE --유저 탈퇴시 같이 삭제
);

-- 게시글번호 시퀀스
drop SEQUENCE bbs_seq;
CREATE SEQUENCE bbs_seq START WITH 1 INCREMENT BY 1;

INSERT INTO bbs(bbs_no,bbs_title, bbs_content, author_id)
VALUES(bbs_seq.NEXTVAL, '공지사항', '오늘은 금요일 입니다.!!!!','a001');
INSERT INTO bbs(bbs_no,bbs_title, bbs_content, author_id)
VALUES(bbs_seq.NEXTVAL, '게시글1', '게시글 1입니다.','b001');
INSERT INTO bbs(bbs_no,parent_no, bbs_content, author_id)
VALUES(bbs_seq.NEXTVAL, 1, '곧 월요일이예요....','x001');
SELECT * FROM bbs;

SELECT level,bbs_no,parent_no,bbs_title,bbs_content,author_id,create_dt,update_dt
FROM bbs
START WITH parent_no IS NULL                --시작
CONNECT BY PRIOR BBS_NO = parent_no;

SELECT *
from bbs
start with bbs_no = 1
CONNECT BY PRIOR BBS_NO = parent_no;

SELECT DECODE(level, 1, '메인글','댓글') as status
    , a.bbs_no as bbs_no
    , LPAD(' ', 3* (level-1)) || a.bbs_content  as bbs_content
    , a.author_id as author_id
    , a.update_dt   as update_dt
FROM bbs a
START WITH bbs_no =1
CONNECT BY PRIOR a.bbs_no = a.parent_no
ORDER SIBLINGS BY update_dt desc;

SELECT *
FROM tb_user;

SELECT *
FROM user_tab_columns
WHERE table_name = 'TB_USER';

SELECT USER_ID
,USER_PW
,USER_NM
,USER_MAIL
,USER_MILEAGE
FROM tb_user
where user_id = 'a001';

INSERT INTO tb_user(user_id,user_nm,user_pw,create_dt)
values (?,?,?, sysdate);
SELECT ROWNUM as rnum
    , count(*) OVER() as all_cnt
    ,a.*
FROM(
SELECT bbs_no
, bbs_title
, author_id
, TO_CHAR(update_dt,'YYMMDD HH24:MI:SS') as update_dt
FROM bbs
WHERE parent_no IS NULL
ORDER BY update_dt DESC
) a
;
select *
from tb_user;
desc tb_user;
select *
FROM bbs;
desc bbs;



SELECT ROWNUM         as rnum     , count(*) OVER() as all_cnt     ,a.bbs_no    as bbs_no     ,a.bbs_title as bbs_title     ,a.author_id as author_id     ,a.update_dt as update_dt FROM(  SELECT bbs_no , bbs_title , author_id , TO_CHAR(update_dt,'YYMMDD HH24:MI:SS') as update_dt FROM bbs WHERE parent_no IS NULL ORDER BY update_dt DESC ) a;