import sqlite3
conn = sqlite3.connect("mydb.db")
cur = conn.cursor()

#insert 하는방법들
#1. insert 문자열로
#2. dict
#3. array or tuple

#1. insert 문자열로 넣는방법
cur.execute(""" INSERT INTO stocks VALUES(3, '비트코인','BT')""")


#2.dict
dic ={"seq":4, "stock_kr":"도지코인", "stock_en":"DOGE"}
cur.execute(""" INSERT INTO stocks VALUES(:seq, :stock_kr, :stock_en)""",dic)

#3. array or tuple
cur.execute(""" INSERT INTO stocks values(?, ?, ?)""",[5, '이더리움','e'])
cur.execute(""" INSERT INTO stocks values(:1, :2, :3)""",[6, '이더리움클래식','ec'])
conn.commit() # 데이터베이스에 저장
conn.close()