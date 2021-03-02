  #### 정렬
   ##### index명/컬럼명을 순 정렬
   
   - sort_index(axis, ascending=True)
      - axis
          - index명 기준 정렬(행) : 'index'또는 0 (기본값)
          - columns 명 기준정렬(열) : 'columns' 또는 1
      - ascending
          - 정렬방식
          - True(기본): 오름차순, False: 내림차순
          - 문자열: 특수문자<숫자<대문자<소문자<외국어
      - inplace
          - 원본에 적용 여부
          - False(기본): 변경한 복사본 반환
          - True : 원본을 변경
      ** index가 sorting된 경우 부분값을 가지고 slicing 가능하다 (stop값은 포함x)
         ex) movie_df2 = movie_df.sort_index()
             movie_df2['A':'B'] -> A로 시작하는 영화제목 조회
             
   ##### 컬럼 값 기준 정렬
    
   - sort_values(by, ascending, inplace)
      - by
        - 정렬기준 컬럼명
        - 여러 컬럼에 대해 정렬할 경우 리스트에 담아 전달
      - ascending
        - 정렬방식
        - True(기본): 오름차순, False: 내림차순
        - 여러 컬럼에 대해 정렬할 경우 정렬방식도 리스트에 담아 전달
      - inplace
        - 원본에 적용 여부
        - False(기본): 변경한 복사본 반환
        - True : 원본을 변경

    ** 결측치는 정렬방식(오름차순,내림차순)과 관계없이 마지막에 나옴
    ** 정렬 기준컬럼을 2개로 설정할 경우 첫번째 정렬기준의 값이 같은 값끼리 2차정렬 기준에 의해 정렬됨
       ex) movie_df.sort_values(['duration','imdb_score'])
          => duration 기준으로 정렬이 되고 duration이 값이 같은 것 끼리는 imdb_score로 2차정렬
          
  ##### 기술통계함수를 이용한 데이터 집계
   ###### 주요 기술통계 함수
|함수|설명|
|-|-|
|sum()|합계|
|mean()|평균|
|median()|중위수|
|quantile()|분위수|
|std()|표준편차|
|var()|분산|
|count()|결측치를 제외한 원소 개수|
|min()|최소값|
|max()|최대값|
|idxmax()|최대값 index|
|idxmin()|최소값 index|
|unique()|고유값|
|nunique()|고유값의 개수|

    - DataFrame에 적용할 경우 컬럼별로 계산
    - sum(), max(), min(), idxmax(),idxmin(), unique(),nunique(), count()는 문자열에 적용가능 (평균,중위값등은 구할 수 없음)
        - 문자열 컬럼의 min/max index를 조회하려면, np.argmax(),np.argmin()을 사용
        - 문자열컬럼에 sum()연산을 하면 컬럼에 있는 모든 값 모두 붙여서 나옴
    - 기본적으로 결측치(NA)는 제외하고 처리한다
        - 결측치를 제외하지 않으려면 skipna=False로 설정

  ##### aggregate(func, axis=0, \*args, \\**kwargs) 또는 agg(func, axis=0, args, kwargs)
      
      - 판다스가 제공하는 집계함수들이나 사용자 정의 집계함수를 DataFrame의 열 별로 처리해주는 함수
      - 사용자 정의 집계함수를 사용하거나 열 별로 다른 집계를 할 때 사용한다
      - 매개변수
          - func
              - 집계 함수 지정
                  - 문자열/문자열리스트 : 집계함수의 이름. 여러 개일 경우 리스트. 판다스 제공 집계함수는 문자열로 함수명만 제공가능
                  - 딕셔너리 : {집계할컬럼: 집계함수}
                  - 함수 객체 : 사용자 정의함수의 경우 함수이름을 전달

           - axis
               - 0 또는 'index' (기본값): 컬럼 별 집계
               - 1 또는 'columns' : 행 별 집계
            - args, kwargs
                - 함수에 전달할 매개변수
                - 집계함수는 첫번째 매개변수로 Series를 받는다 그 이외의 매개변수가 있는 경우

          ex) flights.aggregate('mean') => 집계함수를 문자열로 지정
              flights.agg(['mean','sum']) => 평균과 합계
              flights.agg({'AIRLINE':'mode', 'DEP_DELAY':'mean'}) => AIRLINE의 최빈값과 DEP_DELAY의 평균값
              flights['ARR_DELAY'].agg('quantile',q=[0.25,0.75]) => 키워드인자 (q)를 쓰면 축을 생략할 수 있음
              
   ##### Groupby
      
        - 특정 열을 기준으로 데이터셋을 묶는다
        -  ~~ 별 집계를 할 때 사용한다
        -  구문
            - DF.groupby('그룹으로 묶을 기준컬럼')['집계할 컬럼'].집계함수()
                - 집계할 컬럼은 Fancy Indexing으로 지정 (리스트, 튜플로 전달)
            - 집계함수
                - 기술통계 함수들
                - agg()/aggregate()
                    - 여러 다른 집계함수 호출시(여러 집계를 같이 볼 경우)
                    - 사용자정의 집계함수 호출시
                    - 컬럼별로 다른 집계함수들을 호출할 경우

     - 가장 많이 쓰이는 것은 마지막 집계함수를 직접 호출하는 것
     - 한 번에 여러개의 집계함수를 호출할 경우는 agg([리스트])를 사용한다
     - 열별로 다른 집계를 하는 경우 dict를 사용한다


   ##### 복수열 기준 그룹핑
        
        - 두 개 이상의 열을 그룹으로 묶을 수 있다
        - groupby의 매개변수에 그룹으로 묶을 컬럼들의 이름을 리스트로 전달한다

          ex) flights.groupby(['AIRLINE','MONTH'])['DEP_DELAY'].mean() => AIRLINE,MONTH를 기준으로 그룹으로 묶은 값들의 DEP_DELAY의 평균 값을 구함
              flights.groupby(['AIRLINE','MONTH'])[['DEP_DELAY','ARR_DELAY']].agg(['mean','sum']) => multi index 컬럼
              
              
   ##### Groupby 집계후 집계한 것 중 특정 조건의 항목만 보기
        
        - SQL having절
        - 집계 후 boolean indexing으로 having절 처리
        ex) 항공사별 취소한 횟수가 50건 이상인 것만 조회
            result = flights.groupby('AIRLINE')['CANCELLED'].sum()
            result[result >= 50]
            
   ##### 사용자 정의 집계함수를 만들어 적용
   
   ###### 사용자 정의 집계 함수 정의
   
        - 매개변수
          1. Series 또는 DataFrame을 매개변수(필수)
          2. 필요한 값을 받을 매개변수를 선언한다. (선택)
    
   ###### agg() 를 사용해 사용자 정의 집계 함수 호출
   
       - DataFrame.agg(func=None, axis = 0, *args, **kwargs)
            - axis : 사용자 정의 함수에 전달할 값들(Series)의 축 지정
       - Series.agg(func=None, axis=0, *args, **kwargs)
            - DataFrame의 agg와 매개변수 구조를 맞추기 위해 axis 지정한다
       - SeriesGroupBy.agg(func=None, *args, **kwargs)
            - axis 지정안함
            - 사용자 함수에 Series를 group별로 전달한다
        - DataFrameGroupBy.agg(func, *args, **kwargs)
            - axis지정안함
            - 사용자 함수에 Series를 group 별로 전달한다
         - *args, **kwargs는 사용자 정의 함수에 선언한 매개변수가 있을 경우 전달할 값을 전달한다
            ex) quantile 함수 의 분위값 q
            





  
  
  
  
  
  
  
