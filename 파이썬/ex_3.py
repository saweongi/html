import pandas as pd
import numpy as np



df = pd.read_excel('2018가스 데이터 대전 분해본.xlsx',sheet_name='중구')

print(df.groupby(['법정동코드','사용년월'])['사용량'].sum())
