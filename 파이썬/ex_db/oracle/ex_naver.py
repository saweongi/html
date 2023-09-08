import requests
import DBManager as mydb
import json
import ex_db.mylogger as mylogger
from apscheduler.schedulers.blocking import BlockingScheduler

log = mylogger.make_logger("naver.log","naver")
log.info("수집기 시작!!")
def test_interval():

    db = mydb.DBManager()

    insert_sql = """
    INSERT INTO stocks (item_code, stock_nm, close_price, compare_close)
    VALUES (:1, :2, :3, :4)
    """

    for i in range(1,43):
        url = f"https://m.stock.naver.com/api/stocks/marketValue/KOSPI?page={i}&pageSize=50"
        print(url)
        res = requests.get(url)
        jsonObj = json.loads(res.text)
        stock_arr = jsonObj['stocks']
        print(stock_arr)

        #종목명, 종목코드, 종가, 변동가 출력
        for row in stock_arr:
            stock_name = row ['stockName']
            stock_code = row ['itemCode']
            stock_closePrice = row ['closePrice']
            stock_compareToPreviousClosePrice = row ['compareToPreviousClosePrice']
            db.insert(insert_sql,[stock_code,stock_name,stock_closePrice,stock_compareToPreviousClosePrice])


sched = BlockingScheduler()  # 하나의 프로세스에서만 동작하며 스케쥴링 된 작업이 실행될때 다른 작업은 일시중단됩니다.
sched.add_job(test_interval, 'interval', seconds=600)
sched.start()

