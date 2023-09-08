import sqlite3
import requests
import json

url = "https://api.upbit.com/v1/market/all"
sql = """ INSERT INTO stocks values(:1, :2, :3)"""
res = requests.get(url)
text =res.text #res를 text파일로
json_data =json.loads(text) #text파일을 json데이터로 ?
print(json_data)

conn = sqlite3.connect("mydb.db")
cur = conn.cursor() #sql을 사용 할수 있게 작업환경을 제공한다

for row in json_data:
    print(row['market'],row['korean_name'],row['english_name'])
    cur.execute(sql,[row['market'],row['korean_name'],row['english_name']])

conn.commit() # 데이터베이스에 저장
conn.close()