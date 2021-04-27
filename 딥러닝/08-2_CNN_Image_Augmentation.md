# CNN small datasets 학습
  - Data의 수가 많지 않을 때 CNN을 통한 모형학습이 어려울 수 있음
      - 딥러닝은 많은 수의 데이터를 통해 feature engineering 과정 없이 feature를 찾을 수 있는데 있음
  - Data가 많지 않아 CNN 학습에 어려움이 있을 때 사용가능한 방법
      - Data augmentation 활용
          - 이미지의 색깔, 각도 등을 약간씩 변형하여 data의 수를 늘림
      - Pre-trained network의 활용
          - 매우 큰 데이터셋을 미리 Training한 모델의 파라미터(가중치)를 가져와서 풀려는 문제에 맞게 모델을 재보정해서 사용하는 것
          - 미리 다양한 데이터를 가지고 학습된 모델을 사용하므로 적은 데이터에도 좋은 성능을 낼 수 있다


## Data for cats vs. dogs
  - 2013년 Kaggle의 computer vision competition data 활용
  - https://www.kaggle.com/c/dogs-vs-cats/data
  - 개와 고양이를 구분하기 위한 문제로 각 12500개의 이미지를 포함
  - Medium-resolution color JPEGs
  - 25000장의 사진 중 4000장의 cats/dogs 사진 (2000 cats, 2000 dogs)만을 사용하여 학습하여 좋은 모형을 만들어 낼 수 있을까?
      - 학습: 2000, 검증: 1000, 테스트: 1000

![image](https://user-images.githubusercontent.com/76146752/116083600-c0566900-a6d7-11eb-9bac-b8c888a7ba44.png)

- gdown 패키지 : 구글 드라이브의 공유파일 다운로드 패키지
- pip install gdwon == 3.3.1
- 코랩에는 설치되어 있음

``` python
    # 이미지 다운로드
    # gdown.download(https://drive.google.com/공유아이디,파일명)
    import gdown
    
    gdown.download(url,fname, quiet=False)
    
    # 리눅스 명령어로 디렉토리 생성
    !mkdir data
    
    # 압축풀기 -q: 로그남기지마라, -d 압축을 어디에 풀 것인지 디렉토리 지정
    !unzip -q cats_and_dogs_small.zip -d data/cats_and_dogs_small
    
```

## Build a network
  - input: 150 x 150픽셀의 RGB layer
  - Output: cat or dog (binary classification)
  - ImageDataGenerator를 이용해 파일시스템에 저장된 이미지데이터셋을 학습시킨다

## Using data augmentation
  - 학습 이미지의 수가 적어서 overfitting이 발생할 가능성을 줄이기 위해 기존 훈련 데이터로부터 그럴듯하게 이미지 변환을 통해서 이미지(데이터)를 늘리는 작업을 Image augmentation 이라고 한다
  - train_set에만 적용, validation, test set 에는 적용하지 않는다 (rescaling만 한다)


``` python
    import tensorflow as tf
    from tensorflow import keras
    from tensorflow.keras import layers
    import numpy as np
    
    np.random.seed(1)
    tf.random.set_seed(1)
    
    # 하이퍼파라미터
    LEARNING_RATE = 0.001
    DROPOUT_RATE = 0.5
    N_EPOCHS = 50
    N_BATCHS = 20
    IMAGE_SIZE =150
    
    def create_model():
      model = keras.Sequential()
      model.add(keras.layers.Input((IMAGE_SIZE,IMAGE_SIZE,3))
      
      model.add(layers.Conv2D(filters=64, kernel_size=(3,3), padding='same', activation='relu')
      model.add(layers.MaxPool2D(padding='same'))
      
      model.add(layers.Conv2D(filters=128, kernel_size = 3, padding='same', activation='relu')
      model.add(layers.MaxPool2D(padding='same'))
      
      model.add(layers.Conv2d(filters=256, kernel_size = 3, padding='same', activation='relu')
      model.add(layers.MaxPool2D(padding='same'))
      
      # classification
      model.add(layers.Flatten())
      model.add(layers.Dropout(DROPOUT_RATE))
      model.add(layers.Dense(units=512, activation='relu'))
      
      # 출력
      model.add(layers.Dense(units=1, activation='sigmoid')) #dog/cat : binary classification
      
      return model
      
      model = create_model()
      model.compile(optimizer=keras.optimizers.Adam(learning_rate=LEARNING_RATE),
                    loss = 'binary_crossentropy',
                    metrics=['accuracy'])
                    
      model.summary()
      
      # ImageDataGenerator 생성 => Augmentation, 입력 pipeline
      from tensorflow.keras.preprocessing.image import ImageDataGenerator
      import matplotlib.pyplot as plt
      
      train_dir = '/content/data/cats_and_dogs_small/train'
      test_dir = '/content/data/cats_and_dogs_small/test'
      validation_dir = '/content/data/cats_and_dogs_small/validation'
      
      # 1. ImageDataGenerator - No Augmentation
      train_datagen = ImageDataGenerator(rescale=1./255)
      test_datagen = ImageDataGenrator(rescale=1./255)
      
      # Gen.flow_from_directory() 이용해서 iterator 생성
      train_iterator = train_datagen.flow_from_directory(directory=train_dir, # 이미지들의 디렉토리
                                                         target_size = (IMAGE_SIZE,IMAGE_SIZE),
                                                         class_mode='binary',
                                                         batch_size = N_BATCHS)
                                                         
      validation_iterator = test_datagen.flow_from_directory(directory=validation_dir,
                                                             target_size = (IMAGE_SIZE,IMAGE_SIZE),
                                                             class_mode = 'binary',
                                                             batch_size = N_BATCHS)
                                                             
                                                             
      test_iterator = test_datagen.flow_from_directory(directory=test_dir,
                                                       target_size = (IMAGE_SIZE, IMAGE_SIZE),
                                                       class_mode = 'binary',
                                                       batch_size = N_BATCHS)
      
      len(train_iterator), len(validation_iterator), len(test_iterator) # 1 에폭당 steps 수
      
 ```

## Model Training(학습)

``` python
    history = model.fit(train_iterator,
                        epochs =N_EPOCHS,
                        steps_per_epoch = len(train_iterator),
                        validation_data = validation_iterator,
                        validation_steps = len(validation_iterator))
                        
    model.evaluate(test_iterator)
```
- Overfitting 발생
    - 원인 :  적은 train dataset

 
 ``` python
     train_datagen = ImageDataGenerator(rescale = 1./255,
                                        rotation_range = 40,
                                        width_shift_range = 0.2,
                                        height_shift_range = 0.2,
                                        zoom_range =0.2,
                                        horizontal_flip = True,
                                        brightness_range = (0.8,1.3),
                                        fill_mode = 'constant')
                                        
      # validation, test 용
      test_datagen = ImageDataGenerator(rescale = 1./255)
      
      
      train_iterator = train_datagen.flow_from_directory(train_dir,
                                                          target_size = (IMAGE_SIZE,IMAGE_SIZE),
                                                          class_mode = 'binary',
                                                          batch_size = N_BATCHS)
                                          
                                          
      validation_iterator = test_datagen.flow_from_directory(validation_dir,
                                                            target_size = (IMAGE_SIZE,IMAGE_SIZE),
                                                            class_mode = 'binary',
                                                            batch_size = N_BATCHS)
      
      test_iterator = test_datagen.flow_from_directory(test_dir,
                                                       target_size = (IMAGE_SIZE,IMAGE_SIZE),
                                                       class_mode = 'binary',
                                                       batch_size = N_BATCHS)
      
      # 이미지 확인
      batch_image = train_iterator.next()
      batch_image[0].shape
      
      plt.figure(figsize=(30,15))
      for i in range(20):
        plt.subplot(4,5,i+1)
        img = batch_image[0][i].astype('uint8')
        plt.imshow(img)
        plt.axis('off')
        
      plt.tight_layout()
      plt.show()
  ```
  ![image](https://user-images.githubusercontent.com/76146752/116101364-ba1cb880-a6e8-11eb-92e7-2b86aa425791.png)
  
  ``` python
      model2 = create_model()
      model2.compile(optimizer=keras.optimizers.Adam(learning_rate=LEARNING_RATE), loss='binary_crossentropy', metrics=['accuracy'])
      
      model2.fit(train_iterator,
                 epochs = N_EPOCHS,
                 steps_per_epoch = len(train_iterator),
                 validation_data = validation_iterator,
                 validation_steps = len(validation_iterator))
                 
      model2.evaluate(test_iterator)
```
## DataFrame 이용
  - flow_from_dataframe()사용
      - 파일경로와 label을 DataFrame으로 저장하고 그것을 이용해 데이터셋을 읽어온다

``` python
    import gdown
     
    url = 'https://drive.google.com/uc?id=17ejPJw42TgTv0jCPMMIVTHwF57XYE2kb'
    fname = 'cats_and_dogs_union.zip'
    gdown.download(url,fname, quiet=True)
    
    !mkdir data #data라는 디렉토리 생성
    
    !unzip -q ./cats_and_dogs_union.zip -d ./data/cats_and_dogs # cats_and_dogs_union.zip이라는 압축파일을 data의 cats_and_dogs 폴더에 푼다
```

## DataFrame 생성
  - path, label컬럼

``` python
    # 파일 경로 다루기 -glob
    from glob import glob
    
    # ** 모든 하위경로, *.jpg(확장자가 jpg인 모든 파일)
    
    path_list = glob('/content/data/cats_and_dogs/**/*.jpg') # 지정한 파일들의 absolut path(절대 경로)를 문자열로 반환(리스트에 담아서)
    
    import os
    
    f = '/content/data/cats_and_dogs/dogs/dogs.1999.jpg'
    # basename(경로) : 경로에서 파일명만 추출
    
    print(os.path.basename(f))
    
    print(os.path.dirname(f)) # dirname(경로) :경로에서 디렉토리 부분만 추출
    
    print(os.path.dirname(f).split(r'/')[4]) # label추출
    
    label_list = [os.path.dirname(path).split(r'/')[4] for path in path_list]
    
    import pandas as pd
    
    d = {
      "path":path_list,
      "label": label_list
    }
    
    data_df = pd.DataFrame(d) # path와 label로 이루어진 dataframe생성
    
    # cats, dogs DataFrame으로 분리
    cats_df = data_df[data_df['label']=='cats']
    dogs_df = data_df[data_df['label']=='dogs']
    
    split_idx = int(dogs_df.shape[0]*0.8)
    
    train_df = pd.concat([dogs_df[:split_idx],cats_df[:split_idx]],axis=0)
    
    test_df = pd.concat([dogs_df[split_idx:],cats_df[split_idx:]],axis=0)
    
    test_df['label'].value_counts()
    
    from tensorflow.keras.preprocessing.image import ImageDataGenerator
    
    train_datagen = ImageDataGenerator(rescale=1./255,
                                       rotation_range = 40,
                                       width_shift_range =0.1,
                                       height_shift_range = 0.1,
                                       zoom_range = 0.2,
                                       horizontal_flip = True,
                                       brightness_range = (0.7,1.3),
                                       fill_mode ='constant')
                                       
                                       
    # validation, test 용
    test_datagen = ImageDataGenerator(rescale=1./255)
    
    train_iterator = train_datagen.flow_from_dataframe(dataframe = train_df,
                                                       x_col = 'path', #이미지 경로를 가진 컬럼명
                                                       y_col = 'label', # label 컬럼명
                                                       target_size = (IMAGE_SIZE,IMAGE_SIZE),
                                                       class_mode = 'binary',
                                                       batch_size = N_BATCHS)
    test_iterator = test_datagen.flow_from_dataframe(dataframe = test_df,
                                                     x_col = 'path',
                                                     y_col = 'label',
                                                     target_size = (IMAGE_SIZE,IMAGE_SIZE),
                                                     class_mode = 'binary',
                                                     batch_size = N_BATCHS)
    
    train_iterator.class_indices #내부적으로 라벨인코딩 처리 해줌
    
    model = create_model()
    model.compile(optimizer=keras.optimizers.Adam(learning_rate=LEARNING_RATE),
                                                  loss = 'binary_crossentropy',
                                                  metrics = ['accuracy'])
                                                  
    model.fit(train_iterator,
              epochs = N_EPOCHS,
              steps_per_epoch = len(train_iterator),
              validation_data = test_iterator,
              validation_steps = len(test_iterator))
    
    from tensorflow.keras.preprocessing.image import load_img, img_to_array
    
    #sample이미지로 확인해보기
    def predict_cat_dog(path):
      img = load_img(path, target_size = (IMAGE_SIZE,IMAGE_SIZE))
      
      # image -> ndarray
      sample = img_to_array(img)[np.newaxis,...]
      
      #scaling
      sample = sample/255
      pred = model.predict(sample) #확률
      pred = pred[0,0]
      
      pred_class = np.where(pred<0.5,0.1)
      pred_class_name = class_name[pred_class]
      
      return pred, pred_class, pred_class_name
      
  ```
    
    
    
    
    
    
    
    
    
    
