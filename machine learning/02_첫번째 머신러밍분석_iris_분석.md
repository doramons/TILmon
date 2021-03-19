### Iris(붓꽃) 예측 모델
 - 머신러닝계의 Helloworld 같은 존재
 - 아이리스 품종 중 Setosa, Versicolor, Virginica 분류에 대한 논문에 사용된 데이터셋
 - 꽃받침(Sepal)과 꽃잎(Petal)의 길이 너비로 세개 품종을 분류
 ![image](https://user-images.githubusercontent.com/76146752/111591858-552d9300-880b-11eb-9f69-dbbe60794009.png)

#### 데이터셋 학인하기
 ##### 용어
  - 레이블(Label), 타겟(Target)
     - 결정값, 출력데이터, 종속변수
     - 예측 대상이 되는 값 지도학습시 학습을 위해
  - 피쳐(Feature)
     - 속성, 입력데이터, 독립변수
     - Target이 왜 그런 값을 가지게 되었는지를 설명하는 변수
     - Target값을 예측하기 위해 학습해야 하는 값들

  ##### scikit_learn 내장 데이터셋 가져오기
   - scikit-learn은 머신러닝 모델을 테스트하기 위한 데이터셋을 제공한다
      - 이런 데이터 셋을 Toy dataset이라고 한다
   - 패키지 : sklearn. datasets
   - 함수: load_xxxx()
   -
      ``` python
          from sklearn.datasets import load_iris
          iris = load_iris()
      ```
      
  ##### scikit-learn 내장 데이터셋의 구성
   - scikit-learn의 dataset은 딕셔너리 형태의 Bunck 클래스 객체이다
    - keys() 함수로 key값들을 조회
   - 구성
    - target_name: 예측하려는 값(class)을 가진 문자열 배열
    - target: Label(출력데이터)
    - data: Feature(입력변수)
    - feature_names: 입력변수 각 항목의 이름
    - DESCR: 데이터셋에 대한 설명

 ##### 위 데이터셋을 판다스 데이터 프레임으로 구성
  - 데이터 프레임 생성 후 데이터 확인
  - 
    ``` python
        import numpy as np
        import pandas as pd
        iris_df = pd.DataFrame(iris['data'],columns=iris['feature_names'])
        iris_df['species'] = iris['target']
    ```
    
 #### 머신러닝을 이용한 예측
  ##### 문제정의
   - 지나가다 발견한 Iris 꽃받침(Sepal)의 길이(length)와 폭(width)이 각각 5cm,3.5cm이고 꽃의 꽃잎(Petal)의 길이와 폭은 각각 1.4cm, 0.25cm다 이 꽃은 Iris의 무슨 종일까?
  ![image](https://user-images.githubusercontent.com/76146752/111596779-df2c2a80-8810-11eb-9a38-7eefbe42243b.png)

  ##### 데이터셋에서 찾아보기
   - 
      ``` pyhton
          iris_df[(iris_df['sepal length (cm)'] == 5)&
                  (iris_df['sepal width (cm)'] == 3.5)&
                  (iris_df['petal length (cm)'] == 1.4)&
                  (iris_df['petal width (cm)'] == 0.25)]
          # 딱 맞는 데이터셋 x
      ```

  
 ##### 결정 트리(Decision Tree) 알고리즘을 이용한 분류
  ###### 개요
   - 독립변수의 조건에 따라 종속 변수를 분리
   - 머신러닝의 몇 안되는 White box 모델
      - 결과에 대한 해석이 가능하다
   - 과적합(overfitting)이 잘 일어나는 단점이 있다
   - 랜덤 포레스트(Random Forest), Gradient Boosting, Adaptive Boosting과 같은Boosting 계열 앙ㅇ상블이 결정트리를 기반으로 하고 있다
  ![image](https://user-images.githubusercontent.com/76146752/111597700-cbcd8f00-8811-11eb-840a-286ee25304f3.png)
  
  ###### 결정트리 모델을 이용해 머신러닝 구현
   1. import 모델
    -
        ``` python
            from sklearn.tree import DecitionTreeClassfier
        ```
   2. 모델 생성
     -
        ``` pyhton
            tree = DecisionTreeClassifier()
        ```
   3. 모델 학습시키기
     -
        ``` python
            tree.fit(iris['data'],iris['target']) # input_data(Feature), output_data(Target)
        ```
   4. 예측
     - 
        ``` python
            pred = tree.predict([[5,3,1.4,0.25]])
            print(pred)
        ```
      
 ##### 머신러닝 프로세스
  ![image](https://user-images.githubusercontent.com/76146752/111715131-87d09d80-8896-11eb-94d3-1cf88ff05a5f.png)

 ##### 훈련데이터셋과 평가(테스트)데이터 분할
  - 위의 예는 우리가 만든 모델이 성능이 좋은 모델인지 나쁜 모델인지 알 수 없다
  - 전체 데이터 셋을 두개의 데이터 셋으로 나눠 하나는 모델을 훈련할 때 사용하고 다른 하나는 그 모델을 평가할 때 사용한다
  - 보통 훈련데이터와 테스트데이터의 비율은 8:2 또는 7:3정도로 나누는데 데이터셋이 충분하다면 6:4까지도 나눈다

  ##### 데이터셋 분할 시 주의
   - 각 클래스(분류대상)가 같은 비율로 나뉘어야 한다
   - stratify = y

  ##### scikit-learn의 train_test_split() 함수 이용 iris 데이터셋 분할
    -
     ``` python
         from sklearn.model_selection import train_test_split
         X_train, X_test, y_train,y_test = train_test_split(iris['data'], iris['target'],
                                                            test_size = 0.2,
                                                            stratify = iris['target'])
     ```
    
  ##### 모델생성
    - 
      ``` python
          tree = DecisionTreeClassifier()
      ```
      
  ##### 모델학습
    -
      ``` python
          tree.fit(X_train,y_train)
          pred_train = tree.predict(X_train)
          from sklearn.metrics import accuracy_score #정확도 검증하는 함수
          acc_train_score = accuracy_score(y_train, pred_train) #(정답, 예측결과)
          print("Train set 정확도:",acc_train_score)
      ```
    
    
    
    
    
    
    
