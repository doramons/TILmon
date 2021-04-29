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
    









