import numpy as np
import matplotlib.pyplot as plt

# 로지스틱회귀를 이용한 이중분류(시그모이드함수 사용)
# x : 공부시간, y : 합격/불합격
x = [2, 4, 6, 8, 10, 12 , 14]
y = [0, 0, 0, 1, 1, 1, 1] #0 불합격, 1 합격
x_data = np.array(x) #넘파이 배열 만들기
y_data = np.array(y)
a = 0   #기울기
b = 0   #y절편
lr = 0.05 #학습률(업데이트 수치)
epochs = 2001;


plt.scatter(x_data,y_data)
plt.xlim(0,15)
plt.ylim(-.1,1.1)
#plt.show()

# 시그모이드 함수
def sigmoid(x):
    return 1 / (1 + np.e ** (-x))

for i in range(epochs):
    for j in range(len(x_data)):
        a_diff = x_data[j] * (sigmoid(a * x_data[j] + b) - y_data[j]) #ax구하는거
        b_diff = sigmoid(a * x_data[j] + b) - y_data[j] #b절편 구하느거
        a = a - lr * a_diff
        b = b - lr * b_diff
    if i % 100 ==0:
        print("epoch=%.f, a=%.04f, b=%.04f"%(i,a,b))
x_range = (np.arange(0, 15, 0.1)) # 0~ 14.9까지 0.1씩 증가시킨다.
plt.plot(np.arange(0, 15, 0.1), np.array([sigmoid(a * x +b) for x in x_range]))
plt.show()