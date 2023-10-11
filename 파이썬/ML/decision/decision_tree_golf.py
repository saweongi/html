# 의사결정나무 시각화를 위한 라이브러리 설치
# pip install graphviz
import pandas as pd
from sklearn import tree
from sklearn.preprocessing import LabelEncoder

df = pd.read_csv("playing golf.csv")
print(df.columns)
x_data = df[['outlook', 'temperature', 'humidity', 'windy']]
y_data = df[['play']]

#명목적데이터를 수치형데이터로 변환하기
enc_class = {}
def encoding_label(x): #데이터 변환하는 코드
    le = LabelEncoder()
    le.fit(x)
    label = le.transform(x)
    enc_class[x.name] = le.classes_
    return label
train_data = x_data[x_data.columns].apply(encoding_label) #모든데이터를 apply를 이용하여 수치형으로 바꿔줌
print(train_data)

model = tree.DecisionTreeClassifier()
model.fit(train_data, y_data)
test = pd.DataFrame({"outlook":2, "temperature":1, "humidity":0, "windy": 0}, index=[0])
pred = model.predict(test)
prob = model.predict_proba(test)
print(pred, prob)

#트리시각화
import matplotlib.pyplot as plt
from sklearn.tree import plot_tree
plot_tree(model, feature_names=['outlook','temperature','humidity','windy'])
print(enc_class)
plt.show()

