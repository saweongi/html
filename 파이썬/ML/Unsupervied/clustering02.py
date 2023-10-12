import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
df = pd.read_csv('Mall_Customers1.csv')

#성별이 명목형으로 되어있어서 수치형으로 바꿈(Female -> 1 , Male -> 0 )
df['Gender'] = df['Gender'].map({"Female": 1, "Male" : 0}) #map을 이용하여 명목형을 수치형으로 바꿈
print(df.columns)
data = df[['Gender', 'Age', 'Annual Income', 'Spending Score']]
print(data.info())
print(data.describe())

#좋은 군집찾기
# 그룹에 포함된 데이터들의 퍼짐 정도를 inertia 라고하는데
# 좋은 군집은 퍼짐 정도가 낮은 군집
cnt = list(range(1, 11))
inertia = []
for i in cnt: # K 값 구하기
    model = KMeans(n_clusters = i, algorithm='auto' )
    model.fit(data)
    inertia.append(model.inertia_) # 퍼짐을 append로 넣어서 제일 좋은 K 값을 찾는다
plt.plot(cnt, inertia, '-0')
plt.xlabel("number of clusters (k)")
plt.ylabel("Inertia")
plt.show()