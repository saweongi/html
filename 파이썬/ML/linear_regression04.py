import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.linear_model import LinearRegression  #사이킷런 선형성을 가진 모델용으로 사용 해서   선형회귀 사용한다

model = LinearRegression()

df = pd.read_csv("./datasets/heights.csv")

#단순선형회귀 라이브러리(사이킷런) 사용
# x : 키, y : 무게
x = df['height']
y = df['weight']
model.fit(x.values.reshape(-1,1), y) #데이터프레임을 넘파일 배열로 넣어주기위해 reshape를 사용, fit은 모델을 학습
print(model.coef_) #기울기
print(model.intercept_) #y절편
plt.plot(x, y , 'o')
plt.plot(x, model.predict(x.values.reshape(-1,1))) #평가하면서 그래프를 구함
plt.show()
print('test:' , model.predict([[70]])) #70테스트 데이터로 예측 한거임