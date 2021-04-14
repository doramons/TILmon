## Feature vectorization 개요
  - 텍스트를 숫자형값의 정형데이터로 변환하는 것을 Feature vectorization(피처 벡터화) 라고 한다

### BOW (Bag of Words)
#### 많이 나온 단어가 중요한 단어
  - 문서 내에 단어 빈도수에 기반하여 Vector화 하는 모델
  - DTM/TDM (Document Term Matrix)
    - 문서 안에서 문서를 구성하는 단어들이 몇번 나왔는지를 표현하는 행렬
    - 행: 문서, 열: 단어 - DTM
    - 행: 단어, 열: 문서 - TDM
  - TF-IDF (Term Frequency Inverse Document Frequency)
    - CountVectorize의 문제: 문장 구조상 많이 나오는 단어들의 경우 카운트 값이 많이 나오게 되고 중요한 단어로 인식된다 (ex. 관사, 접속사, 주제어 등)
    - 이 문제를 보완한 모델이 TF-IDF 모델이다
    - 개별 문서에 많이 나오는 단어가 높은 값을 가지도록 하되 동시에 여러 문서에 자주 나오는 단어에는 패널티를 주는 방식

### DTM/TDM (Document Term Matrix)
  - 단어들이 각 문서에 몇번 나왔는지 행렬로 구성
  - 많이 나온 단어가 중요한 단어라는 것을 기반으로 한다
  - 문서 단어 행렬(Document Term Matrix)
      - 문서별로 각 단어가 나타난 **횟수를 정리한 표**
      - 컬럼(Feature) : 전체 문서에 나오는 모든 단어
      - 행 : 문서
      - 값(value) : 각 단어가 문서에 나온 횟수
  - 단어 문서 행렬(Term Document Matrix)
      - DTM을 전체 시킨 것
      - 컬럼(Feature): 문서
      - 행: 전체 문서에 나오는 모든 단어
      - 값(value) : 각 단어가 문서에 나온 횟수
   - scikit-learn의 CountVectorize 이용

### CountVectorizer
 #### 주요 생성자 매개변수
  - stop_word: stopword 지정
      - str : 'english' - 영문 불용어는 제공됨
      - list : stopword 리스트
  - max_df: 특정 횟수 이상나오는 것은 무시하도록 설정(무시할 횟수/비율 지정)
      - int(횟수), float(비율)
  - min_df: 특정 횟수 이하로 나오는 것은 무시하도록 설정(무시할 횟수/비율 지정)
  - max_features : 최대 token 수
      - 빈도수가 높은 순서대로 정렬 후 지정한 max_features 개수 만큼만 사용한다
  - ngram_range: n_gram 범위 지정
      - n_gramL
      - 튜플 (범위 최소값, 범위 최대값)
      - (1,2) :토큰화된 단어를 1개씩 그리고 순서대로 2개씩 묶어서 Feature를 추출

  #### 메소드
   - fit(X)
      - 학습
      - 매개변수: raw document - 문장을 원소로 가지는 1차원 배열 형태(list, ndarray)
      - **Train(훈련) 데이터셋으로 학습한다. Test 데이터셋은 Train셋으로 학습한 CountVectorizer를 이용해 변환만 한다**
   - transform(X)
      - DTM 변환
   - fit_transform(X)
      - 학습/ 변환 한번에 처리


  #### n-gram
    DTM은 문맥상에서 단어의 의미는 무시된다 이것을 보완하는 것이 ngram 기법이다
    n개의 단어를 묶어서 feature로 구성한다
    
 #### train셋을 이용해 학습 및 변환
  - 
    ``` python
        from sklearn.feature_extraction.text import CountVectorizer
        cv = CountVectorizer()
        cv.fit(data) # 학습: train과 test를 합쳐서 (나누기 전에) 한다
        train_cv = cv.transform(train)
        
        train_cv.toarray()
    ```
    
 #### test 셋 변환
  - 
    ``` python
        test_cv = cv.transform(test).toarray()
        
        import pandas as pd
        pd.DataFrame(test_cv, columns = cv.get_feature_names())
    ```
    
 #### TF-IDF (Term Frequency - Inverse Document Frequency)
  - 개별 문서에 많이 나오는 단어가 높은 값을 가지도록 하되 동시에 여러문서에 자주 나오는 단어에는 페널티를 주는 방식
  - 어떤 문서에 특정 단어가 많이 나오면 그 단어는 해당 문서를 설명하는 중요한 단어일 수 있다. 그러나 그 단어가 다른 문서에도 많이 나온다면 언어 특성이나 주제상 많이 사용되는 단어 릴 수 있다
      - 전체 문서에 고르게 많이 나오는 단어들은 각각의 문서가 다른 문서와 다른 특징을 찾는데 도움이 안된다. 그래서 페널티를 주어 작은 값이 되도록 한다
  - 각 문서의 길이가 길고 문서개수가 많은 경우 Count 방식보다 TF-IDF 방식이 더 좋은 예측을 내는 경우가 많다

#### 공식
  - TF (Term Frequency) : 해당 단어가 해당 문서에 몇번 나오는지를 나타내는 지표
  - DF(Document Frequency) : 해당 단어가 몇개의 문서에 나오는지를 나타내는 지표
  - IDF(Inverse Document Frequency) :DF의 역수 ( 전체문서수/해당단어가 나오는 문서수)
  - TF-IDF : TF * (log(전체문서수/해당단어가 나오는 문서수))

#### 주요 생성자 매개변수
  - stop_word : stopword 지정
  - max_df : 특정 횟수 이상 나오는 것은 무시하도록 설정(무시할 횟수/ 비율지정)
      - int(횟수), float(비율)
  - min_df : 특정 회수 이하로 나오는 것은 무시하도록 설정(무시할 횟수/비율 지정)
  - max_features : 최대 token 수
  - ngram_range : n_gram 범위 지정
      - n_gram:
      - 튜플(범위 최소값, 범위 최대값)
      - (1,2) : 토큰화된 단어를 1개씩 그리고 순서대로 2개씩 묶어서 Feature 추출

#### 메소드
  - fit(X)
    - 학습
    - 매개변수 : 문장을 1차원 배열형태(list, ndarray)
  - transform(X)
  - fit_transform(X)










