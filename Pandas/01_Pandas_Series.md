### 판다스 (Pandas)
  #### pandas 개요
    - 데이터 분석과 관련된 다양한 기능을 제공하는 파이썬 패키지
      - 데이터 셋을 이용한 다양한 통계처리 기능을 제공
      - 표 형태의 데이터를 다루는데 특화된 파이썬 모듈
        - 엑셀의 기능을 제공하는 파이썬 모듈이라고 생각하면 됨
      - 표 형태의 데이터를 다루기 위해 시리즈(Series)와 데이터프레임(DataFrame)클래스를 제공
         - Series : 1차원 자료구조를 표현
         - DataFrame : 행렬의 표를 표현
    - 설치
        - pip install pandas
        - conda install pandas
        - 아나콘다에는 미리 pandas가 install되어 제공된다
        
   #### Series
   ##### Series 개요
        - 1차원 자료 구조
        - DataFrame(표)의 한 행이나 한 열을 표현한다
        - 각 원소는 index로 접근할 수 있다
            - index는 순번과 지정한 이름 두가지로 구성된다
                - index명을 명시적으로 지정하지 않으면 순번이 index명이 된다
            - 순번은 0부터 1씩 증가하는 정수
        - 벡터화 연산을 지원
            - Series 객체에 연산을 하면 각각의 Series 원소들에 연산이 된다
        - Series를 구성하는 원소들을 다루는 다양한 메소드 제공
     
   #### Series 생성
      - 구문
        - Series(배열형태 자료구조)
            - 베열형태 자료구조
                - 리스트
                - 튜플
                - 넘파이 배열(ndarray)
       - Series.shape : 시리즈의 형태
       - Series.ndim: 차원(1)
       - Series.dtype: 데이터 타입
       - Series.size: 원소 총개수
       ex) import pandas as pd
        nums = [10,20,30,40,50,60,80]
        s1 = pd.Series(nums)
        s3 = pd.Series([70,100,90,80], index=['국어','영어','수학','과학'])
        
 #### Series안의 원소(element) 접근
      
  ##### Indexing
      - index 순번으로 조회
        - Series[순번]
        - Series.iloc[순번] - iloc indexer
      - index 이름으로 조회
        - Series[index명]
        - Series.loc[index명] - loc indexer
        - Series.index명
            - index명이 문자열일 경우 `.표기법` 사용가능
        - index명이 문자열이면 문자열("")로 정수이면 정수로 호출
          - s['name'], s[2], s.loc['name'], s.loc[2]
      - **팬시(fancy) 인덱싱**
        - Series[index리스트]
        - 여러 원소 조회 시 조회할 index를 list로 전달
            -` s[[1,2,3]]`
            
   ##### slicing
      - **Series[start index : end index : step]**
          - start index 생략 : 0번부터
          - end index
            - **index 순번일 경우는 포함하지않는다**
            - **index  명의 경우는 포함한다**

      - **Slicing의 결과는 원본의 참조(View)를 반환**
          - slicing한 결과를 변경시 원본도 같이 바뀐다
          - series.copy() : Series를 복사한 새로운 객체 반환

   ##### Indexing, Slicing을 이용한 값 변경
      - shallow copy와 deep copy
          - deep copy(깊은 복사)
            - 원본의 카피본을 반환하여 값 변경시 원본이 변경되지 않는다
            - 파이썬 리스트는 slicing시 deep copy
            - indexing은 deep copy

          - shallow copy(얕은 복사)
            - 원본을 반환하여 값 변경시 원본에 영향을 준다
            - Series, DataFrame, 넘파이 배열(ndarray)은 slcing 조회시 shallow copy

          - copy() 메소드
            - Series, DataFrame, ndarray를 복사하여 반환한다

   ##### Boolean 인덱싱
      - Series의 indexing 연산자에 boolean리스트를 넣으면 True 인 index의 값들만 조회한다
          - Boolean 연산자들을 이용해 원하는 조건의 값들을 조회할 수 있다
          - 다중조건인 경우 반드시 ()로 조건을 묶어야 한다
          - 파이썬과 다르게 and, or 예약어는 사용할 수 없다
          - &,|,~으로 사용

  ##### 주요메소드
    
