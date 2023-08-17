SELECT 'Oracle',
    LPAD('Oracle',10,'#') AS LPAD_1,
    rpad('Oracle',10,'*') AS RPAD_2,
    LPAD('Oracle',10) AS LPAD_2,
    RPAD('Oracle',10) AS RPAD_2
    FROM DUAL;
    
    
SELECT
    RPAD('971225-',14,'*') AS RPAD_JMNO,
    RPAD('010-1234-',13,'*')AS RPAD_PHONE
    FROM DUAL;
    

SELECT CONCAT(EMPNO, ENAME),
CONCAT(EMPNO, CONCAT(' : ',ENAME))
FROM EMP
WHERE ENAME = 'SCOTT';

SELECT '[' || TRIM(' _ _Oracle_ _ ') || ']' AS TRIM,
       '[' || TRIM(LEADING FROM ' _ _Oracle_ _ ') || ']' AS TRIM_LEADING,
       '[' || TRIM(TRAILING FROM ' _ _Oracle_ _ ') || ']' AS TRIM_TRAILING,
       '[' || TRIM(BOTH '_' FROM '_ _Oracle_ _') || ']' AS TRIM_BOTH
       FROM DUAL;
       
SELECT '[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
       '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
       '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
       '[' || LTRIM('<_Oracle_>', '_<') || ']' AS LTRIM,
       '[' || RTRIM('<_Oracle_>', '_>') || ']' AS RTRIM
    FROM DUAL;