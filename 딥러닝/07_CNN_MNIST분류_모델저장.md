
# Convolutional Neural Network 구현

  - MNIST 손글씨 data를 이용하여 CNN을 학습하고 MLP와 결과 비교


``` python
    import matplotlib.pyplot as plt
    # 학습결과 그래프 함수
    # loss 그래프
    def plot_loss(history):
      plt.plot(history.history['loss'], label = 'Train loss')
      plt.plot(history.history['val_loss'], label = 'validation loss')
      plt.title('Loss')
      plt.xlabel('epoch')
      plt.ylabel('loss')
      plt.legend()
      plt.show()
    
    # accuracy 그래프
    def plot_accuracy(history):
      plt.plot(history.history['accuracy'], label='Train accuracy')
      plt.plot(history.history['val_accuracy'], label = 'Validation accuracy')
      plt.title('Accuracy')
      plt.xlabel('epoch')
      plt.ylabel('accuracy')
      plt.legend()
      plt.show()
      
 ```
 
# MNIST CNN 적용

``` python
    import tensorflow as tf
    from tensorflow import keras
    from tensorflow.keras import layers
    import numpy as np
    
    np.random.seed(1)
    tf.random.set_seed(1)
    
    # 하이퍼파라미터 설정
    LEARNING_RATE = 0.001
    N_EPOCH = 20
    N_BATCHS = 100
    N_CLASS = 10
    
    # 데이터 로드
    (train_image, train_label), (test_image, test_label) = keras.datasets.mnist.load_data()
    
    # 추가 변수 설정
    N_TRAIN = train_image.shape[0]
    N_TEST = test_image.shape[0]
    
    # 전처리 : 이미지 - 정규화 (0~1)
    #         label - one hot encoding(생략)
    X_train, X_test = train_image/255. , test_image/255.
    X_train = X_train[..., np.newaxis] # 흑백은 채널 축이 없는 경우가 대부분이기 때문에 채널을 만들어줌
    X_test = X_test[..., np.newaxis]
    y_train, y_test = train_label, test_label
    
    # dataset 구성
    train_dataset = tf.data.Dataset.from_tensor_slices((X_train,y_train)).shuffle(N_TRAIN).batch(N_BATCHS).repeat()
    test_dataset = tf.data.Dataset.from_tensor_slices((X_test,y_test)).batch(N_BATCHS)
    
```

# CNN 모델 구성
  - convolution layer의 filter 개수는 적은 개수에서 점점 늘려가는 형태
  - input shape(입력 이미지의 size): 3차원(height,width, channel)
      - 흑백 : (height, width , 1)
      - 컬러 : (height, width , 3)

``` python
    def create_model():
      model = keras.Sequential()
      model.add(layers.Input((28,28,1))) # Input shape (모든 학습데이터 이미지 사이즈가 다름)
      # Convolution layer : Conv2D => MaxPool2D
      model.add(layers.Conv2D(filters = 32, # Filter 개수
                              kernel_size = (3,3), # filter 사이즈
                              padding = 'same', # padding방식 :'valid','same'
                              strides = (1,1),
                              activation = 'relu'))
                              
      # Max Pooling layer => MaxPool2D
      model.add(layers.MaxPool2D(pool_size=(2,2), 
                                 strides = (2,2), # default : None => pool_size를 사용 두개의 값이 같으면 정수 # max pooling layer => MaxPool2D
                                 padding = 'same')) # valid - 뒤에 남은 것은 버림
                              
      model.add(layers.Conv2D(filters = 64,
                              kernel_size = 3,
                              padding = 'same',
                              strides = 1,
                              activation = 'relu'))
                              
      model.add(layers.Conv2D(filters = 64, kernel_size = 3, padding='same', strides =1, activation = 'relu'))
       
      model.add(layers.MaxPool2D(padding='same')) # pool_size, strides : default 값으로 설정
      
      # Classification Layer => Fully Connected Layer
      # Conv 거친 Feature map 은 3차원 배열 => Flatten() : 1차원 배열로 변환
      model.add(layers.Flatten())
      model.add(layers.Dense(N_CLASS, activation = 'softmax'))
      
      return model
      
    model = create_model()
    model.summary()
    
    keras.utils.plot_model(model, show_shapes=True)
```
![image](https://user-images.githubusercontent.com/76146752/115894255-058a5900-a494-11eb-9c25-d1c4fa48fe5c.png)

``` python
    model.compile(optimizer=keras.optimizers.Adam(learning_rate=LEARNING_RATE),
                  loss = 'sparse_categorical_crossentropy', # sparse_categorical_crossentropy
                  metrics = ['accuracy'])
                  
    steps_per_epoch = N_TRAIN//N_BATCHS
    validation_steps = int(np.ceil(N_TEST/N_BATCHS))
    
    history = model.fit(train_dataset, epochs = N_EPOCHS, steps_per_epoch = steps_per_epoch, validation_data = test_dataset, validation_steps = validation_steps)
    
    plot_loss(history)
```
![image](https://user-images.githubusercontent.com/76146752/115895814-c957f800-a495-11eb-9f7b-3d000d36330e.png)

``` python
    model.evaluate(test_dataset)
    plot_accuracy(history)
```
![image](https://user-images.githubusercontent.com/76146752/115895877-d7a61400-a495-11eb-9611-4b475deeafcc.png)

## prediction error 가 발생한 example 확인

``` python
    pred = model.predict(X_test)
    pred_class = np.argmax(pred, axis =-1)
    pred_class[:10]
    
    # pred_class: 예측결과, y_test : 실제정답
    # 예측이 틀린 index를 조회
    error_idx = np.where(pred_class != y_test)[0]
    
    # 틀린것 10개 확인
    plt.figure(figsize=(15,10))
    for i in range(10):
      plt.subplot(2,5,i+1)
      plt.imshow(test_image[error_idx[i]], cmap='gray')
      plt.title(f'label:{y_test[error_idx[i]]}, pred:{pred_class[error_idx[i]]}')
      plt.axis('off')
      
    plt.tight_layout()
    plt.show()
```
![image](https://user-images.githubusercontent.com/76146752/115897076-0375c980-a497-11eb-8439-064f677ef8d5.png)

## 모델 저장
  1. 학습이 끝난 모델의 파라미터만 저장
  2. 모델 전체 저장
  3. callback 함수를 이용해 학습시 가장 좋은 지표의 모델을 저장

### 텐서플로 파일 타입
  - checkpoint
      - 모델의 weight를 저장하기 위한 파일타입
  - SavedModel
      - 모델의 구조와 파라미터들을 모두 저장하는 형식


## 학습한 Weight(파라미터) 저장 및 불러오기
  - 가중치를 저장하여 나중에 재학습없이 학습된 가중치를 사용할 수 있다
  - 저장 : model.load_weights('불러올경로')
  - 저장형식
        - Tensorflow Checkpoint(기본방식)
        - HDF5
            - save_weight(.., save_format='h5')

``` python
    # 저장할 경로
    import os
    base_dir = '/content/drive/MyDrive/saved_models' # 모델/파라미터 저장할 root
    weight_dir = os.path.join(base_dir, 'mnist','weights')
    
    if not os.path.isdir(weight_dir):
      os.makedirs(weight_dir, exist_ok = True) # exist_ok = False(기본) : 이미경로가 있으면 예외발생,  True: 예외발생 안시킴
    weight_path = os.path.join(weight_dir, 'mnist_cnn_weights.ckpt') # 저장할 디렉토리 + 파일명
    
    model.save_weights(weight_path)
    
    new_model1 = create_model()
    new_model1.compile(optimizer=keras.optimizers.Adam(learning_rate = LEARNING_RATE), loss = 'sparse_categorical_crossentropy', metrics=['accuracy'])
    
    new_model1.evaluate(test_dataset)
    
    # 파일로 저장된 weight들을 생성된 모델(네트워크)에 저장
    new_model1.load_weight(weight_path) # 재학습할 필요없이 저장된 가중치를 불러올 수 있음
    
    new_model1.evaluate(test_dataset)
```

``` python
    # hdf5형식으로 저장/불러오기
    weight_h5_dir = os.path.join(base_dir,'mnist','weight_h5')
    if not os.path.isdir(weight_h5_dir)"
      os.makedirs(weight_h5_dir):
      
    weight_h5_path = os.path.join(weight_h5_dir, 'mnist_cnn_weight.h5')
    
    model.save_weights(weight_h5_path, save_fromat='h5')
    
    new_model2 = create_model()
    new_model2.compile(optimizer=keras.optimizers.Adam(learning_rate=LEARNING_RATE),loss='sparse_categorical_crossentropy',metrics=['accuracy'])
    
    new_model2.evaluate(test_dataset)
    new_model2.load_weights(weight_h5_path)
    new_model2.evaluate(test_dataset)
    
```

### 전체 모델 저장하고 불러오기
  - 저장: `model.save('저장할디렉토리')`
  - 불러오기: `tf.keras.models.load_model('저장파일경로')`
  - 저장형식
      - Tensorflow SavedModel 형식(기본방식)
          - 모델 아키텍처 및 훈련 구성(옵티마이저, 손실 및 메트릭 포함)은 save_model.pb에 저장된다
          - 파라미터는 variables/디렉토리에 저장된다
      - HDF5 형식
          - save(..., save_fromat='h5') 로 지정한다

  ``` python
      model_dir = os.path.join(base_dir, 'mnist','models','saved_model')
      if not os.path.isdir(model_dir):
        os.makedirs(model_dir, exist_ok = True)
        
      model.save(model_dir) # SaveModel 형식으로 저장시 디렉토리를 지정
      
      new_model3 = tf.keras.models.load_model(model_dir)
      new_model3.compile(optimizer = keras.optimizers.Adam(learning_rate = LEARNING_RATE),loss='sparase_categorical_crossentropy',metrics=['accuracy'])
      
      new_model3.summary()
      
      new_model3.evaluate(test_dataset)
      
      # h5 형식으로 저장/불러오기
      model_h5_dir = os.path.join(base_dir, 'mnist','models','h5_model')
      if not os.path.isdir(model_h5_dir):
        os.makedirs(model_h5_dir, exist_ok=True)
        
      # h5 형식으로 저장할 때 파일명까지 지정
      model_h5_path = os.path.join(model_h5_dir, 'mnist_cnn_model.h5')
      
      model.save(model_h5_path, save_format='h5')
      
      new_model4 = tf.keras.models.load_model(model_h5_path)
      
      new_model4.summary()
      
      new_model4.evaluate(test_dataset)
  ```
  
  ### Callback을 사용한 모델 저장 및 Early Stopping
   
   - callback은 학습하는 도중 특정 이벤트 발생시 호출되는 다양한 함수를 제공하여 자동화처리를 지원한다(cf: 프로그래밍의 콜백함수)
   - 다양한 콜백 클래스가 제공된다
   - EarlyStopping : **Validation set**에 대한 평가 지표가 더 이상 개선되지 않을 때 학습을 자동으로 멈춤
      - monitor: 모니터링할 평가지표 지정( ex. accuracy)
      - patience : epoch 수 지정. validation 평가 지표가 개선이 안되더라도 지정한 epoch만큼 반복한다 지정한 epoch만큼 반복 후에도 개선이 되지 않으면 중단한다
   - ModelCheckpoint: 지정한 평가 지표(ex. validation loss)가 가장 좋을 때 모델과 weight를 저장하여 overfitting이 발생하기 전의 model을 나중에 불러들여 사용할 수 있음
      - save_best_only = monitoring 중인 measure를 기준으로 최적의 모형의 weight만 저장

   - **callback 객체들을 리스트로 묶은 뒤 fit()의 callback 매개변수에 전달한다**

``` python
    model2 = create_model()
    model2.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics = ['accuaracy'])
    
    model2.evaluate(test_dataset)
    
    callback_dir = os.path.join(base_dir, 'mnist','models','callback')
    if not os.path.isdir(callback_dir):
      os.makedirs(callback_dir, exist_ok=True)
      
    callback_path = os.path.join(callback_dir, 'save_model_{epoch:02d}.ckpt') # 포맷문자열 역할을 함 몇번째 에폭 때 저장하는지 저장
    
    # ModelCheckpoint callback 생성
    mc_callback = keras.callbacks.ModelCheckpoint(filepath = callback_path, save_weights_only = True, monitor = 'val_loss',verbose = 1)
    
    # EarlyStopping callback 생성
    es_callback = keras.callbacks.EarlyStopping(monitor='val_loss',patience=5) # 5 에폭을 학습하는 동안 loss 가 좋아지지 않으면 학습을 멈춰라
      
    model2.fit(train_dataset, epochs = N_EPOCHS, steps_per_epoch = steps_per_epoch, validation_data = test_dataset, validation_steps = validation_steps, callbacks = [mc_callback,es_callback])
    
    # 저장된 weight loading
    new_model5 = create_model()
    new_model5.compile(optimizer = 'adam', loss='sparse_categorical_crossentropy',metrics=['accuracy'])
    
    # weight들이 저장된 디렉토리를 지정하면 마지막 에폭에서 저장된 weight를 불러온다
    best_weights = tf.train.latest_checkpoint(callback_dir)
    
    new_model5.load_weights(best_weights)
```
    
    
    
    
    


