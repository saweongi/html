# pandas db 조회하는 법
import pandas as pd
from ex_db.oracle.DBManager import DBManager
import requests
import json

mydb = DBManager()
sql = """SELECT *FROM md_stock"""
df = pd.read_sql(con= mydb.conn, sql=sql) #sql 읽기
print(df.head())
#sql에서 했던거 가져옴
merge_sql ="""    
MERGE INTO tb_stock_bbs a
USING dual
ON (a.item_code = :1
    and a.discussionId = :2)  -- 데이터가 있어서 중복되었을때는
WHEN MATCHED THEN   -- 업데이트를 한다.
    UPDATE SET a.readCount = :3
            ,  a.goodCount = :4
            ,  a.badCount = :5
            ,  a.commentCount = :6
WHEN NOT MATCHED THEN -- 없으면 insert문으로 값을 넣는다.
    INSERT (a.item_code, a.discussionId, a.bbs_title, a.bbs_contents
         ,  a.create_date, a.readCount, a.goodCount, a.badCount, a.commentCount
         ,  a.update_date)
    VALUES (:7, :8, :9, :10, to_date(:11, 'YYYY-MM-DD HH24:MI:SS'), :12, :13, :14, :15, SYSDATE)


"""

#dataFram 순회하기
for index, row in df.iterrows():  #iterrows 메서드는 데이터의 행-열/데이터 정보를 튜플 형태의 generator 객체로 반환하는 메서드
    print(row['ITEM_CODE'],row['STOCK_NM'])  #각각에 있는 열에 접근
    code = row['ITEM_CODE']
    #index로 접근
    print(df.iloc[index]) #하나의행으로 접근
    #삼성
    url = f"https://m.stock.naver.com/api/discuss/localStock/{code}?rsno=0&size=100"
    res = requests.get(url)
    json_data = json.loads(res.text)
#print(json_data)

    for v in json_data:
        discussionId = v['discussionId']
        title = v['title']
        contents = v['contents'][:1300]
        date = v['date'][:19]
        readCount = v['readCount']
        goodCount = v['goodCount']
        badCount = v['badCount']
        commentCount = v['commentCount']
        try:
            mydb.insert(merge_sql, [code, discussionId, readCount, goodCount, badCount, commentCount,code,discussionId,title,contents,date,readCount,goodCount,badCount,commentCount])
        except Exception as e:
           print(str(e))
        print(date)
