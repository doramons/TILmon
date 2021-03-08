#### matplotlib 한글처리
  - matplotlib에 설정되어있는 폰트가 한글을 지원하지 않기 때문에 그래프의 한글이 깨져서 나옴
##### 설정방법
  1. 설정파일을 변경한다
      - 프로그램을 설치할때 한번만 하면 된다
  2. 프로그램상에서 변경한다
      - 프로그램이 로딩될 떄 마다 (노트북파일이나 파이썬 스크립트 실행시마다)코드를 실행해야한다
      - 전체 설정에서 변경하고 싶은 것을 재설정한다

##### OS에 설치된 폰트명 조회
  - 폰트 cache파일을 삭제한다
    - cache 파일 조회
      ex) mpl.get_cachedir()
    - 다음 실행 결과로 나온 경로의 파일을 삭제한다

##### 폰트 등 환경 설정하기
  1. 설정파일 변경
      - 한번만 하면되므로 편리하다
      - 설정파일 경로 찾기 : matplotlib.matplotlib_fname() -> matplotlib관련 전역 설정들을 찾아 바꿔준다
      - 폰트관련 설정
          - ```
            font.family:Malgun Gothic
            font.size:12
            xtick.labelsize:12
            ytick.labelsize:12 
            axes.labelsize:12 
            axes.titlesize:20
            axes.unicode_minus:False
            ```
  2.  함수를 이용해 설정
      - matplotlib.rcParam['설정'] = 값 으로 변경
      - 한글 폰트 설정
        ex) font_name = fm.FontProperties(fname="c:/Windows/Fonts/malgun.ttf").get_name() -> 폰트 이름 확인 가능
            mpl.rcParams["font.family"] = font_name
            mpl.rcParams["font.size"] = 15
            mpl.rcParams['xtick.labelsize'] = 12
            mpl.rcParams['ytick.labelsize'] = 12
            mpl.rcParams['axes.labelsize'] = 15
            # tick의 음수기호 '-' 가 깨지는 것 처리
            mpl.rcParams['axes.unicode_minus'] = False
            
            **색상을 바꾸고 싶을때
            COLOR = 'blue'
            mpl.rcParams['text.color'] = COLOR
            mpl.rcParams['axes.labelcolor'] = COLOR
            mpl.rcParams['xtick.color'] = COLOR
            mpl.rcParams['ytick.color'] = COLOR
