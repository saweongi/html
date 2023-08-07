ALTER SESSION SET "_ORACLE_SCRIPT" =true; 
--예전 스타일로 계쩡만들기 위해 위에꺼를 스크립트에 실행해야함
--실행문은 ; <-- 단위로 인식함
--실행은 ctrl + enter or 위에 버튼

--사용자명 : java, 비밀벉호 : oracle
CREATE USER java IDENTIFIED BY oracle;

--권한 설정
GRANT CONNECT, RESOURCE TO java;

--테이블 스페이스 접근 권한
GRANT UNLIMITED TABLESPACE TO java;