## LSTM으로 삼성주가 예측해보자

  - Yahoo Finanace 에서 주가 데이터 다운로드 (https://finance.yahoo.com/)
  - 검색 후 Historical Data 선택
 ![image](https://user-images.githubusercontent.com/76146752/116654350-e889e480-a9c3-11eb-9a52-af24dd2ef2fe.png)

  - 기간 선택 후 Download Data 클릭
![image](https://user-images.githubusercontent.com/76146752/116654370-f93a5a80-a9c3-11eb-8340-202c955961ee.png)

### Data Loading 및 확인
 
``` python
    import pandas as pd
    import numpy as np[['
    import matplotlib.pyplot as plt
    
    df = pd.read_csv('005930.KS.csv')
    
    # 데이터 확인
    df.shape
    
    df.head(5)
    
    df.tail(5)
    
    # 결측치 확인
    df[df['Open'].isnull()]
```

### 전처리

  - date를 index
  - 결측치 제거
  - Adj Close 컬럼 제거
  - MinMaxScaling

``` python
    # date를 object로 변환
    
    df['Date'] = pd.to_datetime(df['Date'])
    
    # date를 index로 설정
    
    df.set_index('Date', inplace=True)
    
    df[['Open','Close']].plot(figsize=(20,6))
```
![image](https://user-images.githubusercontent.com/76146752/116654713-b462f380-a9c4-11eb-8aa3-2cdaca6eaf53.png)

``` python
    df[['Open','CLose']].iloc[:30].plot(figsize=(10,6))
```
![image](https://user-images.githubusercontent.com/76146752/116654732-bd53c500-a9c4-11eb-8be6-46560696b38a.png)

``` python
    # 결측치 처리
    df.dropna(inplace=True)
    
    # Adj close 컬럼 제거
    df.drop(columns=['Adj Close'], inplace=True)
    
```

### X, y 분리

``` python
    df_y = df['Close'].to_frame() #df['Close']: Series.to_frame(): Series => dataframe(2차원)
    
    df_X = df
    
```

### Scaling - MinMaxScaler
  
  - Scaler를 X,y 용 따로 만든다
      - y를 inverse 하기 위해

``` python
    from sklearn.preprocessing import MinMaxScaler
    X_scaler = MinMaxScaler()
    y_scaler = MinMaxScaler()
    
    X = X_scaler.fit_transform(df_X)
    y = y_scaler.fit_transform(df_y)
    
    X[:3]
    
    y_scaler.inverse_transform(y[:3]) # 원래 가격 형태로 표시됨
```

### 날짜 종가 예측

  - X: 50일치 주가, y: 51일째 주가
      - 50일의 연속된 주식가격으로 51일째 주가를 예측한다
![image](https://user-images.githubusercontent.com/76146752/116655562-47e8f400-a9c6-11eb-92d6-4b831e787329.png)

``` python
    window_size = 50
    data_X = [] #[[1-50],[2-51],[3-52],....]
    data_y = [] # [51,52,53,...]
    
    for i in range(0,len(y)-window_size):
        data_X.append(X[i:i+window_size])
        data_y.append(y[i+window_size])
        
```

### Train, Test 분리

``` python
    # train:test = 8:2
    train_index = int(len(data_y)*0.8)
    
    print(train_index)
    
    X_train, y_train = np.array(data_X[0:train_index]), np.array(data_y[0:train_index])
    X_test, y_test = np.array(data_X[train_index:]), np.array(data_y[train_index:])
    
```

### Model 생성
  
  - LSTM 레이어는 return_sequences 인자에 따라 마지막 시퀀스에서 한 번만 출력할 수 있고 각 시퀀스에서 출력할 수 있다
  - many to many 문제를 풀거나 LSTM 레이어를 여러개로 쌓아올릴 때는 return_sequence = True옵션을 사용
  - Dense에는 False로 해서 하나만 전달
  - 아래 그림에서 왼쪽은 return_sequences = False일 때, 오른쪽은 return_sequence = True일 때의 형상
![image](https://user-images.githubusercontent.com/76146752/116657456-600e4280-a9c9-11eb-8334-a8c282330e4a.png)

``` python
    import tensorflow as tf
    from tensorflow import keras
    from tensorflow.keras import layers
    
    # 하이퍼파라미터
    LEARNING_RATE = 0.001
    N_EPOCHS = 100
    N_BATCHS = 100
    N_TRAIN = X_train.shape[0]
    N_test = X_test.shape[0]
    
    # Dataset 구성
    train_dataset = tf.data.Dataset.from_tensor_slices((X_train, y_train)).shuffle(N_TRAIN).batch(N_BATCHS, drop_remainder=True).repeat()
    test_dataset = tf.data.Dataset.from_tensor_slices((X_test,y_test)).batch(N_BATCHS)
    
    # 모델 구성
    def create_model():
      model = keras.Sequential()
      model.add(layers.Input((window_size,5)))
      
      # LSTM
      model.add(layers.LSTM(32, activation='relu', return_seqeunces=False))
      model.add(layers.Dense(32, activation='relu'))
      model.add(layers.Dense(1)) #회귀
      
      return model
     
     model = create_model()
     
     model.compile(optimizer=keras.optimizers.Adam(learning_rate=LEARNING_RATE),loss='mse')
     
     model.summary()
     
     steps_per_epoch= N_TRAIN//N_BATCHS
     validation_steps = int(np.ceil(N_TEST/N_BATCHS))
     
     history = model.fit(train_dataset, epochs = N_EPOCHS, steps_per_epoch = steps_per_epoch, validation_data = test_dataset, validation_steps = validation_steps)
     
     y_scaler.inverse_transform(np.array(loss).reshape(-1,1))
     
     # 평가
     loss = model.evaluate(test_dataset)
     
     # 예측
     pred = model.predict(X_test)
     pred_price = y_scaler.invers_transform(pred)
     
     y_price = y_scaler.invers_transform(y_test)
     
     # 실제값, 예측값을 그래프로 비교
     
     plt.figure(figsize=(20,7))
     plt.plot(y_price, label='Ground Truth')
     plt.plot(pred_price, label='pred')
     plt.legend()
     plt.show()
     
  ```
![image](https://user-images.githubusercontent.com/76146752/116659516-aadd8980-a9cc-11eb-9a24-844ed875fac7.png)




