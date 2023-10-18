from keras.models import Sequential
from keras.layers import Dense
import numpy as np
import tensorflow as tf
seed = 0
np.random.seed(seed)
tf.random.set_seed(seed)

#데이터 로드
dataset = np.loadtxt('../datasets/pima-indians-diabetes.csv', delimiter = ',') #delimiter , 으로 분류해서 읽는다
x = dataset[:, 0:8]
y = dataset[:, 8]

#모델
model = Sequential()
model.add(Dense(12, input_dim = 8, activation='relu')) #input_dim 는 입력의 개수를 적는거임
model.add(Dense(8,activation='relu'))
model.add(Dense(1, activation='sigmoid'))
model.summary()

#컴파일
model.compile(loss = 'binary_crossentropy', optimizer='adam', metrics=['acc'])
model.fit(x,y, epochs =200 , batch_size =20)
print(f"acc : {model.evaluate(x,y)[1]}") #evaluate는 정확도 나 이런거 나오게 해준다
