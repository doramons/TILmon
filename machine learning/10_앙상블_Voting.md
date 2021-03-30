## 앙상블의 종류
  1. 투표방식
    - 여러 개의 추정기가 낸 결과들을 투표를 통해 최종결과 반환
    1. Bagging - 같은 유형의 알고리즘 조합하여 각각 다른 학습데이터를 학습
    2. Voting - 서로 다른 알고리즘 결합하여 학습
  2. 부스팅(Boosting)
    - 약한 학습기(Weak Learner)들을 결합하여 보다 정확하고 강력한 학습기를 만든다

### Voting
  #### Voting의 유형
   1. Hard Voting
      - 다수의 추정기가 결정한 예측값들 중 많은 것을 선택하는 방식
   ![image](https://user-images.githubusercontent.com/76146752/112975335-78066280-918e-11eb-9d12-093020274792.png)

   2. Soft Voting
      - 다수의 추정기에서 각 레이블별 예측한 확률들의 평균을 내서 높은 레이블값을 결과값으로 선택
    ![image](https://user-images.githubusercontent.com/76146752/112975441-9a987b80-918e-11eb-9f4c-162eab78ab04.png)

 #### VotingClassifier 클래스 이용
  - 매개변수
      - estimators : 앙상블할 모델들 설정('추정기이름',추정기) 의 튜플을 리스트로 묶어서 전달
      - voting : voting 방식 (hard-기본값, soft 지정)
      - soft voting을 할 경우 확률을 사용하기 때문에 probability를 사용해야하는데 svm의 경우 probability의 기본값이 False이므로 True로 
      - 
        ``` python
            wine = pd.read_csv('data/wine.csv')
            X,y = wine.drop('color',axis=1),wine['color']
            
            X_train,X_test, y_train,y_test = train_test_split(X,y, stratify=y,random_state=1)
            
            knn = KNeighborsClassifier(n_neighbors=5)
            svc = SVC(C=1.0,gamma=0.1, probability= True)
            rf = RandomForestClassifier(n_estimators = 200)
            estimators = [('knn',knn),('Random Forest',rf),('svc',svc)]
            
            voting = VotingClassifier(estimators)
            
            voting.fit(X_train,y_train)
            
            pred_train = voting.predict(X_train)
            pred_test = voting.predict(X_test)
            
            accuracy_score(y_train,pred_train),accuracy_score(y_test,pred_test)
            
            # 파이프라인 이용하여 voting
            knn_pipeline = make_pipeline(StandardScaler(),knn)
            svc_pipeline = make_pipeline(StandardScaler(),svc)
            estimators = [('knn',knn_pipeline),('random forest',rf),('svc',svc)]
            
            voting = VotingClassifier(estimators)
            voting.fit(X_train,y_train)
            
            pred_train = voting.predict(X_train)
            pred_test = voting.predict(X_test)
            
            def print_metrics(y,y_pred,title=None):
              if title:
                print(title)
              metrics = f'정확도: {accuracy_score(y,y_pred)}, 재현율:{recall_score(y,y_pred)}, 정밀도: {precision_score(y,y_pred)},f1 점수:{f1_score(y,y_pred)}'
              print(metrics)
            
            print_metrics(y_train,pred_train)
            print_metrics(y_test,pred_test)
        ```
            
            
              












