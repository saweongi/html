/*
 숫자 타입(number)
 number(p, s) p는 소수점을 기준으로 모든 유효숫자 자릿수를 의미함.
              s는 소수점 자릿수를 의미함. (s는 디폴트 0)
              s가 2이면 소수점 2자리 까지 반올림.
              s가 음수 이면 소수점 기준 왼쪽 자리수만큼 반올림
*/

-- 테이블 삭제
drop table ex3_1;

--테이블 기본 속성정보 조회(컬럼명,타입,사이즈)
desc ex3_1;
create table ex3_1(
    num1 number(3),    --정수3자리
    num2 number(3,2),  -- 전체 정수 1자리 소수점 2자리
    num3 number(5,-2),   -- 십의 자리까지 반올림 총 (7자리)
    num4 number
);

insert into ex3_1 (num1) values(0.7898);
insert into ex3_1 (num1) values(99.5);
insert into ex3_1 (num1) values(1004);    --오류

select *
from ex3_1;
insert into ex3_1 (num2) values(0.7898);
insert into ex3_1 (num2) values(1.2345);
insert into ex3_1 (num2) values(32);   --오류

insert into ex3_1 (num3) values(12345.2345);
insert into ex3_1 (num3) values(123459.2345);
insert into ex3_1 (num3) values(12345679.2345);   --오류 전체 7자리

/*
날짜 데이터 타입 (date(년월일시분초), timestamp(년월일시분초밀리초))
*/
create table ex3_2(
    datel date
    ,date2 timestamp
 );
 
 -- sysdate 현재시간
 INSERT INTO ex3_2 values (sysdate, systimestamp);
 
 select *
 from ex3_2;
 
create table ex3_3(
    user_id varchar2(100)
    ,create_dt date default sysdate
);
insert into ex3_3 (user_id) values('a001');
select *
from ex3_3;

/*
    제약조건
    not null 널을 허용하지 않겠다.
    unique 중복을 허용하지 않겠다.
    check 특정데이터만 받겠다
    primary key 기본키(하나의 테이블 1개만 설정가능)
                한 행을 구분하는 식별자로 사용 pk로 설정하면 unique&not null 적용됨
    foreign key 외래키 다른테이블의 pk를 참조하는 키 
 */
 create table ex3_4(
        mem_id varchar2(100) not null unique
        , mem_nm varchar2(100)
        , mem_email varchar2(100) not null
        , constraint uq_ex3_4 unique(mem_email)
);
insert into ex3_4(mem_id, mem_email) values('a001', 'a001@gmail.com');
insert into ex3_4(mem_id, mem_email) values('a001', 'a001@gmail.com'); --오류 unique
insert into ex3_4(mem_nm) values('팽수'); -- 오류 id,eamil notnull
select * from ex3_4;
select*
from user_constraints
where constraint_name like '%EX%';

--check제약조건
create table ex3_5(
nm varchar2(100)
,age number
,gender varchar2(1)
,CONSTRAINT ck_ex3_5_age check(age between 1 and 150)
,CONSTRAINT ck_ex3_5_gender check(gender in('F','M'))
);
insert into ex3_5 values ('팽수', 10, 'M');
insert into ex3_5 values ('팽수', 10, 'A'); -- 오류 F or M check
insert into ex3_5 values ('팽수', 151, 'M'); -- 오류 age 사이즈
select * from ex3_5;

/*
    foreing key 사용시 참조하는 테이블의 컬럼은 기본키로 정의 되어있어야함.
    primary key는 한 테이블에 1개, key의 구성은 1 ~n개로 복합키로 설정가능  
*/
CREATE TABLE dep(
    deptno NUMBER(3) CONSTRAINT dep_pk_deptno PRIMARY KEY ,
    deptname VARCHAR2(20) ,
    floor NUMBER(5)
);

CREATE TABLE emp(
    empno NUMBER(5) CONSTRAINT emp_pk_employee PRIMARY KEY ,
    empname VARCHAR2(20) ,
    title VARCHAR2(20) ,
    dno NUMBER(3) CONSTRAINT emp_fk_dno REFERENCES dep(deptno),
    salary NUMBER(10)
);
COMMIT;

INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (1, '영업', 8);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (2, '기획', 10);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (3, '개발', 9);


INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (2106, '김창섭', '대리', 2, 2000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3426, '박영권', '과장', 3, 2500000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3011, '이수민', '부장', 1, 3000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (1003, '조민희', '대리', 1, 2000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3427, '최종철', '사원', 3, 1500000);

--물리적으로 반영
commit;

--취소 (commit 을하면 롤백을 못함) 인설트부분이 이상하게 넣었으면 쓰는거
rollback;


select *
from emp;
select *
from dep;

-- 참조하고 있는 테이블 있기 때문에 그냥drop은안됨  
--제약 조건 제거 후 테이블 삭제
drop table dep cascade constraints;

--데이터는 참조 하고있는 것부터 넣어주고 참조받는대상을 넣을수있다.


select emp.empname -- 저장한 데이터 명이 다르면 그냥써도 된다 empname처럼
    , emp.title
    , dep.deptname
from emp, dep 
where emp.dno = dep.deptno -- join 뒤에서 배울내용 테이블간 관계를 맺는방법
and emp.empname = '이수민';

drop table TB_INFO cascade constraints;
CREATE TABLE TB_INFO(
   INFO_NO NUMBER(3)  not null
   , PC_NO VARCHAR2(10)  not null unique
    , NM VARCHAR2(20)
    , EMAIL VARCHAR2(50)
    , HOBBY VARCHAR2(1000)
    , MBTI VARCHAR2(4)
);

SELECT *
from tb_info



