#### 데이터프레임 합치기
  - 두 개 이상의 DataFrame을 합쳐 하나의 DataFrame으로 만든다
![다운로드 (8)](https://user-images.githubusercontent.com/76146752/109938905-df59ff80-7d13-11eb-9a74-2e572300b6ca.png)

#### 데이터셋 읽기
   - stocks_2016.csv, stocks_2017.csv, stocks_2018.csv : 년도별 보유 주식
   - stocks_info.csv : 주식 정보

#### concat() 이용
   - 수직, 조인을 이용한 수평 결합 모두 지원한다
   - 조인(수평결함)의 경우 full outer join과 inner join을 지원한다
      - full outer join이 기본방식
      - 조인 기준: index가 같은 행끼리 합친다(equi-join)
   - pd.concat(objs, [, key=리스트]), axis=0, join='outer')
      - 매개변수
          - objs: 합칠 DataFrame들을 리스트로 전달
          - keys=[]를 이용해 합친 행들을 구분하기 위한 다중 인덱스 처리
          - axis
              - 0 또는 index : 수직결합
              - 1 또는 columns : 수평결합
          - join:
              - 조인방식
              - 'outer'(기본값) 또는 'inner'

   > ### 조인(join)
   > - 여러 데이터 프레임에 흩어져 있는 정보 중 필요한 정보만 모아서 결합하기 위한 것
   > - 두개 이상의 데이터 프레임을 특정 컬럼(열)의 값이 같은 행끼리 수평 결합하는 것
   > - Inner Join, Left Outer Join, Right Outer Join, Full Outer Join
     
   ex) - 수직결합
      pd.concat([s_2016,s_2017,s_2018], keys = [2016,2017,2018]) => s_2016,s_2017,s_2018 이 수직으로 결합
       => key를 지정하면 각각의 데이터프레임을 구별할 수 있도록 multi index가 생김 => multi index 조회 => df.loc[index1,index2]
        - 수평결합 : axis = 1
        pd.concat([s_2016,s_2017], axis =1)
         - 같은 index끼리 묶기
          pd.concat([s_2017.set_index('Symbol'),s_info.set_index('Symbol')], axis = 1, join='inner')
          
#### 조인을 통한 DataFrame 합치기
   - join()
      - 2개 이상의 DataFrame을 조인할 때 사용
   - merge()
      - 2개의 DataFrame의 조인만 지원

  ##### join()
   - dataframe객체.join(others, how='left', lsuffix='',rsuffix='')
   - df_A.join(df_b), df_A.join([df_b, df_c, df_d])
   - 두개 이상의 DataFrame들을 조인할 수 있다
      - 조인기준: index가 같은 값인 행끼리 합친다 (equi-join)
      - 조인 기본방식: Left Outer Join

   - 매개변수
      - lsuffix, rsuffix
          - 조인 대상 DataFrame에 같은 이름의 컬럼이 있으면 에러 발생
          - 같은 이름이 있는 경우 붙일 접미어 지정
          ex) s_2016.join(s_2017, lsuffix='\_2016', rsuffix='\_2017') => 왼쪽에 있는 s_2016 데이터프레임의 컬럼에는 '\_2016'이 붙고, 오른쪽에 있는 s_2017의 컬럼에는 '\_2017'이 붙음
          or 컬럼명에 suffix를 붙이고 조인할 수도 있음 => s_2017.add_suffix('\_2017')
      - how : 조인방식 'left','right','outer','inner'
          -> default 값 : 'left'
          
  ##### merge()
   - df_a.merge(df_b)
   - 두개의 DataFrame 조인만 지원
        - 조인 기준: 같은 컬럼명을 기준으로 equi-join이 기본, 조인기준을 다양하게 정할 수 있다
        - 조인 기본 방식: inner join
   - dataframe.merge(합칠dataframe, how='inner', on=None, left_on=None, right_on= None, left_ index=False, right_index=False
   - 매개변수
        - on 같은 컬럼명이 여러개일 때 join대상 컬럼을 선택
        - right_on, left_on : 조인할 때 사용할 왼쪽, 오른쪽 Dataframe의 컬럼명
        - left_index, right_index: 조인할 때 index를 사용할 경우 True로 지정
        - how : 조인 방식. 'left','right','outer','inner' => default값 :inner
        - suffixes: 두 DataFrame에 같은 이름의 컬럼명이 있을 경우 구분을 위해 붙인 접미어를 리스트로 설정
            - 생략시에는 각각 x,y를 붙인다

 - 수직으로 합치는 경우(union) : concat() 사용
 - 두 개이상의 DataFrame을 조인할 때 : join()사용
 - 두 개의 DataFrame을 조인할 때는 merge()를 사용한다ㅓ => 컨트롤이 편함
     
