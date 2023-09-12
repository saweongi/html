# pip install matplotlib
# pip install finance-datareader
import FinanceDataReader as fdr
import matplotlib.pyplot as plt
import datetime
import matplotlib.font_manager as fm
import pandas as pd




# #국내/해외 지수, 환율정보, 국채금리정보
# apple = fdr.DataReader('AAPL') #애플의 전체의 주가정보가 들어있음
# print(apple.head())
# apple['Close'].plot() #애플의 종가를 그래프로 나타냄
# plt.show() #그래프를 그려라

#한국거래소 상장종목
# df_krx = fdr.StockListing('KRX')
# print(df_krx.head())
# KOSPI = df_krx[df_krx['Market'].str.contains('KOSPI')] # market의 컬럼에서  문자열중에 KOSPI가  포함되어있는애를 가져온다
# print(KOSPI.columns)
# print(KOSPI.head(50))
# df_samsung = fdr.DataReader('005930','2022') #삼성전자 코드 005930이랑 2022년도 꺼를 가져온다
# df_samsung_2000_2022 = fdr.DataReader('005930', '2000-01-01', '2022-12-31') #삼성전자를 2000 01 01 ~ 2022 12 31 까지 가져온다
#
# print(df_samsung_2000_2022.info())  #기본정보
# print(df_samsung_2000_2022.describe())  #기초통계량
# df_samsung_2000_2022['Close'].plot() #종가를 그래프로 나타냄
# plt.show() #그래프를 그려라

# 일자는 이렇게 가져오고 가격이나 이런거는 실시간 데이터로 가져온다

# 오늘 날자를 기준으로 1달 전의 날짜 계산
end_date = datetime.date.today()
start_date = end_date - datetime.timedelta(days=30)
print(start_date)

# 5개 종목 리스트(삼성,sk하이닉스,셀트리온,삼성바이오로직스,LG화학)
stocks = ['005930','000660','068270','207940','051910']
nm = ['삼성전자','sk하이닉스','셀트리온','삼성바이오로직스','LG화학']
plt.figure(figsize=(12,6))
plt.rcParams['font.family'] = 'Malgun Gothic'

# 각 종목별로 주가 데이터 가져와서 그리기
for stock in stocks:
    df = fdr.DataReader(stock, start_date, end_date)
    plt.plot(df['Close'], label=stock)
plt.title('stock price') # 제목
plt.xlabel('Date') # x측라벨
plt.ylabel('Price') # y측 라벨
plt.legend()    #범례표시
plt.grid(True)  # 그리드 표시 false는 안그려짐
plt.tight_layout() #레이아웃조정
plt.savefig("30일.png") #파일로 저장
plt.show() #출력

for i, stock in enumerate(stocks):
    df = fdr.DataReader(stock, start_date, end_date)
    plt.plot(df['Close'], label=nm[i])
    file_nm ='{0}_{1}_{2}.xlsx'.format(nm[i], start_date, end_date)
    writer = pd.ExcelWriter(file_nm, engine="openpyxl") # openpyxl 엔진을 통해 엑셀을 만들거다
    df.to_excel(writer, 'sheet1') # df의 데이터로 sheet1에다가 내용을 적어라
    writer._save() # 파일을 저장해준다
plt.title('stock price') # 제목
plt.xlabel('Date') # x측라벨
plt.ylabel('Price') # y측 라벨
plt.legend()    # 범례표시
plt.grid(True)  # 그리드 표시 false는 안그려짐
plt.tight_layout() # 레이아웃조정
plt.savefig("30일_2.png") # 파일로 저장
plt.show() #출력



