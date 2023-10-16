from keras.datasets import mnist
import numpy as np
from keras.utils import to_categorical
import tensorflow as tf
from keras.models import Sequential
from keras.layers import Dense

# 매 실행시 고정 될 수 있도록
seed = 0
np.random.seed(seed)
tf.random.set_seed(seed)

(x_train, y_train), (x_test, y_test) = mnist.load_data()
print(f"학습 데이터:{x_train.shape}")
print(f"테스트 데이터:{x_test.shape}")

import matplotlib.pyplot as plt
plt.imshow(x_train[0], cmap="Greys")
#plt.show()

#데이터 준비
x_train_reshape = x_train.reshape(x_train.shape[0], 784).astype("float32")/255
x_test_reshape = x_test.reshape(x_test.shape[0], 784).astype("float32")/255
y_train_cate = to_categorical(y_train, 10) #원핫인코딩으로 만듬(10개 열로만듬 0~9)
y_test_cate = to_categorical(y_test,10)

# 모델 구조
model = Sequential()
model.add(Dense(512, input_dim=784, activation='relu'))
model.add(Dense(10, activation='softmax'))
model.summary()

model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model.fit(x_train_reshape, y_train_cate, epochs=100, batch_size=200 )
print(f"학습 acc:{model.evaluate(x_train_reshape,y_train_cate)}")
print(f"테스트 acc:{model.evaluate(x_test_reshape,y_test_cate)}")
print(model.predict([[x_test_reshape[0]]]))




