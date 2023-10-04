# 타이타닉 데이터 분석
# 탐색적 데이터 분석(EDA, Exploratory Data Aanlysis)

#척도
#   질적척도 : 명목척도, 서열척도
#   명목척도 : 관찰하는 대상의 속성에 따라 그 값을 숫자로 나타냄, 연구대상을 구분하거나 분류할 목적으로 숫자를 사용하고 숫자 자체가 가지고 있는 의미는 없음(남자:0,여자:1)
#   서열척도 : 관찰하는 대상의 특성을 측정해서 그 값을 순위로 나타내는 것 (성적 1등, 2등..) 높낮이는 알 수 있지만 어느정도 차이 인지는 알 수 없음

#양적척도 : 등간척도, 비율척도
#   등간척도 : 관찰대상의 속성을 상대적 크기로 나타냄 순위를 부여할 뿐만 아니라 어느 정도 큰지 숫자간의 의미가 있음(온도)
#   비율척도 : 절대적 기준이 있는 영점이 존재하고 모든 사칙연산이 가능, 연구대상을 분류할 수 있고 차이를 비교할 수 있으며 순위를 만들 수 있으므로 명목,서열,등간 성격을 다 가지고 있음(판매량,점수, ..)

#데이터들을 다 비율척도로 대부분 바꿔서 쓴다 라고 생각하면됨

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

#데이터 로드(데이터 가져오기)
titanic = sns.load_dataset('titanic')
print(titanic.head(10))

#데이터 이상치나 결측치 확인하기(가장 먼저 해야할것)
print(titanic.info()) #object,category 는 명목형척도

#survived : 생존1, 사망 0
#pclass : 1등석:1, 2등석:2, 3등석:3
#sibsp : siblings(형제), spouses(자녀)
#parch : parents(부모님), children(자녀)
#tiket : 티켓일련번호
#cabin : 선실번호
#embarked : 선착장
#age : 나이
#sex : 성별

#기술 통계
desc_stats = titanic.describe(include='all') #전체 다나오게
print(desc_stats)

#데이터가 결측치가 있을경우 데이터가 많으면 날릴수도 있다 하지만 데이터가 별로없으면 평균값(대푯값)으로 대체 해준다.

print(titanic.isnull().sum()) #누락데이터의 합을 보여줌

#누락데이터 상관안하고 남녀 나이 평균
gender_mean = titanic.groupby('sex')['age'].mean() #성별에 따른 나이를 평균으로구함
print(gender_mean)

#특정 컬럼 널이 있는 행 제거
titanic.dropna(subset=['age'], inplace=True) #age가 null이면 그행들 다 제거
print(titanic.info())

#성별에 따른 생존율
sns.countplot(x='survived', hue='sex', data=titanic)
plt.title('survival count by gender')
plt.show() #남자가 죽은사람이 많고 여자가 많이 살았는데 죽은사람중에 남자가 너무 많아서 데이터의 편향이 있구나 라고 생각하면됨

#생존자, 사망자 인원수 출력
print(titanic['survived'].value_counts())

#생존율
temp = titanic['survived'].value_counts()
survival_rate = temp[1]/(temp[0] + temp[1]) * 100
print(f"생존율은 {survival_rate:.1f}% 입니다.")

#0인애는 죽음 1은 생존으로  데이터에 컬럼을 새로 추가함
titanic['survived_label'] = titanic['survived'].replace(0,'dead').replace(1,'survived')

#각종 차트로 표현하기
titanic['survived_label'].value_counts().plot(kind='bar', rot=50) #종류는 bar 차트
plt.show()

titanic['survived_label'].value_counts().plot(kind='pie',autopct='%1.2f%%') #종류는 pie 차트
plt.show()

#등실 데이터에 컬럼을 새로추가함
titanic['pclass_label'] = titanic['pclass'].replace(1, 'firstclass').replace(2, 'business').replace(3, 'economy')

#파이 차트로 표현하기
titanic['pclass_label'].value_counts().plot(kind='pie',autopct='%1.2f%%')
plt.show()

#등실별로 살아있는지 차트로 표현
sns.countplot(data=titanic, x='pclass_label', hue ='survived_label')
plt.show()
