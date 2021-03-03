 #### filter()
  - DataFrameGroupBy.filter(func, dropna=True, \*args,\*\*kwargs)
  - 특정 집계 조건을 만족하는 Group의 행들만 조회한다
      1. DataFrameGroupBy의 group의 DataFrame을 함수에 전달한다
      2. 함수는 받은 DataFrame을 이용해 집계한 값을 조건식에 넣어 그 값을 반환한다(반환타입:Bool)
      3. 반환값이 True인 Group들의 모든 행들로 구성된 DataFrame을 반환한다
     ex) df.groupby('fruits').filter(check_cnt1_mean)
      or 간단한 표현식은 함수를 선언하지않고 람다표현식으로 가능
      -> df.groupby('fruits').filter(lambda x : x['cnt1'].mean()>=20)
  - 매개변수
      - func : filtering 조건을 구현한 함수
          - 첫번째 매개변수로 Group으로 묶인 DataFrame을 받는다
      - dropna = True
          - 필터를 통과하지 못한 group의 DataFrame의 값들을 drop시킨다. False로 설정하면 값들을 NA 처리해서 반환된다
      - \*args, \*\*kwargs: filter 함수의 매개변수에 전달할 전달인자값
      ex) 매개변수 있는 filter함수
          def check_mean(x, col, threshold):
          """
          [매개변수] 
              x => DataFrame
              col : str 평균을 구할 컬럼명
              threshold : int 비교대상값
          """
          return x[col].mean() >= threshold
          
          df.groupby(fruits).filter(check_mean, col = 'cnt1', threshold = 30)
          
 #### transform
   - 함수에 의해 처리된 값(반환값)으로 원래 값들을 변경(transform)해서 반환
   - DataFrame에 group 단위 통계량을 추가할 때 유용하다
    
     - DataFrameGroupBy.tranform(func, \*args),
       SeriesGroupBy.transform(func, \*args)
          - func : 매개변수로 그룹별로 Series를 받아 Series의 값들을 변환하여 (Series로)반환하는 함수객체
              - DataFrameGroupBy은 모든 컬럼의 값들을 group별 Series로 전달한다
          - \*args: 함수에 전달할 추가 인자 값이 있으면 매개변수 순서에 맞게 값을 전달한다(위치기반 argument)
     - transform() 함수를 groupby()와 사용하면 컬럼의 각 원소들을 자신이 속한 그룹의 통계량으로 변환된 데이터셋을 생성할 수 있다
     - 컬럼의 값과 통계값을 비교해서 보거나 결측치 처리 등에 사용할 수 있다
          
 ##### 결측치 처리
  ###### 결측치 대체
   - transform이용해서 여기선 결측치를 같은 과일그룹의 평균값으로 변환
      - 전체평균으로 대체하는 것보다 좀 더 정확성을 높일 수 있다
       ex) series.fillna(대체할값)
            대체값은 saclar로 배열 형태가 같아야한다
            
 ###### 결측치제거
   - 결측치가 있는 행을 제거 한다
     ex) df.dropna()
     
 #### pivot_table()
  - 엑셀의 pivot table 기능을 제공하는 메소드
  - 분류별 집계(Group으로 묶어 집계)를 처리하는 함수로 group으로 묶고자 하는 컬럼을 행과 열로 위치시키고 집계값을 값으로 보여준다
  - 역할은 groupby()를 이용한 집계와 같다
      > pivot() 함수와 역할이 다르다
      > pivot() 은 index와 column의 형태를 바꾸는 reshape함수
    - DataFrame.pivot_table(values=None,
                            index=None, 
                            columns=None, 
                            aggfunc='mean', 
                            fill_value=None,
                            margins = False,
                            dropna = True,
                            margins_name='All')
     - 매개변수
        - index
            - 문자열 또는 리스트, index로 올 컬럼들 => groupby였으면 묶었을 컬럼
        - columns
            - 문자열 또는 리스트. column으로 올 컬럼들 => groupby였으면 묵었을 컬럼 (index/columns가 묶여서 groupby에 묶을 컬럼들이 된다)
        - values
            - 문자열 또는 리스트. 집계할 대상 컬럼들
        - aggfunc
            - 집계함수 지정. 함수, 함수이름문자열, 함수리스트(함수이름 문자열/함수객체), dict: 집계할 함수
            - default값 : mean
         - fill_value, dropna
            - fill_value:집계시 NA가 나올경우 채울 값
            - dropna: boolean. 컬럼의 전체값이 NA인 경우, 그 컬럼 제거(기본: True)
          - margins/margins_name
            - margin: boolean(기본:False). 총집계결과를 만들지 여부
            - margin_name: margin의 이름 문자열로 지정(생략시 default값은 'All')
                            
  #### apply() - Series, DataFrame의 데이터 일괄처리
   - 데이터프레임의 행들과 열들 또는 Series의 원소들에 공통된 처리를 할 때 apply 함수를 이용하면 반복문을 사용하지 않고 일괄처리가 가능하다
      - DataFrame.apply(함수, axis=0, args=())
          - 인수로 행이나 열을 받는 함수를 apply 메서드의 인수로 넣으면 데이터 프레임의 행이나 열들을 하나씩 함수에 전달한다
          - 매개변수
              - 함수: DataFrame의 행들 또는 열들을 전달할 함수
              - axis: 0-행을 전달, 1-열을 전달 (기본값 = 0)
              - args: 행/열 이외에 전달할 매개변수를 위치기반(순서대로) 튜플로 전달

       - Series.apply(함수, args=())
            - 인수로 Series의 원소들을 받는 함수를 apply 메소드의 인수로 넣으면 Series의 원소들을 하나씩  
     
     
     
     
     
     
     
     
     
