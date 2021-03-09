#### 데이터 시각화
  - 통계값만 봤을 때는 비슷한 형태의 데이터셋처럼 보이지만 실제로 전혀다른 형태의 데이터셋이 경우가 있다
  - 따라서 통계값으로 볼 수 없었던 다양한 정보들을 데이터 시각화를 통해 확인할 수 있다

#### 1. Mataplotlib
  - http://matplotlib.org
  - 데이터의 시각화를 위한 파이썬 패키지
  - 2차원 그래프를 위한 패키지이나 확장 API들을 이용해 3D 그래프 등 다양한 형식의 시각화를 지원한다
  - 파이썬 기반의 다른 시각화 패키지의 기본이 된다
    - seabone, Pandas 등이 Matplotlib를 기반으로 사용한다

##### 1.1 장점
  - 동작하는 OS를 가리지 않는다
  - MATLAB과 유사한 사용자 인터페이스를 가진다
  - 그래프에 대한 상세한 설정을 할 수 있다
  - 다양한 출력형식으로 저장할 수 있다

##### 1.2 matplotlib 그래프 구성요소
![다운로드 (9)](https://user-images.githubusercontent.com/76146752/110438691-fd4fa780-80f9-11eb-9e03-7e54448c9caf.png)
   - figure
     - 전체 그래프가 위치할 기본 틀 (도화지역할)
     - https://matplotlib.org/api/_as_gen/matplotlib.pyplot.figure.html
   - axes(subplot)
     - 하나의 그래프를 그리기 위한 공간
        - figure에 한 개 이상의 axes(subplot)로 구성해서 각 axes에 그래프를 그린다
     - http://matplotlib.org/api/axes_api.html
   - axis
      - 축(x축, y축)
      - axis label (x, y) :축의 레이블(설명)
   - ticks : 축선의 표시
      - Major tick
      - Minor tick
   - title : 플롯 제목
   - legend (범례)
      - 하나의 axes내에 여러 그래프를 그린 경우 그것에 대한 설명


##### 2. 그래프 그리기
   1. matplotlib.pyplot 모듈을 import
        - 2차원 그래프(axis가 두개인 그래프)를 그리기 위한 함수를 제공하는 모듈
        - 별칭(alias)로 plt를 관례적으로 사용한다
        - import matplotlib.pyplot as plt
   2. 그래프를 그린다
        - 2가지 방식
            - pyplot 모듈을 이용해 그린다
            - Figure와 Axes 객체를 생성해서 그린다   
   3. 그래프에 필요한 설정을 한다
   4. 화면에 그린다
        - 지연 랜더링(Deferred rendering)매커니즘
        - 마지막에 pyplot.show() 호출시 그래프를 그린다
            - 주피터 노트북 맨 마지막 코드에 ;를 붙이는 것으로 대체할 수 있다

##### 3. 그래프를 그리는 두가지 방식
   - pyplot 모듈을 이용해 그린다
   - Figure와 Axes 객체를 생성해서 그린다

##### 3.1 pyplot 모듈을 이용해 그리기
   - pyplot 모듈이 그래프 그리는 함수와 Axes(Subplot) 설정 관련 함수를 제공
   - ex) 
     import matplotlib.pyplot as plt
     
     plt.plot([1,2,3,4,5],[10,20,30,40,50]) -> 그래프 그리기 (선그래프)

     추가설정
     plt.title("pyplot 예제")
     plt.xlabel("X축값")
     plt.ylabel("Y축값")
     
     plt.show() -> 그래프를 화면에 나오게 하기
     
   - 하나의 figure에 여러 그래프 그리기
      - plt.subplot(row,columns,num)
      - figure의 크기
        - plt.figure(figsize=(10,10))
      - subplot 지정
        - plt.subplot(2,1,1) 
      - 그래프 그리기
        - plt.plot([1,2,3],[10,20,30])
      - 추가설정
        - plt.title("첫번째")
        - plt.xlabel("x축")
        - plt.ylabel('y축')
      - subplot 지정
        - plt.subplot(2,1,2)
      - 그래프 그리기
        - plt.scatter([1,2,3],[10,20,30])
      - 추가 설정
        - plt.title('두번째')
       
##### 3.2. Figure 와 Axes 객체를 이용해 그리기
  - Figure에 axes를 추가한 뒤 axes에 그래프를 그린다
  - axes 생성 방법
      - figure.add_suplot()메소드 이용
          - figure를 먼저 생성 후 axes들을 추가
      - pyplot.subplots() 함수를 이용
          - figure와 axes배열을 동시에 생성

##### 3.2.1 figure.add_subplot() 메소드 이용
  - figure객체에 axes를 추가하는 형태
  - nrows(총행수), ncols(총열수), index(axes위치) 지정
  - ex) ax1 = fig.add_subplot(2,2,1)
  -     ax2 = fig.add_subplot(223) =(2,2,3)

##### 3.2.2 pyplot.subplots()
  - nrows, ncols로 axes개수와 위치 지정
  - 반환: figure와 axes(subplot)들을 담은 ndarray
  - ex)
     ``` python
       import matplotlib.pylot as plt
       fig, axes = plt.subplots(2,2, figsize=(10,10))
       fig.suptitle('Figure 제목', size=40)
       ax1, ax2, ax3, ax4 = axes.flatten()
       ax1.scatter([1,2,1,2,6],[7,3,4,2,1])
       ax1.set_title('ax1제목')
       ax2.plot([1,2,3],[1,2,3], label='line1')
       ax2.legend()
       ax2.grid(True)
      ```

##### 4. 색상과 스타일
###### 4.1 색 지정
   - color 또는 c 속성을 이용해 지정
   - 색상이름으로 지정
        - 색이름 또는 약자로 지정가능
     -  | 문자열 | 약자 |
        |-|-|
        | blue | b |
        | green | g |
        | red | r |
        | cyan | c |
        | magenta | m |
        | yellow | y |
        | black | k |
        | white | w |
    - HTML 컬러문자열
        - #으로 시작하며 RGB의 성분을 16진수로 표현
        - #RRGGBB 또는 #RRGGBBAA
        - #FF0000, ##00FFFA
    - 0 ~ 1 사이 실수로 흰색과 검정색 사이의 회색조를 표시
      - 0: 검정, 1: 흰색
      - https://matplotlib.org/examples/color/named_colors.html
      - https://htmlcolorcodes.com/
        - picker, chart(코드), name(색이름) 제공사이트

###### 4.2 Style
  - Style: 그래프의 여러 시각효과들을 미리 설정해 놓은 것
  - mataplotlib는 다양한 스타일들을 미리 정의해 놓고 있다
      - [스타일목록]
      - (https://matplotlib.org/gallery/style_sheets/style_sheets_reference.html)
      - plt.style.use() 함수 이용해 지정
      - 스타일 초기화
      ```python
        import matplotlib as mpl
        mpl.rcParams.update(mpl.rcParamsDefault)
      ```
      ex) plt.style.use('dark_background')
