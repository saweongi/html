import pandas as pd
import matplotlib.pyplot as plt
import plotly.express as px
import seaborn as sns


df = pd.read_csv('Salaries.csv')
print(df.head(10)) #데이터를 위에서부터  10개 보여준다

print(df.info()) #데이터타입 등 기본정보를 보여줌

desc_stats = df.describe(include='all') #기초통계량 모두를 보여준다
print(desc_stats)

df16 = df[(df['yearID'] >= 2016) & (df['salary'] > 0)] #데이터중에 2016년 이후 그리고 연봉이 0보다 큰 데이터들만 가져온다
print(df16.describe(include='all'))

index = range(len(df16))
plt.scatter(df16.index,df16['salary'])
plt.show()


fig = px.scatter(df16, x='salary', y='playerID', color='lgID', title='player salary with lgID')
fig.show()

sns.distplot(df16.salary).set_title('histogram')
plt.show()

#이상치 데이터 찾기
Q1 = df16['salary'].quantile(0.25)
Q3 = df16['salary'].quantile(0.75)

#IQR 계산
IQR = Q3 - Q1
lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

#이상치 출력
outliers = df16[(df16['salary'] < lower_bound) | (df16['salary'] > upper_bound)]
print(outliers)
print(outliers.shape) #데이터의 몇행 몇열 을 가지고 있는지 보여줌
print(outliers.describe(include='all'))