SELECT department_id

        -- level 가상열로서 트리 내에서 어떤 단계인지 나타내는 정수값
    ,LPAD(' ',3*(level -1)) || department_name as 부서명
    ,parent_id
    ,level
FROM departments
START WITH parent_id IS NULL                --시작
CONNECT BY PRIOR department_id = parent_id; -- 계층을 어떻게 연결할지(조건)

-- departments 테이블에 230 IT헬프데스크 하위 부서로
--                    280     IT원격팀을 삽입해주세요
INSERT INTO departments(department_id,department_name,parent_id) VALUES(280,'IT원격팀',230);

/*계층형 쿼리에서 정렬을 하려면 SIBLINGS BY를 추가해야함(트리구조를 안깨고 정렬)*/
SELECT department_id

        -- level 가상열로서 트리 내에서 어떤 단계인지 나타내는 정수값
    ,LPAD(' ',3*(level -1)) || department_name as 부서명
    ,parent_id
    ,level
FROM departments
START WITH parent_id IS NULL                --시작
CONNECT BY PRIOR department_id = parent_id
ORDER SIBLINGS BY department_name; --SIBLINGS 사용시에는 실제 컬럼으로만 정렬가능(부서명 사용불가)

--계층관련 함수
SELECT department_id

        -- level 가상열로서 트리 내에서 어떤 단계인지 나타내는 정수값
    ,LPAD(' ',3*(level -1)) || department_name as 부서명
    ,parent_id
    ,level
    , CONNECT_BY_ISLEAF --마지막노드면1, 자식이 있으면 0 
    , SYS_CONNECT_BY_PATH(department_name, '>')-- 루트 노드에서 자신행까지 연결정보 '>'로 표시
    , CONNECT_BY_ISCYCLE --무한루프의 원인을 찾을때(자식이 있는데 그자식 로우가 부모이면 1, 아니면 0)
FROM departments
START WITH parent_id IS NULL                --시작
CONNECT BY NOCYCLE PRIOR department_id = parent_id; 

--직원간의 계층관계를 출력하시오(정렬 직원명 이름 오름차순)
SELECT employee_id
     ,LPAD(' ',3*(level -1)) || emp_name as 직원명
     ,manager_id
     ,level
      , SYS_CONNECT_BY_PATH(emp_name, '>') as 관리관계
FROM employees
START WITH MANAGER_ID IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY emp_name;
desc employees;

drop TABLE sa;
CREATE TABLE sa(
    sa_id NUMBER(6)
    ,sa_name VARCHAR2(40)
    ,sa_class VARCHAR2(20)
    ,sa_topid NUMBER(6)
);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(1,'이사장','사장',null);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(2,'김부장','부장',1);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(3,'서차장','차장',2);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(4,'장과장','과장',3);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(5,'박과장','과장',3);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(6,'이대리','대리',4);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(9,'최사원','사원',6);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(10,'강사원','사원',6);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(7,'김대리','대리',5);
INSERT INTO sa(sa_id,sa_name,sa_class,sa_topid) VALUES(11,'주사원','사원',7);
SELECT sa_name
     ,LPAD(' ',3*(level -1)) || sa_class as 직원명
     ,sa_topid
     ,level
FROM sa
START WITH sa_topid IS NULL
CONNECT BY PRIOR sa_id = sa_topid;



select period
    ,sum(loan_jan_amt) as 대출합계
from kor_loan_status
where substr(period, 1, 4) = 2013
group by period;

/* level은 가상-열로서 (connect by 절과 함께 사용)
    임의의 데이터가 필요할때 많이사용.
*/
SELECT level || '월'
FROM dual
CONNECT BY LEVEL <=12;

-- 2013년 1 ~12월 데이터
SELECT '2013' || LPAD(level,2,'0') as 년월
FROM dual
CONNECT BY LEVEL <=12;



SELECT a.년월
  ,NVL( b.대출합계,0) as 대출합계
FROM(
    SELECT '2013' || LPAD(level,2,'0') as 년월
    FROM dual
    CONNECT BY LEVEL <=12
) a
, (
    select period as 년월
    ,sum(loan_jan_amt) as 대출합계
    from kor_loan_status
    where substr(period, 1, 4) = 2013
    group by period
)b
where a.년월 = b.년월(+)
order by 1;

--202301~202312
SELECT substr(To_char(sysdate,'YYYY') || LPAD(level,2,'0'),5,6)||'월' as 년월
FROM dual
CONNECT BY LEVEL <=12;

SELECT To_char(sysdate,'YYYYMM')|| LPAD(level,2,'0') as 년월일
FROM dual
CONNECT BY LEVEL <= substr(last_day(sysdate),7,8);


SELECT substr(To_char(sysdate,'YYYY') || LPAD(level,2,'0'),5,6) as 년월
    FROM dual
    CONNECT BY LEVEL <=12;


--2023년 1월~12월 데이터
select *
from kor_loan_status;
SELECT a.년월
  ,NVL( b.대출합계,0) as 대출합계
FROM(
    SELECT '2013' || LPAD(level,2,'0') as 년월
    FROM dual
    CONNECT BY LEVEL <=12
) a
, (
    select period as 년월
    ,sum(loan_jan_amt) as 대출합계
    from kor_loan_status
    where substr(period, 1, 4) = 2013
    group by period
)b
where a.년월 = b.년월(+)
order by 1;

-- member 회원의 생일(mem_bir) 의 월별 회원수를 출력하시오(모든월이 나오도록)

select *
from member;
desc member;

select to_char(mem_bir,'mm') as 생일_월
   ,count(to_char(mem_bir,'mm')) as 회원수
from member
group by to_char(mem_bir,'mm')
order by 1;

select nvl(a.생일_월,'합계')  as 생일_월
   ,sum(nvl(b.회원수,'0')) as 회원수
from (SELECT substr(To_char(sysdate,'YYYY') || LPAD(level,2,'0'),5,6) || '월' as 생일_월
FROM dual
CONNECT BY LEVEL <=12) 
a,
(select to_char(mem_bir,'mm') || '월' as 생일_월
   ,count(to_char(mem_bir,'mm')) as 회원수
   from member
   group by to_char(mem_bir,'mm')
   
) b
where a.생일_월= b.생일_월(+)
group by rollup(a.생일_월)
order by 1;




