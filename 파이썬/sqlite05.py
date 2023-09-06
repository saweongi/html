import sqlite3
import requests
import json
from ex_date import datetime
from apscheduler.schedulers.blocking import BlockingScheduler
def test_interval():
    conn = sqlite3.connect('mydb.db')
    cur = conn.cursor()
    cur.execute("SELECT * FROM stocks")

# sql = """CREATE TABLE tb_stocks(
#             stocks__market VARCHAR2(100)
#             ,stocks_trade_price VARCHAR2(100)
#             ,stocks_timestamp VARCHAR2(100)
#             );
# """
#cur.execute(sql)

    rows = cur.fetchall()

# sql = """ INSERT INTO tb_stocks values(:1, :2, :3)"""
    url ="https://api.upbit.com/v1/ticker?markets="

    for row in rows:
        print(url + row[0])
        res = requests.get(url + row[0])
        if res.status_code == 200: #요청했을때 응답이 정상인것들만 가져온다
            json_data = json.loads(res.text)
        #print(json_data)
            market = json_data[0]['market']
            trade_price = "{:.15f}".format(json_data[0]['trade_price'])
            trade_timestamp = json_data[0]['timestamp'] * 0.001 #초단위로 변환
            str_timestamp = datetime.datetime.fromtimestamp(trade_timestamp).strftime("%Y-%m-%d %H:%M:%S")
            print(market, trade_price, str_timestamp)
            cur.execute(""" INSERT INTO tb_stocks values(:1, :2, :3)""", [market,trade_price,str_timestamp])
    conn.commit()
    conn.close()
sched = BlockingScheduler() #하나의 프로세스에서만 동작하며 스케쥴링 된 작업이 실행될때 다른 작업은 일시중단됩니다.
sched.add_job(test_interval, 'interval', seconds=600)
sched.start()
