import pandas as pd
from scipy import stats   #통계관련 함수를 쓰기위해 사용
import matplotlib.pyplot as plt #그래프그리기
import seaborn as sns #그래프그리기

#예제 데이터
data = [3, 36, 37, 45, 52, 56, 68, 66, 68, 75, 90, 100]


#기술통계
#중심 경향성(중심도) : 평균, 중앙값, 최빈값
mean = pd.Series(data).mean() #Series데이터중에 평균을 찾는다 (Series는 하나의 열이라고 생각하면됨)
median = pd.Series(data).median() #Series데이터중에 중앙값을 찾는다
mode = pd.Series(data).mode() #Series데이터중에 최빈값을 찾는다
print(f"mean:{mean}, median:{median}, mode:{mode[0]}")

#산포도 :범위, 분산, 표준편차
range_ = max(data) - min(data) #범위
variance = pd.Series(data).var() #분산
std_dev = pd.Series(data).std() #표준편차
print(f"range: {range_}, variance:{variance}, standard deviation:{std_dev}")


df = pd.Series(data)

# 1사 분위와 3사분위를 계산
Q1 = df.quantile(0.25) 
Q3 = df.quantile(0.75)

#사분위 편차 계산
IQR = Q3 - Q1
print(f"1분위:{Q1}, 3분위:{Q3}, 사분위편차(IQR):{IQR}")

print(df.describe()) #기초통계요약 을 구해준다
print(df.info()) #데이터의 자료형 확인(기본정보가 있음)


#그래프로 데이터 보기
plt.figure(figsize=(15,5)) #사이즈는 15, 5 로 보여지게

#산점도 그리기
index = range(len(data))
plt.subplot(1, 3, 1) #한장에 한번에 그리기 위해 1,3,1을 사용 그래서 뒤에 1,3,2 / 1,3,3 이 있음
plt.scatter(index, data, color ='blue', marker='o') #컬러는 블루 점은 o으로 표시
plt.title('scatter plot') #제목
plt.grid(True) #그려라

#박스플롯
plt.subplot(1, 3, 2)
sns.boxplot(data, color='lightgreen') 
plt.title('box plot')

#선 그래프
plt.subplot(1, 3, 3)
plt.plot(data, marker='o', linestyle='-', color='coral')
plt.title('line graph')
plt.grid(True)
plt.tight_layout()
plt.show()