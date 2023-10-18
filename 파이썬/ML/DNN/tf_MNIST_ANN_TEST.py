from keras.models import load_model
from keras.datasets import mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_test_sample = x_test[0].reshape(1, 784).astype("float32")/255
model = load_model("./model/15-0.0602.hdf5")
model.summary()
pred = model.predict(x_test_sample)
print(pred)
import numpy as np
pred_class = np.argmax(pred, axis=1)
print(pred_class)
import matplotlib.pyplot as plt
plt.imshow(x_test[0], cmap='Greys')
plt.show()
# 해당 콘다 가상환경 라이브러리 리스트
# pip freeze > requirements.txt
# pip list --format=freeze > requirements.txt