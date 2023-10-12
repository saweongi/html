from sklearn import datasets
import pandas as pd
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

iris = datasets.load_iris() #붓꽃데이터를 iris에 저장
label = pd.DataFrame(iris.target)

label.columns = ['labels'] # 라벨 컬럼의 이름을 labels로 정의

data = pd.DataFrame(iris.data)

# sepal 꽃받침 , petal 꽃잎
data.columns = ['Sepal length', 'Sepal width', 'Petal length', 'Petal width']
data = pd.concat([data, label], axis =1) #concat으로 데이타랑 라벨을 붙여줌
x_data = data[['Sepal length', 'Sepal width']]
print(x_data.head())
model = KMeans(n_clusters=3, algorithm='auto') #3개의 군짐으로 나누겠다 알고리즘은 자동(기본값 특성에따라)으로 하게한다
model.fit(x_data)
pred = pd.DataFrame(model.predict(x_data)) #예측한 데이터를 데이터프레임으로 만듬
pred.columns = ['predict']
all_data = pd.concat([data,pred], axis=1)
print(all_data.head())
plt.scatter(x_data['Sepal length'], x_data['Sepal width'], c=all_data['predict'], alpha=0.5)
center = pd.DataFrame(model.cluster_centers_, columns=['Sepal length','Sepal width'])
center_x = center['Sepal length']
center_y = center['Sepal width']
plt.scatter(center_x, center_y, s=50 , marker='D', c='r')
plt.show()
