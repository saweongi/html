/*
 공백제거 TRIM : 양쪽, LTRIM : 왼쪽, RTRIM: 오른쪽
 문자열 길이 맞추기   LPAD : 왼쪽부터 , RPAD : 오른쪽부터
 */
 
SELECT LTRIM('   ABC   ')
        ,RTRIM('   ABC   ')
        , TRIM('   ABC   ')
FROM dual;

--LPAD(1, 5, '0') -> 00001 입력이 50이면 ->00050
SELECT LPAD(123, 5, '0')
    ,LPAD(12310, 5, '0')
    ,LPAD(1, 5, '0')
    ,LPAD(111111, 5, '0')  --주의 출력이 무조건 2번째 매개변수 길이 만큼(데이터가 짤릴 수 있음)
    ,RPAD(1, 5,'0')
FROM dual;
-- ** REPLACE
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는','너를') rep 
 ,TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') trn  -- 나는 이라고쓰면 나 를 먼저 찾아서 너로 바꺼주고 는 을 찾아서 를로 바꿔준다 
FROM dual;

-- LENGTH 문자열길이, LENGTHB 크기
SELECT LENGTH('대한민국')
, LENGTHB('대한민국') -- 대한민국을 바이트로 출력해준다(한글은 한개당 1바이트)
, LENGTH('1234')   
, LENGTHB('1234')  -- 영문,숫자 는 1바이트
FROM dual;  

/*날짜 함수*/
SELECT SYSDATE
    , SYSTIMESTAMP   --현재시간
FROM dual;

-- ADD_MONTHS 월을 추가하거나 뺄 수 있다.
SELECT ADD_MONTHS(SYSDATE,1)
 ,ADD_MONTHS(SYSDATE, -1)
 FROM dual;
 
 --LAST DAY,NEXT_DAY
 SELECT LAST_DAY(SYSDATE)  -- 달의 마지막 
  ,NEXT_DAY(SYSDATE, '금요일') --해당 기준으로 금요일 이면 담주 금요일 
  ,NEXT_DAY(SYSDATE, '토요일') -- 해당 주의 토요일
  , SYSDATE +1 -SYSDATE as days
  , SYSDATE -2
FROM dual;

--이번달은 몇일 남았을까요?
 SELECT (LAST_DAY(SYSDATE) - SYSDATE) ||'일' as D_DAY
 FROM dual;
 
 /* 숫자함수 (매개변수 숫자형)
    ABS: 절대값
    ROUND 반올림
    TRUNC 버림
 */
 SELECT ABS(-10)
    ,ABS(10)
    ,ROUND(10.155, 1)
    ,ROUND(10.155, 2)
    ,ROUND(10) -- 디폴트 0
    ,TRUNC(114.999, 1)
FROM dual;

/* MODE(m ,n) m을 n으로 나누었을때 나머지 반환 */
-- SQRT 제곱근 반환
SELECT MOD(4,2)
 ,MOD(5,2)
 ,SQRT(4)
FROM dual;

/*변환 TO_CAHR : 문자형으로 , TO_NUMBER : 숫자형으로, TO_DATE : 날짜형으로 */
    SELECT TO_CHAR(1234566, '999,999,999')
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD')
    , TO_CHAR(SYSDATE, 'YYYYMMDD')
    , TO_CHAR(SYSDATE, 'YYYYMMDD HH:MI:SS')
    , TO_CHAR(SYSDATE, 'YYYYMMDD HH24:MI:SS')
     , TO_CHAR(SYSDATE, 'day')
     , TO_CHAR(SYSDATE, 'dd')
     , TO_CHAR(SYSDATE, 'd') --요일을 숫자로 반환
FROM dual;

SELECT TO_DATE('230713', 'YYMMDD')
    --TO_DATE는 날짜 데이터타입으로 형변환
    --입력 포맷과 동일하게 표현해야 DATE로 바뀜
 ,TO_DATE('2023 08 12 10:00:00', 'YYYY MM DD HH24:MI:SS')
FROM dual; 

CREATE TABLE tb_myday(
    title VARCHAR2(200)
    ,d_day DATE
);
INSERT INTO tb_myday VALUES ('종료일','20231226');
INSERT INTO tb_myday VALUES ('종료일','2023.12.26');
INSERT INTO tb_myday VALUES ('종료일','23.12.26');
INSERT INTO tb_myday VALUES ('종료일','23|12|26');
INSERT INTO tb_myday VALUES ('종료일','23|12|26 18');
INSERT INTO tb_myday VALUES ('종료일',TO_DATE('231226 18','YYMMDD HH24'));

CREATE TABLE ex5_1(
seq VARCHAR2(100)
,seq2 NUMBER
);
INSERT INTO ex5_1 VALUES('1234','1234');
INSERT INTO ex5_1 VALUES('99','99');
INSERT INTO ex5_1 VALUES('123456','123456');
SELECT *
FROM ex5_1
ORDER BY TO_NUMBER(seq) DESC;

SELECT *
FROM students;
-- students 테이블을 활용하여 학번,학생이름,나이를 출력하시오
desc students;



desc customers;
SELECT  cust_name,cust_year_of_birth, TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - cust_year_of_birth as cust_year_AGE -- 그냥 문자 형식이랑 숫자형식이 맞으면 빼주면 계산이된다.
FROM  customers
ORDER BY cust_year_AGE;

-- RR은 입력된 두자리 연도 값이 50 ~이상이면 20세기로 해석
--                          49이하면 21세기로 해석.
SELECT stu_name, TO_DATE(stu_birth,'YYMMDD')
, TO_CHAR(TO_DATE(stu_birth, 'YYMMDD'),'YYYY')
, TO_DATE(stu_birth, 'RRMMDD')
, TO_CHAR(TO_DATE(stu_birth, 'RRMMDD'),'YYYY')
FROM students;

--employees의 hire_date 컬럼을 활용하여 근속 난수를 출력하시오.
desc employees;

SELECT emp_name,hire_date, TO_CHAR(SYSDATE, 'YYYY') -TO_CHAR(hire_date, 'YYYY') AS 근속연수
from employees
ORDER BY 근속연수 desc,1;

-- null관련 null이랑 값을 곱하면 null이 나오기때문에 null관련함수 nvl로 치환해줘서 사용한다
-- **NVL(null,변환값)
SELECT emp_name,salary, commission_pct
,salary * NVL(commission_pct,0)
FROM employees;

--DECODE 변환 (case와 유사함)
SELECT cust_id, cust_name

        -- 대상건    ,값, 같으면, 그밖에
    , DECODE(cust_gender, 'M','남자','여자') AS gender
    
        -- 대상건      ,값,같으면 , 값2, 같으면 , 그밖에
    , DECODE(cust_gender, 'M','남자','F','여자','??') AS gender2
FROM customers;

/*
고객 테이블(CUSTOMERS)에는
고객의 출생년도( CUST_YEAR_OF_BIRTH) 컬럼이있다.
현재일 기준으로 이컬럼을 활용해 30대 , 40대, 50대를 구분해 출력하고, 나머지 연령대는 '기타로 출력하는 쿼리를 작성해보자
*/
desc CUSTOMERS;

SELECT  cust_name,cust_year_of_birth, DECODE(substr(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - cust_year_of_birth,1,1),'3','30대','4','40대','5','50대','기타') as cust_year_AGE
FROM  customers
order by cust_year_of_birth desc;
