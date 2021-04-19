## Keras를 사용한 개발 과정
  1. 입력 텐서(X)와 출력 텐서(y)로 이뤄진 훈련 데이터를 정의
  2. 입력과 출력을 연결하는 Layer(층)으로 이뤄진 네트워크(모델)을 정의
      - Sequential 방식: 순서대로 쌓아올린 네트워크로 이뤄진 모델을 생성하는 방식
      - Functional API 방식: 다양한 구조의 네트워크로 이뤄진 모델을 생성하는 방식
      - subclass 방식: 네트워크를 정의하는 클래스를 구현
  3. 모델 컴파일
      - 모델이 Train(학습)할 때 사용할 손실함수(Loss Function), 최적화기법(Optimizer), 학습과정을 모니터링할 평가지표(Metrics)를 설정
  4. Training(훈련)
      - 모델의 fit() 메소드에 훈련데이터(X,y)를 넣어 Train

![image](https://user-images.githubusercontent.com/76146752/115168571-6c0b2200-a0f6-11eb-9c23-837a5124d912.png)

### MNIST 이미지 분류
  - MNIST(Modified National Institute of Standards and Technology) database
  - 흑백 손글씨 숫자 0-9까지 10개의 범주로 구분해놓은 데이터셋
  - 하나의 이미지는 28*28pixel의 크기
  - 6만개의 Train 이미지와 1만개의 Test이미지로 구성됨
  - 
    ``` python
        import tensorfloww as tf
        from tensorflow import keras
        
        (X_train,y_train),(X_test,y_test) = keras.datasets.mnist.load_data()
        
        import matplotlib.pyplot as plt
        
        plt.figure(figsize=(15,5))
        
        for i in range(5):
          plt.subplot(1,5,i+1)
          plt.imshow(X_train[i], cmap='gray')
          plt.title(y_train[i])
          plt.axis('off')
          
        plt.show()
    ```
![image](https://user-images.githubusercontent.com/76146752/115178569-89e38180-a10c-11eb-833d-f337845de4ec.png)


### 신경망 구현
  ### network: 전체 모델 구조 만들기
     - 
      ``` python
          # 모델 생성
          model = keras.Sequential()
          # 층(layer)을 모델에 추가
          model.add(keras.layers.Input((28,28))
          model.add(keras.layers.Flatten())
          model.add(keras.layers.Dense(256,activation='relu'))
          model.add(keras.layers.Dense(128,activation='relu'))
          model.add(keras.layers.Dense(10,activation='softmax'))
          
          model.summary()
      ```
      
 ### 컴파일 단계
   
   - 구축된 모델에 추가 설정
   - 손실함수
   - Optimizer(최적화 함수)
   - 평가지표
   - 
      ``` python
          model.complie(optimizer='adam', #Optimizer 등록
          loss = 'categorical_crossentropy', # Loss function 등록
          metrics = ['accuracy']) #평가지표 - Training 도중에 validation 결과를 확인
      ```
    
 ### 데이터 준비
  - X
    - 0~1사이의 값으로 정규화 시킨다
  - y
    - one hot encoding 처리
    - tensorflow.keras의 to_categorical() 함수 이용

  - 
    ``` python
        X_train = X_train/255
        X_test = X_test/255
        
        y_train = keras.utils.to_categorical(y_train) # 원핫인코딩
        y_test = keras.utils.to_categorical(y_test)
        
    ```
    
### 학습 (fit)
  - 
    ``` python
        model.fit(X_train,y_train,
                  epochs= 10, # epoch:전체 train dataset을 한 번 학습 -> 1 epoch
                  batch_size = 100, # 파라미터 업데이트(최적화)를 100개마다 한번씩 함
                  validation_split=0.2)
                  
    ```
    
### 테스트셋 평가
  - 
    ``` python
        test_loss, test_acc = model.evaluate(X_test, y_test)
        print(test_loss, test_acc)
        
    ```
    
#### 추론 메소드
  - predict()
      - 각 클래스 별 확률 반환 (proba의 역할을 함)
  - <del>predict_class()</del>
      - 클래스(범주값) 반환
      - tensorflow 2.3부터 dprecated 됨
  - 이진 분류(binary classification)
      - `numpy.argmax(model.predict(x) >0.5).astype('int32')
  - 다중클래스 분류(multi-class classification)
      - `numpy.argmax(model.predict(x), axis=-1)`

  - 
    ``` python
        import numpy as np
        np.argmax(y_test[:10], axis=-1)
        
        # 추론 => class별 확률
        pred = model.predict(X_test[:10])
        
        np.argmax(pred, axis=-1)
        
        model.predict_classes(X_test[:10])
    ```









