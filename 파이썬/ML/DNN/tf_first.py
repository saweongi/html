#pip install tensorflow
import tensorflow as tf
import numpy as np
print(tf.__version__)   #버전 출력하기

data = np.loadtxt('../datasets/ThoraricSurgery.csv', delimiter=',')
# 독립변수: 환자의 기록 , 종속변수:수술후 사망 0 , 생존: 1
x = data[:, 0:17] #모든행, 17개 열
y = data[:, 17] # 모든행, 마지막열

#딥러닝의 구조 설계 (초급방법)
from keras.models import Sequential
from keras.layers import Dense

# 모델 틀
model = Sequential()

# 히든레이터 추가
model.add(Dense(30, input_dim=17, activation='relu')) #30개 노드 생성, input_dim은 input의 개수, 활성화함수는 렐루를 사용하겠다.

# 출력층
model.add(Dense(1, activation='sigmoid')) #이항분류(출력이 하나로 나와야해서 노드 1를쓰고 활성화함수는 시그모이드 를 사용하겠다)
model.summary() # 만든 모델의 구조 출력(요약)

# 손실함수와 최적화방법 정의
model.compile(loss ='mean_squared_error', optimizer='adam', metrics=['acc'])

#학습
model.fit(x, y, epochs=30, batch_size=10) # batch_size는 데이터를 10개씩 끈어서 하겠다(경사하강법)

#결과 출력
print(f"acc : {model.evaluate(x,y)[1]}")
