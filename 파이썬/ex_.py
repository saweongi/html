import pandas as pd
pd.options.display.float_format = '{:.5f}'.format
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)
list = ['동구','서구','유성구','대덕구','중구']
for y in list:
    print(f"지역:{y}")
    for x in range(18,24):
        year = f"{x}"
        df = pd.read_excel('20'+year+'전기 데이터 대전 분해본.xlsx',sheet_name=y)

        for i in range(1,13):
            if i<= 9:
                day = f"20{x}0{i}"
                print(f"{year}년도 {i}월 개수: ",len(df.loc[df.사용년월 == int(day)]))

            else:
                day = f"20{x}{i}"
                print(f"{year}년도 {i}월 개수: ",len(df.loc[df.사용년월 == int(day)]))




