/* TABLE 수정 ALTER
*/

CREATE TABLE ex4_1(
    irum VARCHAR2(100) NOT NULL
    ,point NUMBER(5)
    ,gender CHAR(1)
    ,reg_date DATE
);
DESC ex4_1;

-- 컬럼명 수정
alter table ex4_1 rename column irum TO nm;

--타입수정(타입 수정시 테이블에 데이터가 있다면 주의해야함)
ALTER TABLE ex4_1 MODIFY point NUMBER(10)

--제약 조건 추가
ALTER TABLE ex4_1 ADD CONSTRAINT pk_ex4 PRIMARY KEY(nm);

--컬럼 추가
ALTER TABLE ex4_1 ADD hp VARCHAR2(20);

--컬럼 삭제
ALTER TABLE ex4_1 DROP COLUMN hp;

---------------------- 테이블 comment
COMMENT ON TABLE tb_info IS '우리반';
COMMENT ON COLUMN tb_info.info_no IS '출석번호';
COMMENT ON COLUMN tb_info.pc_no IS '컴퓨터번호';
COMMENT ON COLUMN tb_info.nm IS '이름';
COMMENT ON COLUMN tb_info.email IS '이메일';
COMMENT ON COLUMN tb_info.hobby IS '취미';
COMMENT ON COLUMN tb_info.mbti IS '브릭스';
select *
from all_tab_comments  --테이블 코멘트
WHERE OWNER ='JAVA';

SELECT *
FROM all_col_comments  --테이블 컬럼 코멘트
WHERE comments LIKE '%이름%';

/* INSERT 데이터 삽입 (DML문)

*/
CREATE TABLE ex4_2(
    val1 VARCHAR2(1)
    ,val2 NUMBER
    ,VAL3 DATE
);

--입력 컬럼을 다 작성
INSERT INTO ex4_2 (vall, val2, val3)
VALUES ('hi', 10, SYSDATE);  --문자열 ''   NUMBER타입은 숫자
INSERT INTO ex4_2(val3, val2)
VALUES (SYSDATE,10);      -- 위에 작성한 컬럼 순서대로
                          -- value도 INSERT
SELECT * FROM ex4_2;
--테이블 전체에 대해 데이터를 삽입할때는 컬럼명 안써도됨

INSERT INTO ex4_2
VALUES ('hello', 20, SYSDATE);
INSERT INTO ex4_2
VALUES ('hello', 20, SYSDATE);
INSERT INTO ex4_2
VALUES (20, SYSDATE);  --오류

create table ex4_3(
emp_id number
,emp_name varchar2(1000)
);

-- SELECT - INSERT
INSERT INTO ex4_3(emp_id, emp_name)
SELECT employee_id
    , emp_name
FROM employees
WHERE salary > 5000;

select * from ex4_3;

--테이블 복사
create table ex4_4 as
select nm, email
from tb_info;
select *
from ex4_4;

// update 테이터 수정

select *
from tb_info;
update tb_info
set hobby = '공부'
    ,email = 'abc@mail.com'
WHERE INFO_NO =1;



delete ex4_4;  --전체삭제

delete ex4_4
where nm ='예준서';

-- 중복제거 데이터 보기
select distinct prod_category
from products;

-- 의사컬럼 (테이블에는 없지만 있는것 처럼 사용) ,오라클에만 있음
select  rownum ,emp_name
    ,email
from employees
where rownum <=10;  // 누구를 특정 지을수 없다 =5 이런거
-- NULL (IS NULL or IS NOT NULL)
select *
from employees
where manager_id IS NULL;

select *
from departments
where department_id IN (30,60);
select *
from departments
where department_id not IN (30,60);

/*
oracle 데이터베이스 내장함수
문자관련 
*/
select lower('I like mac') as lowers
    , UPPER('I like mac') as uppers
    , INITCAP('I like mac') as initcaps --단어 첫글자 대문자
from dual;  --임시테이블

select *
from employees
where upper(emp_name) like '%' || upper ('Donald') ||'%';

-- substr (char, pos, len) 대상문자열 char의 pos 번째부터
-- len 길이 만큼 자른뒤 반환
-- pos 값으로 0 이오면 디폴트 값 1 즉 첫번째 문자열
-- 음수가 오면 문자열의 맨 끝에서 시작한 상대적 위치
-- len 값이 생략되면 pos 번째 문자부터 나머지 모든 문자를 반환
select substr('ABCD EFG',1, 4)
    , substr('ABCD EFG',-3, 3)
    , substr('ABCD EFG',-3, 1)
    , substr('ABCD EFG',5)
from dual;

/* INSTR 대상 문자열에서 찾을 문자열의 위치 */
select instr('내가 만약 외로울 때면, 내가 만약 괴로울 때면', '만약') --디폴트 1,1
        ,instr('내가 만약 외로울 때면, 내가 만약 괴로울 때면', '만약',5)
        ,instr('내가 만약 외로울 때면, 내가 만약 괴로울 때면', '만약',1,2)
        ,instr('내가 만약 외로울 때면, 내가 만약 괴로울 때면', '나') --없으면 0나옴
from dual;

--고객의 이메일 주소의 이름과 도메인을 분리하여 출력하시오
-- ex leeapgil@gmail.com -> id : leeapgil, domain:gmail.com
select cust_name
    , cust_email
from customers;

select  substr(cust_email,1,instr(cust_email,'@')-1)
    ,substr(cust_email,instr(cust_email,'@')+1)
from customers;


select nm
 ,MBTI
from tb_info;




