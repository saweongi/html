import pandas as pd

df = pd.read_csv("eais_elcty_202307.txt",header=None,names=['사용년월','순번','시군구코드','법정코드','시도명','시군구명','법정동명','대지구분코드','본번','부번','새주소대로로코드','새주소대로로명','새주소지상지하코드','새주소지상지하명','새주소본번','새주소부번','사용량'], encoding='cp949', sep="|")
print(df)
df_d= df[df['시도명'] == '대전광역시']
df_d.to_excel('eais_elcty_202307.xlsx', index=False)