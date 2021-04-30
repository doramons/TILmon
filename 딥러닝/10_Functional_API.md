## Functional API
  - Sequential 모델은 각 Layer들의 입력과 출력이 하나라고 가정한다 그리고 각각의 Layer(입력층, 은닉층, 출력층)들을 차례대로 쌓아 구성한다
  - 함수형 API를 사용하면 **다중입력, 다중출력, 그래프 형태**의 다양한 형태의 모델을 유연하게 구성할 수 있다
  - Functional API는 직접 텐서들의 입출력을 다룬다
  - 함수호출처럼 Layer를 이용하여 텐서를 입력 받고 출력하는 형식으로 모델을 구현한다

      - 코드상에서는 Layer를 입력받는 형식으로 작성한다

    ```
    input_tensor = input(shape=(16,))
    dense = layers.Dense(32, activation='relu')(input_tensor)
    output_tensor = layers.Dense(32, activation='sigmoid')(dense)
    
    model = models.Model(input_tensor, output_tensor)
    ```
    
 ``` python
     class Test:
        def __init__(self, name):
          self.name = name
          
        def __call__(self): # 객체를 함수처럼 호출할 수 있게 해주는 특수 메소드
          print(self.name)
          
        def m(self):
          print('M')
          
      # 원래는 객체를 t.name t.m() 이런식으로 호출했는데 함수 형식으로 호출함
      t()
        
      Test('홍길동')()
```

## Sequential, Functional API

  ### Sequential
``` python
    import tensorflow as tf
    from tensorflow import keras
    from tensorflow.keras import layers, models
    
    seq_model = keras.Sequential()
    seq_model.add(layers.Input(shape=(32,32,3)))
    seq_model.add(layers.Conv2D(filters=64, kernel_size=3, activation='relu'))
    seq_model.add(layers.Flatten())
    seq_model.add(layers.Dense(units=256, activation='relu'))
    seq_model.add(layers.Dense(units=10, activation='softmax', name = 'output_layer'))
    
    seq_model.summary()
```
  ### Functional

``` python
    input_tensor = layers.Input(shape=(32,32,3))
    x = layers.Conv2D(filters=64, kernel_size=3, padding='same', activation='relu')(inout_tensor)
    x = layers.MaxPool2D(padding='same')(x)
    
    x = layers.Flatten()(x)
    
    x = layers.Dense(units=256, activation='relu')(x)
    x = layers.Dense(units=128)(x)
    
    x = layers.BatchNormalization()(x)
    x = layers.ReLU()(x)
    
    output_tensor = layers.Dense(units=10, activation='softmax')(x)
    
    fn_model = models.Model(input_tensor, output_tensor) # (입력텐서,출력텐서)
    
    fn_model.summary()
    
    keras.utils.plot_model(fn_model, show_shapes=True)
    
```
![image](https://user-images.githubusercontent.com/76146752/116552230-c5afef80-a933-11eb-86db-3910d262dafb.png)   

### 레이어를 합치는 함수

  - concatenate(list, axis=-1)
      - 레이어들을 합친다
      - list : 합칠 레이어들을 리스트에 묶어 전달
      - axis : 합칠 기준축 (기본값: -1 , 마지막 축기준)
  - add(list), substract(list), multiply(list)
      - 같은 index의 값들을 계산해서(더하기,빼기, 곱하기) 하나의 레이어로 만든다
      - list: 합칠 레이어들을 리스트에 묶어서 전달

``` python
    # Residual block
    input_tensor = layers.Input((32,32,3))
    x = layers.Conv2D(64, kernel_size=3, padding='same', activation='relu')(input_tensor)
    x1 = layers.Conv2D(64, kernel_size=3, padding='same')(x)
    b1 = layers.BatchNormalization()(x1)
    add1 = layers.add([x,b1])
    r = layers.ReLU()(add1)
    
    r_block_model = models.Model(input_tensor,r)
    
    keras.utils.plot_model(r_block_model)
```
![image](https://user-images.githubusercontent.com/76146752/116559414-67870a80-a93b-11eb-83f0-42db7834c521.png)

## 다중 출력 모델

  - 가정
      - iris 데이터셋에서 꽃받침 너비와 높이로 꽃잎의 너비, 높이, 꽃 종류를 예측하는 모델
      - 출력 결과가 3개가 나와야 한다
  - X : 꽃받침 너비, 높이
  - y : 꽃잎 너비, 높이, 꽃 종류

``` python
    from sklearn.datasets import load_iris
    
    iris = load_iris()
    X,y = iris['data'],iris['target']
    
    y1 = X[:,2] # 꽃잎 너비
    y2 = X[:,3] # 꽃잎 높이
    y3 = y # 품종
    X = X[:,[0,1]]
    
    import tensorflow as tf
    from tensorflow import keras
    from tensorflow.keras import layers, models
    
    input_tensor = layers.Input((2, ))
    x = layers.Dense(units=16, activation = 'relu')(input_tensor)
    x = layers.Dense(units=8, activation = 'relu')(x)
    output1 = layers.Dense(units=1, name = 'petal_width_output')(x) # 꽃잎 너비 예측(Regression = 1, activation=X)
    output2 = layers.Dense(units=1, name = 'petal_length_output')(x) # 꽃잎 높이 예측(Regression: units=1, activation=X)
    output3 = layers.Dense(units=3 , activation = 'softmax', name = 'species_output')(x) # 품종예측(다중분류: units: class개수(3), activation='softmax')
    
    model = models.Model(input_tensor,[output1,output2,output3])
    
    keras.utils.plot_model(model, show_shapes=True)
```
![image](https://user-images.githubusercontent.com/76146752/116640856-735be680-a9a6-11eb-901a-29db658e93a2.png)

  - 컴파일
    - 출력이 3개 이므로 각각의 순서대로 loss를 리스트로 묶어서 제공
    - 역전파를 통해 weight를 업데이트할 때 위 세 개의 loss를 더한 총 loss로 역전파함
    - loss가 출력이 따로 따로 되기 떄문에 accuracy를 주지 않는다
``` python
    # compile
    model.compile(optimizer='adam',
                  loss = ['mse','mse', 'sparse_categorical_crossentropy']
                  
    history = model.fit(X, [y1,y2,y3],
                        epochs = 100,
                        validation_split=0.1)
                        
                        
    import matplotlib.pyplot as plt
    plt.figure(figsize=(10,7))
    
    plt.plot(history.history['loss'],label='train loss')
    plt.plot(history.history['val_loss'], label = 'val loss')
    
    plt.legend()
    plt.show()
    
    model.evaluate(X, [y1,y2,y3])
    # [총로스, output1 loss, output2 loss, output3 loss]
    
    # 추론
    model.predict(X[:2])
```
![image](https://user-images.githubusercontent.com/76146752/116641220-3e9c5f00-a9a7-11eb-8d59-303503a0d51e.png)

### 다중 입력 모델
  - 가정
      - IRIS 꽃 데이터 + 꽃의 사진을 입력해서 꽃의 종류를 예측한다
  - X : 꽃 데이터, 꽃 사진
  - y : 꽃 종류

``` python
    iris_info_tensor = layers.Input((4, )) # 꽃 데이터 input(꽃잎 너비(2) 꽃잎높이(2))
    x1 = layers.Dense(32, activation='relu')(iris_info_tensor)
    x1 = layers.Dense(16, activation='relu')(x1)
    
    iris_img_tensor = layers.Input((16,16,1)) # 이미지 데이터
    x2 = layers.Conv2D(filters=32, kernel_size = 3, padding='same', activation='relu')(iris_img_tensor)
    x2 = layers.Conv2D(filters=32, kernel_size = 3, padding='same', activation='relu')(x2)
    x2 = layers.MaxPool2D(padding='same')(x2)
    
    x3 = layers.Conv2D(filters=64, kernel_size=3, padding='same', activation='relu')(x2)
    x3 = layers.Conv2D(filters=64, kernel_size=3, padding='same', activation='relu')(x3)
    x3 = layers.MaxPool2D(padding='same')(x3)
    x3 = layers.GlobalAveragePooling2D()(x3)
    
    #합치기
    x4 = layers.concatenate([x1,x3])
    x5 = layers.Dropout(0.2)(x4)
    output_tensor = layers.Dense(units=3, activation='softmax')(x5)
    
    model = models.Model([iris_info_tensor, iris_img_tensor], output_tensor)
    
    model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
    keras.utils.plot_model(model, show_shapes=True)
```
![image](https://user-images.githubusercontent.com/76146752/116642561-2843d280-a9aa-11eb-9c85-4052d04fc66d.png)
    
    
    
    
  





