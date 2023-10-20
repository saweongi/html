import FinanceDataReader as fdr
import matplotlib.pyplot as plt
import pandas as pd
import datetime
from pandas.tseries.offsets import BDay
from pytimekr import pytimekr
# pip install -U finance-datareader
# pip install pytimekr


stock = fdr.DataReader('TSLA')
stock['Close'].plot()
#plt.show()

def fn_get_stock(p_code, p_start, p_end):
    df = fdr.DataReader(p_code, p_start, p_end)

    # 기존에 index는 날짜를 ->  년월일로 전처리
    df_stock = df.reset_index()
    seq = df_stock['Date'].dt.strftime('%Y-%m-%d')
    x_data = df_stock[['Close']].astype(str)
    x_data['Date'] = seq
    file_nm = "{0}_{1}_{2}.xlsx".format(p_code, p_start.replace('-',''), p_end.replace('-',''))
    writer = pd.ExcelWriter(file_nm, engine='openpyxl')
    x_data.to_excel(writer,'Sheet1')
    writer._save()

def fn_workingday(b_day): #외국기준 쉬는날 뽑아 준다.
    today = datetime.datetime.now()
    start = datetime.datetime.today() - BDay(b_day)
    end = datetime.datetime.today()
    print(start.strftime('%Y-%m-%d'), end.strftime('%Y-%m-%d'))
    return start.strftime('%Y-%m-%d'), end.strftime('%Y-%m-%d')
p_st, p_end = fn_workingday(51)
print(p_st, p_end)
fn_get_stock('TSLA', p_st, p_end)