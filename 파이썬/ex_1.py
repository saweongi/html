import pandas as pd
import numpy as np
pd.options.display.float_format = '{:.5f}'.format
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)
list = ['동구','서구','유성구','대덕구','중구']
for y in list:
    print(f"지역:{y}")
    for x in range(18,24):
        year = f"{x}"
        df = pd.read_excel('20'+year+'가스 데이터 대전 분해본.xlsx',sheet_name=y)

        print(df.groupby("사용년월")['사용량'].sum())




