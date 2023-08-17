-- inner JOIN 내부조인(동등조인)
SELECT *
FROM 학생;
SELECT *
FROM 수강내역;

select *
from 과목;

SELECT 학생.학번 -- 둘다 있으면 앞에 테이블 꺼를 붙여주지만 하나씩 가지고 있으면 안써줘도됨
    ,이름
    ,전공
    ,수강내역번호
    ,수강내역.과목번호
    ,과목.과목이름
FROM 학생,수강내역,과목
where 학생.학번 = 수강내역.학번
AND 수강내역.과목번호 = 과목.과목번호
AND 학생.이름 ='최숙경';

-- 최숙경의 수강 총학점을 출력하시오.
select 학생.학번
    , 학생.이름
    , sum(과목.학점) as 수강학점
from 학생,수강내역,과목
where 학생.학번 = 수강내역.학번
AND 수강내역.과목번호 = 과목.과목번호
AND 학생.이름 ='최숙경'
group by 학생.학번,학생.이름;

/* OUTER JOIN 외부조인
    어느 한쪽에 null 있더라도  값을 포함시켜야 할때
    (보통은 마스터테이블은 무조건 포함시켜야하면 아웃터조인을함)
*/
select 학생.학번
    , 학생.이름
from 학생,수강내역    --null을 포함 시킬 테이블쪽
where 학생.학번 = 수강내역.학번(+) -- (+) <-- 한쪽에만 쓸수 있음(null값 이더라도 포함시키겠다 아웃터 조인) 
AND 학생.이름 ='양지운';

--학생의 수강이력 건수를 출력하시오
-- 모든학생 출력 null이면 0으로 
select 학생.학번
    ,학생.이름
    ,count(수강내역.수강내역번호) as 수강이력건수
from 학생,수강내역
where 학생.학번 = 수강내역.학번(+)
group by 학생학번 ,학생.이름
order by 3 desc;

--학생의 수강이력 건수, 총수강 학점을 출력하시오
select 학생.학번
    ,학생.이름
    ,count(수강내역.수강내역번호) as 수강이력건수
    ,NVL(sum(과목.학점),0) as 총수강학점
from 학생,수강내역,과목
where 학생.학번 = 수강내역.학번(+)
AND 수강내역.과목번호 = 과목.과목번호(+)
group by 학생.학번
        ,학생.이름
order by 3 desc;

SELECT 학생.학번 -- 둘다 있으면 앞에 테이블 꺼를 붙여주지만 하나씩 가지고 있으면 안써줘도됨
    ,이름
    ,전공
    ,수강내역번호
    ,수강내역.과목번호
    ,(select 과목이름 --스칼라 서브쿼리(단일행 사용가능)
    FROM 과목
    where 과목번호 = 수강내역.과목번호) as 과목이름
FROM 학생,수강내역
where 학생.학번 = 수강내역.학번
AND 학생.이름 ='최숙경';

/* 학생의 전공별 인원수를 출력하시오 */
select 전공
    ,count(*) as 학생수
from 학생
group by 전공
order by 2 desc;

/* 학생의 평균평점 보다 높은 학생을 출력하시오 */
select  학번
        ,이름
        ,avg(평점) as평점 
from 학생
where 평점 >(select avg (평점)
            from 학생)
group by 학번,이름
order by 3 desc;

select *
from 학생;

select *
from 수강내역;

-- 수강내역이 없는 학생
select*
from 학생
where 학번 not in(select 학번
                    from 수강내역);

-- 조인으로 만들수있을거같은데
select *
from 학생,수강내역
where 학생.학번 = 수강내역.학번(+);

/* 인라인 뷰 (FROM절)
   select 문의 질의 결과를 마치 테이블처럼 사용 
*/
SELECT *
FROM
(SELECT ROWNUM AS RNUM
        ,학번, 이름, 전공
FROM 학생) a  -- SELECT문을 테이블처럼 사용(ROWNUM은 원래 테이블 값으로 들어가지않는데  인라인뷰로 인해 테이블로 사용하게해서 조건을 검색하게한다)
where a.RNUM BETWEEN 2 AND 5;

select *
from(SELECT ROWNUM AS RNUM
    ,a .*
FROM( SELECT employee_id
    , emp_name
    , salary
FROM employees
WHERE emp_name LIKE 'K%' --안쪽에 조건식이나 오더바이를 먼저쓰는이유는 밖에 쓰면 실행순서가 뒤에있어서 조건이 안맞을수도 있거나 순서가 엉망이된다(rnum을 가장 밖에 써서 순서를 먼저 정렬하고 번호를 주어짐)
ORDER BY emp_name) a
)
where rnum BETWEEN 1 AND 10;

--학생중에 평점 높은 5명만 출력하시오.
select *
from(
        select ROWNUM AS 순위
                ,a.*
        from (select 학생.이름,학생.전공,학생.평점
            FROM 학생
            order by 평점 desc)a 
    )
where 순위  BETWEEN 1 AND 5;


-- MEMBER, CART, PROD 를 사용하여 
-- 고객별 카트사용횟수, 상품품목건수, 상품구매수량, 총구매금액을 출력하시오
-- 구매이력이 없다면 0 <- 으로 출력되도록

SELECT *
FROM MEMBER;

SELECT *
FROM  CART;

SELECT *
FROM  PROD;

SELECT MEMBER.mem_id,
    member.mem_name
    ,  count( DISTINCT cart_no) as 카트사용횟수
    ,count(cart.cart_qty) as 상품품목건수
    ,NVL(sum(cart.cart_qty),0)as 상품구매수량
    , NVL(sum(cart.cart_qty*prod.prod_sale),0) as 구매합산금액

FROM MEMBER, CART, PROD
where member.mem_id = cart.cart_member(+)
and cart.cart_prod =prod.prod_id(+)
group by member.mem_name,MEMBER.mem_id
order by 구매합산금액 desc; 
    





