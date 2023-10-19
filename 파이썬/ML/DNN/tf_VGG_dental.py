#기존에 만들어져있는(학습되어있는) 모델을 가져와서 fine-tunning한다.

import os
from keras.preprocessing.image import load_img, img_to_array
from keras.models import load_model
from keras import models, layers, optimizers, Sequential
from keras.layers import Flatten, Dense, Dropout
from keras. applications import VGG16
from keras.preprocessing.image import ImageDataGenerator #데이터증강사용

train_dir = './dental_image/train'  #데이터가 별루없을때 증강시킨다(늘린다 --> 각도를 틀어서)
test_dir = './dental_image/test'

train_datagen = ImageDataGenerator( #데이터 증강 할려고
    rotation_range=180 # 180 회전
    ,width_shift_range=0.2 # 좌우 이동
    ,height_shift_range= 0.2 # 상하 이동
    , horizontal_flip=True #좌우 반전
    , vertical_flip=True # 상하 반전
    , brightness_range= [0.5, 1.5]# 명암 증강
)
test_datagen = ImageDataGenerator()

train_generator = train_datagen.flow_from_directory(
    train_dir, target_size=(224, 224) , batch_size=32
    ,class_mode='categorical', shuffle =True
) # 데이터 전처리 해주는거다(이미지 데이터 전처리)
test_generator = test_datagen.flow_from_directory(
    test_dir, target_size=(224, 224) , batch_size=32
    ,class_mode='categorical', shuffle =True
)

#class 수 , label 수
class_num = len(train_generator.class_indices)
labels = list(test_generator.class_indices.keys())

# 학습이 되어서 가져온 가중치는 학습이 되지 않게 설정
# 마지막 1000 class layer 를 -> 3개로
# 이와 같이 학습을 시킨 모델을 pre-training 되어진 모델이라고 하며
# 이 모델을 새로운 목적으로 변경하는 것을 fine-tunning 이라함.


conv_layer = VGG16(weights ='imagenet', include_top =False, input_shape=(224,224,3)) #이미지 학습되어있는 layer만 가져옴
conv_layer.summary()
for layer in conv_layer.layers:
    layer.trainable = False #잘 학습되어진 부분은 학습되지 않도록 고정
model = Sequential()
model.add(conv_layer) #pre-training layer 추가
model.add(Flatten()) # 치아 분류를 위한 fine tuning 부분
model.add(Dense(1024, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(class_num, activation='softmax'))
model.summary()
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model.fit_generator(train_generator, steps_per_epoch= train_generator.samples/train_generator.batch_size, epochs=100, validation_data= test_generator, validation_steps= test_generator.samples/test_generator.batch_size, verbose=1)
model.save('dental_model.h5')