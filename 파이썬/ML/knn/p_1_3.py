# -*- coding: utf-8 -*-
"""1-3. 마켓과 머신러닝

## 생선 분류 문제

### 도미 데이터 준비하기
"""
#  bream 도미 25.4 cm, 242 g
import matplotlib.pyplot as plt

bream_length = [25.4, 26.3, 26.5, 29.0, 29.0, 29.7, 29.7, 30.0, 30.0, 30.7, 31.0, 31.0, 31.5, 32.0, 32.0, 32.0, 33.0, 33.0, 33.5, 33.5, 34.0, 34.0, 34.5, 35.0, 35.0, 35.0, 35.0, 36.0, 36.0, 37.0, 38.5, 38.5, 39.5, 41.0, 41.0]
bream_weight = [242.0, 290.0, 340.0, 363.0, 430.0, 450.0, 500.0, 390.0, 450.0, 500.0, 475.0, 500.0, 500.0, 340.0, 600.0, 600.0, 700.0, 700.0, 610.0, 650.0, 575.0, 685.0, 620.0, 680.0, 700.0, 725.0, 720.0, 714.0, 850.0, 1000.0, 920.0, 955.0, 925.0, 975.0, 950.0]

plt.scatter(bream_length, bream_weight)
plt.xlabel('length')
plt.ylabel('weight')
plt.show()

"""### 빙어 데이터 준비하기"""

smelt_length = [9.8, 10.5, 10.6, 11.0, 11.2, 11.3, 11.8, 11.8, 12.0, 12.2, 12.4, 13.0, 14.3, 15.0]
smelt_weight = [6.7, 7.5, 7.0, 9.7, 9.8, 8.7, 10.0, 9.9, 9.8, 12.2, 13.4, 12.2, 19.7, 19.9]

plt.scatter(bream_length, bream_weight)
plt.scatter(smelt_length, smelt_weight)
plt.xlabel('length')
plt.ylabel('weight')
plt.show()

# datasets 만들기 ( 도미 + 빙어)
length = bream_length + smelt_length
weight = bream_weight + smelt_weight
fish_data = [[l, w] for l, w in zip(length, weight)]# zip은 1개씩 꺼내줌(각각의 0번째, 1번째 등등 요소를 꺼내서 만들어줌)
print(fish_data) #zip으로 해서 길이랑 무게를 하나씩 리스트에 담을수 있었다.
fish_target = [1]*35 + [0]*14 #도미를 1로 해서 정답으로 지정함
print(fish_target)

# length와 weight가 입력으로 들어왔을때 도미인지 빙어인지 맞추는 모델
from sklearn.neighbors import KNeighborsClassifier
knn = KNeighborsClassifier() #knn분류기를 사용하기위해 지정
knn49 = KNeighborsClassifier(n_neighbors=49) #k의 개수를 지정
knn.fit(fish_data,fish_target) # k=5 (디폴트값이 5다) ,학습
knn.fit(fish_data,fish_target) #k=49로 학습
print(knn.score(fish_data,fish_target))
print(knn49.fit(fish_data, fish_target))
for n in range(5,50):
    #최근접 이웃 개수 설정(k값 설정)
    knn.n_neighbors = n
    score = knn.score(fish_data,fish_target)
    print(n, score)
plt.scatter(bream_length, bream_weight)
plt.scatter(smelt_length, smelt_weight)
plt.scatter(30, 600 ,marker='^') #길이 30 무게 600 짜리를 ^로 그림그리게함
plt.xlabel('length')
plt.ylabel('weight')
plt.show()
print(knn.predict([[30,600]]))