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





