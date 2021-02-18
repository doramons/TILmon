## 넘파이 (Numpy)
  - data(이미지 등)를 넘파이를 통해 배열로 만듬
  - 고성능 과학연산을 위한 패키지로 데이터분석, 머신러닝 등에 필수로 사용된다.
  - 강력한 다차원 **배열(array)** 지원
    ** 배열을 이해하는 것이 가장 중요**
  - 벡터 연산 지원
  - 다양한 수학관련 함수
  - 선형대수, 난수 생성, 푸리에 변환 기능 지원
  
## 넘파이에서 데이터 구조
  - 스칼라 (Scalar)
    - 하나의 숫자로 이루어진 데이터
  - 벡터 (Vector)
    - 여러개의 숫자들을 '특정한 순서'(방향의 개념 포함)대로 모아놓은 데이터 모음(데이터 레코드)
    - 1D Array(1차원 배열)
      ex) 창고A [ 10(귤), 26(사과), 5(배) ] => 귤, 사과, 배 '특정 순서에 따라 여러개의 숫자(스칼라)들을 모아놓은 벡터
  - 행렬 (Matrix)
    - 벡터들을 모아놓은 데이터 집합
    - 2D Array (2차원 배열)
      ex) 우리 회사 창고들
          창고A [ 10(귤), 26(사과), 5(배) ]
          창고B [ 15(귤), 8(사과), 51(배) ]
          창고C [ 24(귤), 3(사과), 15(배) ]
          우리 회사의 귤(59), 사과(37), 배(71) 
          방향이 창고별 과일별 두가지 방향(창고별, 과일별)이 있음 => 2차원 배열
   - 텐서 (Tensor)
     - 같은 크기의 행렬들(텐서들)을 모아놓은 데이터 집합
     - ND Array (다차원 배열) - 방향이 3개 이상일 경우
      ex) 나라별 - 지사별 -창고별 - 과일별 ( 축이 4개로 이루어짐 , 나라,지사,창고,과일별 통계를 낼 수 있음)
          미국   - LA     -창고1  - 귤
                                  - 사과
                                  - 배
                          -창고2 - 귤
                                  - 사과
                                  - 배                
                
                - NY      -창고1  - 귤
                                  - 사과
                                  - 배
                          -창고2 - 귤
                                  - 사과
                                  - 배
                
          중국   - 베이징  -창고1  - 귤
                                  - 사과
                                  - 배
                          -창고2 - 귤
                                  - 사과
                                  - 배
                
                -  상하이  -창고1  - 귤
                                  - 사과
                                  - 배
                          -창고2 - 귤
                                  - 사과
                                  - 배
                                  
 ## 용어
  - 축 (axis)
    -값들의 나열 방향
    - 하나의 축(axis)는 하나의 범주(category)
  - 랭크 (rank)
    - 데이터 집합에서 축의 개수 (차원, dimension)
    ex) matrix 의 rank = 2
        vector 의 rank = 1
  - *형태/ 형상( shape)*
    - 각 축(axis) 별 데이터의 개수
    ex ) vector = [5,6,7]
         vector의 rank = 1 , shape = (3,), size = 3
         matrix = [ [2,5,3]
                    [1,8,5]
                  ]
         matrix의 rank = 2
                  shape = (2,3)
                  size = 6
        tensor = [
                  [
                    [1,2,3],
                    [4,5,6]
                  ],
                  [
                    [10,20,30],
                    [40,50,60]
                  ]
                 ]
        tensor의 rank = 3
                 shape = (2,2,3)
                 size = 12
                  
  - 크기(size)
    - 배열내 원소의 총 개수
         ex) shape = (2,3)인 matrix의 크기는 2*3 = 6
 
 ** 각각의 축이 무엇을 의미하는지를 파악하여 데이터의 구조를 이해하는 것이 중요하다
  ex) 이미지 파일의 경우  shape = (높이, 너비, 채널(RGB))
      (1024,800,3) 의 이미지 파일은
        높이 1024px, 너비 800px, 채널각각 R,G,B 3개의 정보를 담고있음
        
 ## 넘파이 배열(ndarray)
  - n-dimension array => ndarray
  
  - Numpy에서 제공하는 N차원 배열 객체
  - 같은 타입의 값들만 가질 수 있다.
  
## 차원 (dimension)
  ** 차원의 의미는 여러가지로 쓰일 수 있음
  - Vector에서 차원: 원소의 개수
    ex ) 체격 스펙 = [ 몸무게 , 키] => 몸무게, 키 각각이 하나의 차원이 될 수 있음
  - 넘파이 배열에서 차원 : 축의 개수


## 배열 생성 함수
  - array(배열형태 객체 [, dtype])
   - 배열형태 객체가 가진 원소들로 구성된 numpy 배열 생성
      - 배열형태 객체 (array-like)
        -리스트, 튜플, 넘파이배열(ndarray)
    
## 데이터 타입
  - 원소들의 데이터 타입
  - ndarray 는 같은 타입의 데이터만 모아서 관리한다.
  - 배열 생성시 dtype 속성을 이용해 데이터 타입 설정 가능
  - ndarray.dtype 속성을 이용해 조회
  - ndarray.astype(데이터타입)
    - 데이터타입 변환하는 메소드
    - 변환한 새로운 ndarray객체를 반환
  - 타입 지정
     - 문자열로 지정 (직접 입력)
        - 'int'=>기본값 int32로 들어감, 'int64', 'float'
      - numpy에 각 타입이 변수로 제공됨 (자동완성이 되므로 편함)
        - numpy.int, numpy.int64, numpy.float   
        
### zeros(shape, dtype)
    영벡터(행렬) 생성 : 원소들을 0으로 채운 배열
    - shape : 형태(크기, 개수) 지정
    - dtype : 요소의 개수 지정
    ex) zeros(10) => shape(10,) 인 벡터 
        array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0.])
        zeros((2,3,5,4), dtype = int32) => shape이 (2,3,5,4) 이고 데이터타입이 int32 인 텐서
        
### ones(shape, dtype)
    일벡터 생성 : 원소들을 1로 채운 배열
    - shape : 형태(크기, 개수) 지정
    - dtype : 요소의 개수 지정
    
### full(shape, fill_value, dtype))
  원소들을 원하는 값으로 채운 배열 생성
  - shape : 형태(크기, 개수) 지정
  - fill_vlaue : 채울 값
  - dtype : 요소의 개수 지정
  
### arange(start, stop, step, dtype)
start에서 stop 범위에서 step의 일정한 간격의 값들로 구성된 배열 리턴 
- API : (https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.arange.html)
- start : 범위의 시작값으로 포함된다.(생략가능 - 기본값:0)
- stop : 범위의 끝값으로 **포함되지 않는다.** (필수)
- step : 간격 (기본값 1)
- dtype : 요소의 타입

### linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)

시작과 끝을 균등하게 나눈 값들을 가지는 배열을 생성 

- start : 시작값
- stop : 종료값
- num : 나눌 개수. 기본-50, 양수 여야한다.
- endpoint : stop을 포함시킬 것인지 여부. 기본 True / 포함하지 않을 거면 False
- retstep : 생성된 배열 샘플과 함께 간격(step)도 리턴할지 여부. True일경우 간격도 리턴(sample, step) => 튜플로 받는다.
- dtype : 데이터 타입

### eye(N, M=None, k=0, dtype=<class 'float'>)  /  identity(N)
- 항등행렬 생성
단위 행렬 생성 
- N : 행수
- M : 컬럼수
- k : 대각선이 시작할 index (첫행의 index를 지정한다. ) 기본값 : 0
- [API](https://docs.scipy.org/doc/numpy-1.15.1/reference/generated/numpy.eye.html) 
> ### 대각행렬
>    - 행과 열이 같은 위치를 대각(diagnonal) 이라고 하며 그 대각에만 값이 있고 비대각은 0으로 채워진 행렬.    
>
> ### 항등행렬/단위행렬
>    - 대각의 값이 1인 정방행렬로 E나 I 로 표현한다.
>    - 단위행렬은 행렬에서 곱셈의 항등원이다
>    - 행렬곱셈(내적)에대해서 교환법칙이 성립한다.
>         - A* E = A


## 난수를 원소로 하는 ndarray 생성

- numpy의 서브패키지인 random 패키지에서 제공하는 함수들
- np.random.seed(정수) : 시드값 설정

### np.random.seed(시드값)
- 난수 발생 알고리즘이 사용할 시작값(시드값)을 설정
- 시드값을 설정하면 항상 일정한 순서의 난수(random value)가 발생한다.
> 랜덤함수는 특정숫자부터 시작하는 일렬의 수열을 만들어 값을 제공하는 함수이다.    
> 시작 숫자는 실행할때 마다 바뀌므로 다른 값들이 나오는데 시드값은 시작값을 고정시키면 항상 시작 값이 같으므로 같은 값들이 순서대로 제공된다.    
> 매번 실행할때 마다 같은 순서의 임의의 값이(난수) 나오도록 할때 시드값을 설정한다.
- 장점
    - 여러사람이 같은 숫자로 받아서 같은 결과값 받아서 확인할 수 있다
    - 어떤 알고리즘을 짜고 성능으르 검사할 때 어떤 난수가 나오는지에 따라 성능이 다르게 보일 수 있기 때문에 어느 정도 고정된 난수를 줄 수 있다(난수가 성능에 영향을 주는 것을 피하기 위해 초기 개발 시 시드값을 고정)

### np.random.rand(axis0[, axis1, axis2, ...])    
- [API](https://numpy.org/doc/stable/reference/random/generated/numpy.random.rand.html?highlight=rand#numpy.random.rand)
- 0~1사이의 실수를 리턴
- 축의 크기는 순서대로 나열한다.

cf) np.random.random(size=[2,3]) => rand 와 결과값은 똑같이 나오는데 shape을 입력하는게 다름 리스트로 한번 묶어서
    => np.random.rand(2,3)

### np.random.normal(loc=0.0, scale=1.0, size=None) 
정규분포를 따르는 난수.
=> -1 ~ +1 사이 수가 나올 확률이 높아짐 
   
   -2 ~ +2 수가 95 퍼센트
- [API](https://numpy.org/doc/stable/reference/random/generated/numpy.random.normal.html?highlight=normal#numpy.random.normal)
- loc: 평균
- scale: 표준편차
- loc, scale 생략시 표준정규 분포를 따르는 난수를 제공 
> #### 표준정규분포
> 평균 : 0, 표준편차 : 1 인 분포

ex) import numpy as np
np.random.normal() # 표준 정규분포(평균:0 , 표준편차:1)를 따르는 난수를 반환. -2 +2 사이의 값들(2*표준편차)이 많이 나오게된다

np.random.normal(loc= 10,sclae = 5) 
# 평균 10 표준편차 5인 정규분포를 따르는 난수를 반환
# 10-2*5 ~ 10+2*5 범위의 값들이 많이 나옴



import g.pyplot as plt
v = np.random.normal(50,30, size=5000)
plt.figure(figsize=(7,7))
plt.hist(v, bins=30) # 범위를 지정하여 범위마다 있는 값들을 묶어서 그린 그래프 (히스토그램)
# bins : 몇개씩 묶을지 지정
plt.show()

### np.random.randint(low, high=None, size=None, dtype='l')
임의의 정수를 가지는 배열
- [API](https://numpy.org/doc/stable/reference/random/generated/numpy.random.randint.html?highlight=randint#numpy.random.randint)
- low ~ high 사이의 정수 리턴. high는 포함안됨
- high 생략시 0 ~ low 사이 정수 리턴. low는 포함안됨
- size : 배열의 크기. 다차원은 튜플로 지정 기본 1개
- dtype : 원소의 타입




### np.random.choice(a, size=None, replace=True, p=None)
- [API](https://numpy.org/doc/stable/reference/random/generated/numpy.random.choice.html?highlight=choice#numpy.random.choice)
- 샘플링 메소드
- a : 샘플링대상. 1차원 배열 또는 정수 (정수일 경우 0 ~ 정수, 정수 불포함)
- size : 샘플 개수
- replace : 
  True-복원추출(기본)->같은 값을 여러번 뽑을 수 있음
  False-비복원추출 -> 하나의 값은 한 번만 뽑을 수 있음
- p: 샘플링할 대상 값들이 추출될 확률 지정한 배열

## 배열의 값 섞기
- np.random.shuffle(배열)
    - 원본을 섞는다
- np.random.permutation(배열)
    - 원본을 섞은 카피배열을 반환
    
    









