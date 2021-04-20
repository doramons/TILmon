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
      
      #

      
      
      
      
      
      
      
      
      
      
      
      
      
      
        
