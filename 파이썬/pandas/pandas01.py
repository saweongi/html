# pandas 기초
#판다스는 데이터 프레임을 자료구조로 사용(행 열 구조)
# pip install pandas
import pandas as pd

df= pd.DataFrame({"name" : ["nick","judy","alex"], "age" : [10, 20, 22]})
print(df.head()) #내용출력 기본 5개

#기존열을 활용하여 새로운 열을 쉽게 만들수 있다.
df['age_plus'] = df['age'] + 1
print(df.head())
df['age_squared'] = df['age'] * df['age']

#다양한 내장 함수가 있음.
total = df['age'].sum() #더하기
median = df['age'].quantile(0.5) #중앙값뽑아내기
print(total,median)

#병합가능
df2 = pd.DataFrame({'name' : ['nick', 'judy', 'alex'], 'height': [182, 165, 175], 'gender' : ["M", "F","M"]})
joined = df.set_index('name').join(df2.set_index('name')) #df의 네임을 기준으로 데이터들이 병합을 시켜준다.
print(joined.head())


reset_joined = joined.reset_index() #nick 이랑 judy alex 인덱스에서 빼기 병합했을때 name 기준으로 얘네들이 인덱스로 됐음
print(reset_joined)
groupby_df = joined.groupby('gender').mean() #gender 기준으로 그룹을 묶고  평균을 구함
print(groupby_df)

#pip install jupyter  --> 주비터 노트북 사용하고싶으면 설치
#jupyter notebook 주피터 키는방법
