### 인덱싱과 슬라이싱을 이용한 배열의 원소 조회

  ####배열 인덱싱(indexing)
    - index
      - 배열 내의 원소의 식별번호
      - 0부터 시작
    - indexing
      - index를 이용해 원소 조회
          - [] 표기법 사용
    
    - 구문
      - ndarray[index]
      - 양수는 지정한 index의 값을 조회한다
      - 음수는 뒤부터 조회한다(reverse)
        => 마지막 index가 -1 
      - 2차원 배열의 경우
        - arr[행index, 열index]
          cf) 파이썬 리스트 인덱스 : list[행][열]
      - N차원 배열의 경우
          - arr[0축 index, 1축 index, ..., n축 index]
          
          
      - 팬시(fancy) 인덱싱
        - **여러개의 원소를 한 번에 조회**할 경우 리스트에 담아 전달한다
        - 다차원 배열의 경우 각 축별로 list로 지정
        - arr[[1,2,3,4,5]]
            - 1차원 배열(vector) : 1,2,3,4,5번 index의 원소들을 한번에 조회
        - arr[[0,3],[1,4]] => arr[[0번축 인덱스들],[1번축인덱스들]]
            - [0,3] - 1번축 index list, [1,4] -2번축 index list
            - 2차원 배열 => [0,1],[3,4] 인덱스 원소들 조회
         - 인덱스값 변경 (대입) 가능
            ex) arr[1] = 100
                 arr[0],arr[2] = 100,200 (튜플대입도 가능)
                 arr[[5,7]] =500,700 (팬시 인덱싱 사용해서 대입가능)
                 
                 
     ####슬라이싱
        - 배열의 부분 집합을 하위배열로 조회 및 변경하는 방식
        - ndarry[start:stop:step]
            - start : 시작인덱스.  기본값 0
            - stop : 끝인덱스. stop값은 포함하지 않는다( 생략시 기본값 마지막 index로 설정)
            - step : 증감 간격. 기본값 1 => -1 하면 reverse
       
       #####-다차원 배열 슬라이싱
           - 각 축에 slicing 문법 적용
           - 2차원의 경우
              - arr[행 slicing, 열 slicing]
                - arr[:3, :] => 0번축의 0~2번 인덱스 와 1번축 모든 인덱스
            - 다차원의 경우
                - arr[0축 slicing, 1축 slicing, ..., n축 slicing]
            - slicing과 indexing 문법은 같이 쓸 수 있다
            - 모든 축에index를 지정할 필요는 없다
              -> 마지막 축은 생략 가능하지만 앞쪽 축은 생략할 수 없다
                ex) a[, 1:3] 으로 하면 오류남
                
            - np.flip(a,0) -> a배열의 0번 축을 reverse
              np.flip(a,1) -> 배열 a의 1 번축을 reverse
       ##### 슬라이싱은 원본에 대한 view
          -slicing한 결과는 새로운 배열을 생성하는 것이 아니라 기존의 배열을 참조한다
          - 따라서 slicing 한 배열의 원소를 변경하면 원본배열의 원소도 함께 바뀐다
          - 배열.copy()
                - 배열을 복사한 새로운 배열 생성
                - 복사 후 처리하면 원본이 바뀌지 않는다
                 ex) b = a[:,1:4]
                     b = b.copy() => 이후 슬라이싱 변경하여도 a(원본)는 변경되지 않음
                     
        ##### boolean indexing
            - Index 연산자에 Boolean 배열을 넣으면 True인 index의 값만 조회 (False가 있는 index는 조회하지 않는다)
            - ndarray 내의 원소 중에서 원하는 조건의 값들만 조회할 때 사용
            - 보통 특정조건을 충족하는 원소만 조회할 때 사용하곤 함
              ex) a = np.array([1,2,3])
                  a[a>2] => a의 원소들중 2보다 큰 원소들만 조회
                  
        ####넘파이에서 비교연산자
          - 넘파이에서는 파이썬 비교 연산자인 and,or, not을 사용하지 못한다
          - and : '&'
          - or : '|'
          - not : '~' 
          으로 대체하여 사용한다
          - 피연산자 들은 ()로 묶어서 연산해야함
            ex) arr = np.arange(50)
                arr[(arr>=10) & (arr=<20)] => arr 원소중 10이상 20이하 원소들 조회
        
        ** np.where()
          - np.where(boolean 배열) - True인 index를 반환
          - boolean연산과 같이 쓰면 특정 조건을 만족하는 원소의 index를 조회할 수 있음
            ex) a = np.array([True,False, True])
                r = np.where(a)
                 [0,2] => True값을 가지는 index
                 
                np.where(arr>=50) => 50이상의 값(True)을 가지는 원소의 인덱스 반환
                np.where(a, '참','거짓') => a배열에서 True값은 '참', False '거짓'으로 바꾸어 반환
                

          - np.where(boolean 배열, True를 대체할 값, False를 대체할 값)
              => True와 False를 다른 값으로 변경한다
              
          - 2차원 배열도 마찬가지로 적용할 수 있다
              - 단 where은 축별로 배열이 반환된다
               ex) [0,1],[2,3] 이 반환 되었을 경우 (0,1),(2,3)인덱스가 아니라 (0,2),(1,3) 인덱스가 Truedladmf dmlalgksek
               - 보통 Vector에 적용한다
               
