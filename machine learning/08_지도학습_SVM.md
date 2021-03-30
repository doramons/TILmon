### Support Vector Machine (SVM)
#### 선형(Linear) SVM
  - 딥러닝 이전에 분류에서 뛰어난 성능으로 가장 활용도가 높았던 분류모델
  - 하나의 분류 그룹을 다른 그룹과 분리하는 최적의 경계를 찾아내는 알고리즘
  - 중간크기의 데이터셋과 특성(Feature)이 많은 복잡한 데이터셋에서 성능이 좋은 것으로 알려져있다

 ##### 선(1)과 (2) 중 어떤 선이 최적의 분류 선일까?
 ![image](https://user-images.githubusercontent.com/76146752/112805823-10c6b080-90b1-11eb-8230-ec38ea543cdb.png)

![image](https://user-images.githubusercontent.com/76146752/112805833-158b6480-90b1-11eb-868d-3671131eb82e.png)

### 목표: support vector 간의 가장 넓은 margin을 가지는 초평면(결정경계)를 찾는다
  > 초평면
  >   - 데이터가 존재하는 공간보다 1차원 낮은 부분공간
  >       - n차원의 초평면은 n-1차원
  >       - 공간을 나누기 위해 초평면을 사용한다
  >       - 1차원 - 점, 2차원 - 선, 3차원- 평면, 4차원이상-초평면
  - Support Vector: 경계를 찾아내는데 기준이 되는 데이터포인트, 초평면(결정경계)에 가장 가까이 있는 vector(데이터포인트)를 말한다
  - margin : 두 support vector 간의 너비
  - margin이 넓은 결정경계를 만드는 함수를 찾는 것
  ![image](https://user-images.githubusercontent.com/76146752/112806484-c5f96880-90b1-11eb-801d-c89576ef924e.png)

### Hard Margin, Soft Margin
  - Overfitting(과적합)을 방지하기 위해 어느정도 오차를 허용하는 방식을 Soft margin이라고 한다 반대로 오차를 허용하지 않는 방식을 Hard Margin이라고 한다
  - 모든 데이터셋이 위 그림처럼 완전히 분류되는 것은 아님
  - 노이즈가 있는 데이터나 선형적으로 분리되지 않는 경우 **하이퍼파라미터인 C**를 조정해 마진을 변경한다
  - C
    - 기본값 1
    - 파라미터값을 크게주면 마진폭이 좁아져 마진오류가 작아지나 Overfitting이 일어날 가능성이 크다
    - 파라미터값을 작게 주면 마진폭이 넓어져 마진 오류가 크다
    - 훈련데이터 성능은 안좋지만 일반화가 되어서 테스트 데이터의 성능이 올라가지만 underfitting이 날 가능성이 있다
    - undefitting 발생시 : C값을 더 크게
    - overfitting 발생시 : C값을 더 작게
  - 
   ``` python
       from sklearn.datasets import load_breast_cancer
       from sklearn.model_selection import train_test_split
       from sklearn.preprocessing import StandardScaler
       
       from sklearn.svm import SVC
       from sklearn.metrics import accuracy_score
       
       X,y = load_breast_cancer(return_X_y)
       X_train,X_test,y_train,y_test = train_test_split(X,y, stratify = y, random_state=1)
       
       # SVM 은 선형모델이기 때문에 scaling작업이 필요
       scaler = StandardScaler()
       X_train_scaled = scaler.fit_transform(X_train)
       X_test_scaled = scaler.transform(X_test)
       
       # 학습
       svc = SVC(kernel='linear',random_state=1,C=0.01)
       svc.fit(X_train_scaled,y_train)
       
       pred_train = svc.predict(X_train_scaled)
       pred_test = svc.predict(X_test_scaled)
       
       accuracy_score(y_train,pred_train),accuracy_score(y_test,pred_test)
   ```
   
 ### 커널 서포트 벡터 머신
  #### 비선형데이터셋에 SVM적용
   - 선형으로 분리가 안되는 경우는?
   ![image](https://user-images.githubusercontent.com/76146752/112870884-a4bc6a80-90f9-11eb-97b0-07eb7e76ccf0.png)
   - 다항식 특성을 추가하여 차원을 늘려 선형 분리가 되도록 변환
   
  #### 차원을 늘리는 경우의 문제
   - 다항식 특성을 추가하는 방법은 낮은 차수의 다항식은 데이터의 패턴을 잘 표현하지 못해 과소적합이 너무 높은 차수의 다항식은 **과대적합과 모델을 느리게 하는 문제**가  있음
  
  #### 커널트릭(Kernel trick)
   - 다항식을 만들기 위한 특성을 추가하지 않으면서 수학적 기교를 적용해 다항식 특성을 추가한 것과 같은 결과를 얻을 수 있다
   - 이런 방식을 커널 트릭이라고 함

  ##### 방사기저(radial base function-RBF) 함수
   - 커널 서포트 벡터 머신의 기본 커널 함수
   - 기준점들이 되는 위치를 지정하고 각 샘플이 그 기준점들과 얼마나 떨어졌는지 계산함 => 유사도(거리)
   - 기준점별 유사도 계산 값은 원래 값보다 차원이 커지고 선형적으로 구분될 가능성이 커진다
  ![image](https://user-images.githubusercontent.com/76146752/112874466-f5ce5d80-90fd-11eb-8d4e-774bf7a730f7.png)

  - rbf(radial basis function) 하이퍼파라미터
    - C
      - 오차 허용기준. 작은값일 수록 많이 허용하고 큰값일 수록 과적합이 날 가능성이 높아짐
      - 과적합일 경우 C를 감소시키고 과소적합일 경우 C를 증가

    - gamma
      - 방사기저함수의 감마로 규제의 역할을 한다
          - 큰 값일수록 과대적합(overfitting)이 날 가능성이 높아진다훈련세
      - 모델이 과대적합일 경우 값을 감소시키고, 과소적합일 경우 값을 증가시킨다

 ### Guide
  - 커널기법은 다항식 차수를 만드는 것이 아니라 각 샘플을 함수에 넣어 나오는 값으로 같은 효과를 가지게 한다
  - C는 과적합이면 훈련셋에 타이트하게 맞추어진 수이므로 오차허용을 늘려서 공간(마진)을 확보해야하므로 줄인다
  - 과소적합일 경우 오차허용을 너무 크게 잡은 것이므로 오차허용을 줄여야 하므로 값을 늘린다
  - gamma 방사 기저함수 공식상 감마가 크면 반환값은 작아지고 감마가 작으면 반환값은 커진다 (-감마를 곱하기 때문)
    - 감마가 작을수록 값들의 거리가 멀어지고(큰 값이 나오기 때문)
  - svm -비선형 분리와 rbf 테스트.ipynb 문서확인

  - 
    ``` python
        rbf_svc = SVC(kernel='rbf',
                      C = 1,
                      gamma = 0.01,
                      probability = True, # 성능 테스트를 roc_auc_score이나 average_precision_score로 할 경우 pos_proba를 구해야하기 때문에 probability를 True로 설정한다(기본값:False)
                      random_state = 1)
         
        rbf_svc.fit(X_train_scaled,y_train)
        
        pred_train = rbf_svc.predict(X_train_scaled)
        pred_test = rbf_svc.predict(X_test_scaled)
        
        accuracy_score(y_train, pred_train), accuracy_score(y_test,pred_test)
        
        from sklearn.metrics import roc_auc_score, average_precision_score
        pos_proba = rbf_svc.predict_proba(X_train_scaled)[:,1]
        roc_auc_score(y_train,pos_proba), average_precision_score(y_train,pos_proba)
    ```
        
 ### GridSearch로 최적의 조합찾기
  
  - 
    ``` python
        param = {
            'kernel':['rbf','linear'],
            'C' : [0.001,0.01,0.1,1,10,100]
            'gamma':[0.001,0.01,0.1,1,10]
        }
        svc = SVC(random_state= 1, probability=True)
        gs_svc = GridSearchCV(svc,
                              scoring = ['accuracy','roc_auc'],
                              param_grid = param,
                              refit = 'accuracy',
                              cv = 3,
                              n_jobs = -1)
        gs_svc.fit(X_train_scaled,y_train)
        
        gs_svc.best_params_
        
        pd.DataFrame(gs_svc.cv_results)
        
        pred_train = gs_svc.predict(X_train_scaled)
        pred_test = gs_svc.pedict(X_test_scaled)
         
        accuracy_score(y_train,X_train_scaled),  accuracy_score(y_train,pred_train)
        
    ```
    
  #### 교차검증
    # cross_val_score()
  - 
    ``` python
        from sklearn.model_selection import cross_val_score
        
        svc2 = SVC(C=10,gamma=0.01)
        result = cross_val_score(svc2,
                                 X_train_scaled,
                                 y_train,
                                 scoring = 'accuracy',
                                 cv=3)
    ```
    
        
        
        
        
        
        
