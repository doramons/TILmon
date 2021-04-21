## 데이터셋 API
  - 데이터 입력 파이프라인을 위한 패키지
  - tf.data 패키지에서 제공
  - tf.data.Dataset 추상클래스에서 상속된 여러가지 클래스 객체를 사용 또는 만들어 쓴다
  
### 데이터 입력 파이프라인이란

 **모델에 공급**되는 데이터에 대한 전처리 작업과 공급을 담당한다
 
  - 이미지 데이터의 경우
      - 분산 파일시스템으로부터 이미지를 모으는 작업
      - 이미지에 노이즈를 주거나 변형하는 작업
      - 배치학습을 위해 무작위로 데이터를 선택하여 배치데이터를 만드는 작업
    
  - 텍스트 데이터 경우
      - 원문을 토큰화하는 작업
      - 임베딩하는 작업
      - 길이가 다른 데이터를 패딩하여 합치는 작업

## 데이터셋 API 사용 세단계

1. 데이터셋 생성
    - from_tensor_slices(), from_generator() 클래스 메소드,
    - from_tensor_slices() : 리스트 넘파이배열, 텐서플로 자료형에서 데이터를 생성한다
2. 데이터셋 변형: map(), filter(), batch() 등 메소드를 이용해 데이터 소스를 변형한다
3. for 반복문에서 iterate를 통해 데이터셋 사용


## Dataset의 주요 메소드
  - map(함수) : dataset의 각 원소들을 함수로 처리한다
  - shuffle(크기): dataset의 원소들의 순서를 섞는다. 크기는 섞는 공간의 크기로 **데이터보다 크거나 같으면** 완전셔플, **적으면 일부만 가져와서 섞어서** 완전셔플이 안된다 => 데이터가 너무너무 많으면 적게 주기도 한다
  - batch(size) : 반복시 제공할 데이터 수. 지정한 batch size만큼 data를 꺼내준다
  - 
    ``` python
        import tensorflow as tf
        import numpy as np
        
        arr = np.arange(9)
        
        # 메모리에 ndarray로 저장된 데이터를 이용해 Dataset 객체를 생성
        dataset = tf.data.Dataset.from_tensor_slices(arr)
        
        # 각각 원소를 변환 작업을 Dataset 추가 - Dataset.map(변환함수)
        dataset= dataset.map(lambda x: x**2)
        
        dataset = dataset.filter(lambda x: x%2 ==0) # 2의 배수만 걸러내기
        
        dataset = dataset.shuffle(3) # 데이터를 섞어줌
        
        dataset = dataset.batch(4) # 한번에 지정한 개수만큼 제공 # drop_remainder = True로 설정하면 batch_size로 나누어 떨어지지 않는 나머지 행은 나오지 않음
        
        # Dataset에서 제공되는 값들을 조회
        for a in dataset:
          print(a)
          
        x = np.arange(10)
        y = np.arange(10,20)
        x.shape, y.shape
        
        ds = tf.data.Dataset.from_tensor_slices((x,y))
        
        ds2 = ds.map(lambda x,y: (x**2, y)) # x: 제곱, y로 출력
        
        ds3 = ds2.shuffle(10)
        
        
        ds4 = ds2.batch(4)
        
        #dataset.repeat(count), count횟수만큼 반복, 공백시 무한반복
        for a in ds4.repeat(3):
          print(a)
        
        
        # 한번에 처리
        dataet = tf.data..Dataset.from_tensor_slices((x,y)).map(lambda x,y:(x**2,y)).shuffle(10).batch(4).repeat(3) 
        
        
    ```
    
## 1. 회귀 = Boston Housingn Dataset
  보스턴 주택가격 dataset은 다음과 같은 속성을 바탕으로 해당 타운 주택 가격의 중앙값을 예측하는 문제
  
  - CRIM : 범죄율
  - ZN : 25000 평방피트당 주거지역 비율
  - INDUS: 비소매 상업지구 비율
  - CHAS : 찰스강에 인접해 있는지 여부(인접:1, 아니면:0)
  - NOX:: 일산화질소 농도(단위: 0.1ppm)
  - RM :주택당 방의 수
  - AGE: 1940년 이전에 건설된 주택의 비율
  - DIS: 5개의 보스턴 직업고용센터와의 거리(가중평균)
  - RAD : 고속도로 접근성
  - TAX :재산세율
  - PTRATIO:학생/교사 비율
  - B: 흑인 비율
  - LSTAT: 하위 계층 비율

 예측해야하는 것
  - MEDV:타운의 주택가격 중앙값(단위: 1,000달러)


- 
  ``` python
      import numpy as np
      import tensorflow as tf
      from tensorflw import keras
      
      # random seed
      np.random.seed(1)
      tf.random.set_seed(1)
      
      # 데이터셋 로딩
      (X_train,y_train),(X_test,y_test) = keras.datasets.boston_housing.load_data()
      
      # 하이퍼파라미터 값들을 설정
      
      LEARNING_RATE = 0.001 # 학습률
      N_EPOCHS = 200
      N_BATCHS = 32
      N_TRAIN = X_train.shape[0]
      N_TEST = X_test.shape[0]
      N_FEATURES = X_train.shape[1]
      
      # dataset 생성
      train_dataset = tf.data.Dataset.from_tensor_slices((X_train,y_train)).shuffle(N_TRAIN).batch(N_BACTHS,drop_remainder=True).repeat()
      val_dataset = tf.data.Dataset.from_tensor_slices((X_test,y_test)).batch(N_BATCHS)
      
      # 모델 생성
      def create_model():
        model = keras.Sequential()
        # 입력층 생략
        model.add(keras.layers.Dense(units=16,activation='relu', input_shape=(13,)))
        model.add(keras.layers.Dense(units=8, activation='relu'))
        # 출력 layer
        model.add(keras.layers.Dense(units=1)) # 회귀의 출력층 units수 는 1, activation함수는 사용하지 않는다
        
        # 모델 컴파일
        model.compile(optimizer=tf.keras.optimizer.Adam(learning_rate=LEARNING_RATE),loss='mse') # 회귀의 loss함수는 :mse
        return model
        
       model = create_model()
       
       model.summary()
       
       # 1 step: 한번 가중치를 업데이트. batch size
       # 1 epoch: 전체 train 데이터를 한 번 학습
       
       steps_per_epoch = N_TRAIN // N_BATCHS
       validation_steps = int(np.ceil(N_TEST/N_BATCHS))
       
       history = model.fit(train_dataset, # train dataset(X_train, y_train)
                           epochs = N_EPOCHS,
                           steps_per_epoch = steps_per_epoch, # 1 에폭당 step 수(가중치 업데이트)
                           validation_data = val_dataset,
                           validation_steps = validation_steps)
       
       hisory.hitory.keys()
       
       # epoch당 loss와 val_loss 변화에 대해 선그래프 그리기
       import matplotlib.pyplot as plt
       
       plt.figure(figsize=(10,7))
       plt.plot(range(1,N_EPOCHS+1),history.history['loss'], label = 'Train loss')
       plt.plot(range(1,N_EPOCHS+1), history.hisory['val_loss'], label='Validation loss')
       
       plt.xlabel('Epochs')
       plt.ylabel('Loss(MSE)')
       plt.ylim(0,90)
       plt.legend()
       plt.grid(True)
       plt.show()
       
       # t
       model.evaluate(val_dataset)
   ```
   ![image](https://user-images.githubusercontent.com/76146752/115522233-e5596f00-a2c6-11eb-8643-9f6b3c2eb9a6.png)

## 2. Classification
  ### Fashion MNIST(MNIST) Dataset
  
  10개의 범주(category)와 70000개의 흑백 이미지로 구성된 패션 MNIST 데이터셋. 이미지는 해상도(28\*28 픽셀)가 낮고 다음처럼 개별 의류 품목을 나타낸다
![image](https://user-images.githubusercontent.com/76146752/115522874-76304a80-a2c7-11eb-8d62-a2e67a3dfa13.png)

패션 MNIST와 손글씨 MNIST는 비교적 작기 때문에 알고리즘의 작동 여부를 확인하기 위해 사용되곤 하며 코드를 테스트하고 디버깅하는 용도로 좋다

이미지는 28\*28 크기의 넘파이 배열이고 픽셀 값은 0과 255 사이이다. 레이블(label)은 0에서 9 까지의 정수 배열이다 아래 표는 이미지에 있는 의류의 **클래스(class)** 를 나타낸다

각 이미지는 하나의 레이블에 매핑되어있다. 데이터셋에 클래스 이름이 들어있지 않기 때문에 나중에 이미지를 출력할 때 사용하기 위해 별도의 변수를 만들어 저장한다

- 
  ``` python
      class_names = ['T-shirt/top','Trouser','Pullover','Dress','Coat','Sandal','Shirt','Sneaker', 'Bag', 'Ankle boot']
      import numpy as np
      import tensorflow as tf
      from tensorflow import keras
      
      np.random.seed(1)
      tf.random.set_seed(1)
      
      # 데이터셋 읽기
      (X_train, y_train), (X_test,y_test) = keras.datasets.fashion_mnist.load_data()
      
      # 이미지 확인
      import matplotlib.pylot as plt
      plt.figure(figsize=(15,15))
      for i in range(25):
        plt.subplt(5,5,i+1)
        plt.imshow(X_train[i], cmap='gray')
        plt.title(class_names[y_train[i]])
        
      plt.tight_layout()
      plt.show()
  ```
  ![image](https://user-images.githubusercontent.com/76146752/115524951-9b25bd00-a2c9-11eb-8d6c-be5de6d40781.png)
 - 
   ``` python
       # 하이퍼파라미터 설정
       LEARNING_RATE = 0.001
       N_EPOCHS = 50
       N_BATCHS = 100
       
       N_CLASS = 10 # class category 의 개수
       N_TRAIN = X_train.shape[0]
       N_TEST = X_test.shape[0]
       IMAGE_SIZE = 28
       
       # 데이터 전처리
       # X(이미지) : 0~255
       X_train = X_train/255
       X_test = X_test/255
       
       # Y(label) => 다중분류: OneHotEncoding
       y_train = keras.utils.to_categorical(y_train)
       y_test = keras.utils.to_categorical(y_test)
       
       # Dataset
       train_dataset = tf.data.Dataset.from_tensor_slices((X_train,y_train)).shuffle(N_TRAIN).batch(N_BATCHS, drop_remainder=True).repeat
       val_dataset = tf.data.Dataset.from_tensor_slices((X_test,y_test)).batch(N_BATCHS)
       
       # 모델 구현
       def create_model():
        model = keras.Sequential()
        # 입력층(Input Layer)
        model.add(keras.layers.Input((28,28)))
        model.add(keras.layers.Flatten())
        
        # 은닉층(Hidden layer)
        model.add(keras.layers.Dense(256, activation='relu'))
        model.add(keras.layers.Dense(128, activation = 'relu'))
        model.add(keras.layers.Dense(64, activation='relu'))
        
        # 출력층(Output layer)
        # 다중분류: unit-class category 개수, activation-softmax => 각 class별 확률
        model.add(keras.layers.Dense(N_CLASS, activation='softmax'))
        
        # 컴파일. 다중분류 : loss-categorical_crossentropy (y를 onehotencoding)
        model.compile(optimizer = keras.optimizers.Adam(learning_rate=LEARNING_RATE),loss='categorical_crossentropy',metrics=['accuracy'])
        
        return model
        
       model = create_model()
       
       model.summary()
       
       
       plot_model(model,show_shapes=True)
   ```
   
  ![image](https://user-images.githubusercontent.com/76146752/115548173-2317c100-a2e2-11eb-859f-93241fbee37f.png)

 - 
   ``` python
       # 학습
       ## 에폭당 steps 수 계산
       steps_per_epoch = N_TRAIN// N_BATCHS
       validation_steps = int(np.ceil(N_TEST/N_BATCHS))
       
       model.fit(train_dataset,
                 epoch = N_EPOCHS,
                 steps_per_epoch = steps_per_epoch,
                 validation_data = val_dataset,
                 validation_steps = validation_steps)
                 
       # 평가 -test set
       model.evaluate(val_dataset)
       
       # 결과 시각화 (loss와 지정한 평가 지표의 epoch 당 변화를 시각화)
       history.history.keys()
       
       plt.figure(figsize=(20,10))
       plt.subplot(1,2,1)
       
       plt.plot(range(1,N_EPOCHS+1), history.history['loss'], label = 'train loss')
       plt.plot(range(1,N_EPOCHS+1), history.history['val_loss'], label='validation loss')
       plt.title('LOSS')
       plt.legend()
       
       plt.subplot(1,2,2)
       plt.plot(range(1,N_EPOCHS+1), history.history['accuracy'],label='train accuracy')
       plt.plot(range(1,N_EPOCHS+1), history.history['val_accuracy'],label='validation accuracy')
       plt.title('ACCURACY')
       plt.legend()
       
       plt.tight_layout()
       plt.show()
   ```
   ![image](https://user-images.githubusercontent.com/76146752/115559810-ff0eac80-a2ee-11eb-9f4b-96aef200495d.png)

### IMDB 감정분석

#### 이진분류(Binary Classification)
  - 영화댓글 - 부정(0)/긍정(1)
  - 
    ``` python
        import pickle
        
        # 데이터로드
        with open('C:/Users/Playdata/source/텍스트분석/imdb_dataset/x_train.pkl','rb') as f:
          X_train = pickle.load(f)
          
        with open('C:/Users/Playdata/source/텍스트분석/imdb_dataset/x_test.pkl','rb') as f:
          X_test = pickle.load(f)
          
        with open('C:/Users/Playdata/source/텍스트분석/imdb_dataset/y_train.pkl','rb') as f:
          y_train = pickle.load(f)
          
        with open('C:/Users/Playdata/source/텍스트분석/imdb_dataset/y_test.pkl','rb') as f:
          y_test = pickle.load(f)
          
        # X -> 벡터화(숫자변경)
        from sklearn.feature_extraction.text import TfidfVectorizer
        tfidf = TfidfVectorizer(max_features=10000)
        tfidf.fit(X_train+X_test)
        X_train_tfidf = tfidf.transform(X_train)
        X_test_tfidf = tfidf.transform(X_test)
        
        # 하이퍼파라미터 설정
        LEARNING_RATE = 0.001
        N_EPOCHS = 10
        N_BATCHS = 50
        N_TRAIN = X_train_tfidf.shape[0]
        N_TEST = X_test_tfidf.shape[0]
        N_FEATURE =X_train_tfidf.shape[1]
        
        # Dataset 생성 - y :이진분류 - one hot  encoding(X)
        # sparse matrix => ndarray
        
        train_dataset = tf.data.Dataset.from_tensor_slices((X_train_tfidf.toarray(), y_train)).shuffle(N_TRAIN).batch(N_BATCHS, drop_remainder=True).repeat()
        val_dataset = tf.data.Dataset.from_tensor_slices((X_test_tfidf.toarray(),y_test)).batch(N_BATCHS)
        
        def create_model():
          model = keras.Sequential()
          # input layer
          model.add(keras.layers.Input(N_FEATURE,))
          
          # hidden layer
          model.add(keras.layers.Dense(512,activation='relu'))
          model.add(keras.layers.Dense(256,activation='relu'))
          model.add(keras.layers.Dense(256,activation='relu'))
          model.add(keras.layers.Dense(128,activation='relu'))
          
          # Output layer : 이진분류 : units=1, activation = 'sigmoid': logistic 함수
          model.add(keras.layers.Dense(1, activation = 'sigmoid'))
          
          # 컴파일: 이진분류 - activation :sigmoid => loss binary_crossentroy
          model.compile(optimizer=keras.optimizers.Adam(learning_rate=LEARNING_RATE),
                        loss = 'binary_crossentropy',
                        metrics = ['accuracy'])
                        
          return model
          
         model = create_model()
         model.summary()
         
         plot_model(model, show_shapes=True)

          
    ```
    ![image](https://user-images.githubusercontent.com/76146752/115565152-18febe00-a2f4-11eb-8412-01ac12eb0470.png)
   - 
     ``` python
         # 학습
         steps_per_epoch = N_TRAIN//N_BATCHS
         validation_steps = int(np.ceil(N_TEST/N_BATCHS))
         
         history = model.fit(train_dataset,
                             epochs = N_EPOCHS,
                             steps_per_epoch = steps_per_epoch,
                             validation_data = val_dataset,
                             validation_steps = validation_steps)
                             
          # 평가
          model.evaluate(val_dataset)
      ```
     

      
        
