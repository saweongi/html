# -*- coding: utf-8 -*-
# k-최근접 이웃 회귀 -->수치 예측
## 데이터 준비
#114p
import numpy as np

perch_length = np.array(
    [8.4, 13.7, 15.0, 16.2, 17.4, 18.0, 18.7, 19.0, 19.6, 20.0,
     21.0, 21.0, 21.0, 21.3, 22.0, 22.0, 22.0, 22.0, 22.0, 22.5,
     22.5, 22.7, 23.0, 23.5, 24.0, 24.0, 24.6, 25.0, 25.6, 26.5,
     27.3, 27.5, 27.5, 27.5, 28.0, 28.7, 30.0, 32.8, 34.5, 35.0,
     36.5, 36.0, 37.0, 37.0, 39.0, 39.0, 39.0, 40.0, 40.0, 40.0,
     40.0, 42.0, 43.0, 43.0, 43.5, 44.0]
     )
perch_weight = np.array(
    [5.9, 32.0, 40.0, 51.5, 70.0, 100.0, 78.0, 80.0, 85.0, 85.0,
     110.0, 115.0, 125.0, 130.0, 120.0, 120.0, 130.0, 135.0, 110.0,
     130.0, 150.0, 145.0, 150.0, 170.0, 225.0, 145.0, 188.0, 180.0,
     197.0, 218.0, 300.0, 260.0, 265.0, 250.0, 250.0, 300.0, 320.0,
     514.0, 556.0, 840.0, 685.0, 700.0, 700.0, 690.0, 900.0, 650.0,
     820.0, 850.0, 900.0, 1015.0, 820.0, 1100.0, 1000.0, 1100.0,
     1000.0, 1000.0]
     )

import matplotlib.pyplot as plt

plt.scatter(perch_length, perch_weight)
plt.xlabel('length')
plt.ylabel('weight')
plt.show()

from sklearn.model_selection import train_test_split
x_train, x_test, y_train, y_test = train_test_split(perch_length,perch_weight, random_state=1)
print(x_train.shape)
train_input = x_train.reshape(-1,1) # 42행을 1열로 만들기
test_input = x_test.reshape(-1,1) # 행을 열로 만들기
#라벨들은 유연해서 reshape로 안바꿔줘도됨(피쳐들만 바꿔줘야함) ->알아서 매칭된다고 생각하면될듯

print(train_input.shape,test_input.shape)
from sklearn.neighbors import KNeighborsRegressor
model = KNeighborsRegressor()
model.fit(train_input, y_train)
print(model.score(train_input, y_train))
print(model.score(test_input, y_test))

# 테스트 데이터 예측결과
test_pred = model.predict(test_input)

#테스트 데이터에 대한 평균 절댓값 오차계산
from sklearn.metrics import mean_absolute_error
mae = mean_absolute_error(y_test, test_pred)
print(mae)

model.n_neighbors = 3
model.fit(train_input, y_train)
print(model.score(train_input, y_train))
print(model.score(test_input, y_test))

# 5 ~ 45
x = np.arange(5, 45).reshape(-1,1)
for n in [1, 5, 10]:
 model.n_neighbors = n
 model.fit(train_input, y_train)
 pred = model.predict(x)
 plt.scatter(train_input, y_train)
 plt.plot(x, pred)
 plt.title('k = {}'.format(n))
 plt.xlabel('length')
 plt.ylabel('weight')
 plt.show()

