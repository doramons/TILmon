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
            - Series 객체에 연산을 하면 
