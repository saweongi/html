import numpy as np
import matplotlib.pyplot as plt

#손실함수 까지 구하는 법

#가상의 기울기 a와 y절편 b
f_ab = [3, 76] #임의의 a와 b값

# x : 공부시간, y : 성적
x = [2, 4, 6, 8]
y = [81, 93, 91, 97]

plt.figure(figsize=(8, 5))
plt.scatter(x,y)
plt.show()

#MSE함수
def mse(y, y_hat): #y는 실제값 y_hat은 예측값
    return ((y - y_hat) ** 2).mean() #mse함수 구하는식

#예측 함수
def predict(x):
    return f_ab[0] * x + f_ab[1] #입력값 x가 들어왔을때 [0]은 기울기 [1]절편

#총 오차 구하는 함수
def mse_val(y, predict_result):
    return mse(np.array(y), np.array(predict_result)) #np는 넘파이 (미분 이런 수학 등등 계산할때 사용)

#예측값이 들어갈 배열
pre_arr = []
for i in range(len(x)):
    pre_arr.append(predict(x[i]))
    print("공부시간 =%.f," "실제점수=%.f, 예측점수=%.f" %(x[i],y[i],predict(x[i])))

#최종 mse
print("총 오차:" + str(mse_val(pre_arr, y)))

