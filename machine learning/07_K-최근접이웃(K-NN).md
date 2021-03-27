## K-최근접 이웃 (K-Nearest Neighbors, K-NN)
  - 분류(Classification)와 회귀(Regression)를 모두 지원한다
  - 예측하려는 데이터와 input데이터들 간의 거리를 측정해 가장 가까운 K개의 데이터셋의 레이블을 참조해 분류/예측한다
  - 학습시 단순히 input 데이터들을 저장만 하며 예측시점에 거리를 계싼한다
      - 학습은 빠르지만 예측시 시간이 많이 걸린다
### 분류
![image](https://user-images.githubusercontent.com/76146752/112718256-244d0c80-8f35-11eb-8114-0eae4bcc16a9.png)

 - K-NN에서 K는 새로운 데이터포인트를 분류할 때 확인할 데이터 포인트의 개수를 지정하는 **하이퍼파라미터**
![image](https://user-images.githubusercontent.com/76146752/112718285-55c5d800-8f35-11eb-8f07-adc5ded4eb9b.png)
  - K를 1로 하면 <font color='blue'>파란색</font>, K를 3으로 하면 <font color='orange'>주황색</font>으로 분류한다
  - K가 너무 작으면 과적합(Overfitting)이 일어나고 K가 너무 크면 성능이 나빠진다 (Underfitting)

## 주요 하이퍼파라미터
  - 이웃 수
     - n_neighbors = K
     - **K가 작을수록 모델이 복잡해져 과적합이 일어나고 너무 크면 단순해져 성능이 나빠진다**
     - n_neighbors(=K)는 Feature수의 제곱근 정도를 지정할 때 성능이 좋은 것으로 알려져 있음
  - 거리 재는 방법
     - p=2:유클리디안 거리 (Euclidean distance -기본값)
     - p=1 : 맨하탄 거리(Manhattan distance)
  
 > ### 유클리디안 거리(Euclidean_distance, L2 norm)
  - 제곱근 이용
![image](https://user-images.githubusercontent.com/76146752/112718939-78f28680-8f39-11eb-8aa0-9c694af9d7ef.png)

 > ### 맨하탄 거리(Manhattan_distance, L1 norm)
  - 절대값 이용
![image](https://user-images.githubusercontent.com/76146752/112718924-64ae8980-8f39-11eb-9724-ae33e73ef8b1.png)

## 요약
  - K-NN은 이해하기 쉬운 모델이며 튜닝할 하이퍼파라미터의 수가 적어 빠르게 만들 수 있다
  - K-NN은 서비스할 모델을 구현할 때 사용하지는 않고 **복잡한 알고리즘을 적용하기 전에 확인, baseline잡기 위한 모델**로 사용된다
  - 훈련세트가 너무 큰 경우(Feature나 관측치의 개수가 많은 경우) 거리를 계산하는 양이 늘어나 예측이 느려진다
  - Feature간의 값의 단위가 다르면 작은 단위의 Feature에 영향을 많이 받게 되므로 **전처리로 Scaling작업**이 필요하다
  - Feature가 너무 많은 경우와 대부분의 값이 0으로 구성된 (희소-sparse) 데이터셋에서 성능이 아주 나쁘다(0,1 등으로 구성되어있어 거리구하기 어렵)


### 위스콘신 유방암 데이터를 이용한 암환자분류
 ### K값 변화에 따른 성능 평가
  - malignant: 악성
  - benign : 양성
  - 
    ``` python
        import numpy as np
        import pandas as pd
        import matplotlib.pyplot as plt
        
        from sklearn.datasets import load_breast_cancer
        from sklearn.model_selection imprt train_test_split
        
        X,y = load_breast_cancer(return_X_y = True)
        
        X_train,X_test, y_train,y_test = train_test_split(X,y, stratify=y, random_state=1)
        
        from sklearn.preprocessing import StandardScaler
        from sklearn.neighbors import KNeighborsClassifier
        from sklearn.metrics import accuracy_score, classification_report
        
        scaler = StandardScaler()
        X_train_scaled = scaler.fit_transform(X_train)
        X_test_scaled = scaler.transform(X_test)
        
        k_list = range(1,21)
        train_acc_list = []
        test_acc_list = []
        
        for k in k_list:
          knn = KNeighborsClassifier(n_neighbors = k)
          knn.fit(X_train_scaled, y_train)
          
          pred_train = knn.predict(X_train_scaled)
          pred_test = knn.predict(X_test_scaled)
          
          train_acc_list.append(accuracy_score(pred_train,X_train_scaled))
          test_acc_list.append(accuracy_score(pred_test,X_test_scaled))
          
          pd.DataFrame(dict(k=k_list,train = train_acc_list, test = test_acc_list))
          
          plt.figure(figsize=(7,7))
          plt.plot(k_list,train_acc_list, label='Train')
          plt.plot(k_list, test_acc_list, label='Test')
          plt.legend()
          plt.show()
      ```
          
          
          













