from keras.models import load_model
from sklearn.preprocessing import MinMaxScaler
import pandas as pd
import numpy as np
model = load_model('TSLA.model')
a = pd.read_excel('TSLA_20000101_20231020.xlsx', engine='openpyxl')
scaler = MinMaxScaler(feature_range=(0,1))
scaler.fit_transform(np.array(a['Close'].values).reshape(-1,1)) #원래 큰데이터를 스케일조정
df = pd.read_excel('TSLA_20230810_20231020.xlsx', engine='openpyxl')
test_data=scaler.transform(np.array(df['Close'].values).reshape(-1,1)) #작은 데이터를 큰데이터로 스케일조정할걸로 조정
pred = model.predict(np.array([test_data]))
print(pred[0][-1])
print(scaler.inverse_transform(np.array(pred[0][-1]).reshape(-1,1))) #inverse_transform은 원래의 스케일로 바꺼주는거