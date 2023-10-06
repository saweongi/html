import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
import numpy as np
df = pd.read_csv("./datasets/Titanic Passengers.csv")
print(df.columns)

# 명목적(남자,여자 )데이터를 사용하기위해  여 :1 , 남:0로 바꿔준다
df['sex'] = df['sex'].map({'female': 1, 'male': 0}) #모든sex데이터의 값을 여자는 1로 남자는 0 으로 바꿔준다.
print(df.head())

#널값을 평균값으로
df['age'].fillna(value=df['age'].mean(), inplace=True) #age의 평균을 가지고 널값을 가진애들을 평균값으로 대체 해준다 (inplace는 true를 하면 그 자체 데이터셋에 넣어주고 false 로하면 다른곳에 담는다
print(df.info())
df['firstClass'] = df['pclass'].apply(lambda x : 1 if x==1 else 0) # apply가 각 열에 접근하여  x가 1이면 1 아니면 0 으로 바꿔줌
df['secondClass'] = df['pclass'].apply(lambda x : 1 if x==2 else 0) # apply가 각 열에 접근하여  x가2이면 1 아니면 0 으로 바꿔줌
df['thirdClass'] = df['pclass'].apply(lambda x : 1 if x==3 else 0) # apply가 각 열에 접근하여  x가3이면 1 아니면 0 으로 바꿔줌
print(df.head())
x=df[['sex','age','firstClass', 'secondClass','thirdClass']]
y=df[['survived']]

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2)
scaler = StandardScaler() #스케일을 평균0, 표준편차 1 되도록 표준화 -> 데이터가 들쑥날쑥할때 스케일 조정할때사용 ->크기가 차이안나게축소시킨다라고 생각하면됨
x_train = scaler.fit_transform(x_train) #fit 얘만 쓴이유는 데이터가 많은쪽에다가 해야하며 아래 test에도 하면 원상복구할때 값이 아예 달라져서 나온다.
x_test = scaler.transform(x_test)
print(x_train)

print("%%%%%%%%%%%%%%%%%%%")
print(print(x_train))

model = LogisticRegression()
model.fit(x_train,y_train)
print(model.coef_) #기울기
print(model.intercept_) #y절편
print('학습데이터 성능:',model.score(x_train,y_train))
print('테스트 데이터 성능:',model.score(x_test,y_test))

#평가하기
Jack = np.array([0.0, 20.0, 0.0, 0.0, 1.0])
Rose = np.array([1.0, 17.0, 1.0, 0.0, 0.0])
Nick = np.array([0.0, 30.0, 0.0, 1.0, 0.0])
Baby = np.array([1.0, 5.0, 0.0, 1.0, 0.0])
sample = np.array([Jack, Rose, Nick, Baby])
sample = scaler.transform(sample) #데이터 스케일조종하기
print(model.predict(sample))
print(model.predict_proba(sample))



