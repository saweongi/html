import sqlite3   #설치없이 사용 가능함(파이썬 탑재 db) --> 경량 db, 파일 형태

# 파일로 만들지 않고 일회성으로 사용할때는 memory:
#conn = sqlite3.connect(":memory:") #일회성으로 사용하게 연결(파일 생성 없이 메모리에만 저장할때)
conn = sqlite3.connect("mydb.db") #mydb.db 파일이 없을시 생성 하여 연결 있으면 그냥 연결
print(sqlite3.version) #버전 확인

#테이블 생성을 sql 에 담음
sql = """CREATE TABLE stocks(
            strock_cdoe VARCHAR2(20)
            ,stock_kr VARCHAR2(100)
            ,stock_en VARCHAR2(100)
            );
"""
sql = "SELECT * FROM stocks"
cur = conn.cursor() #sql을 사용 할수 있게 작업환경을 제공한다
cur.execute(sql) #sql에 담긴 것을 실행하게해준다.
row = cur.fetchall() #전체 조회결과
print(row)
conn.close()