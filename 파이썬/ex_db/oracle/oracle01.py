#pip install cx_Oracle
import cx_Oracle
conn = cx_Oracle.connect("java", "oracle", "localhost:1521/xe") #오라클에 자바라는것에 연결한다 주소는 3번째꺼
print(conn.version)

sql="""
    SELECT *
    FROM member
    WHERE mem_name LIKE '%' || :word || '%'
    ORDER BY mem_name ASC
"""

nm = input("검색하고 싶은 고객명 입력:")
d= { "word": nm}
with conn:
    cur = conn.cursor() #sql작업환경을 사용 할 수 있게 해준다
    rows = cur.execute(sql, d) #sql을 실행한다
    for row in rows:
        print(row)