 #### DataFrame(데이터프레임)
 
  ##### DataFrame 개요
      - 표(테이블-행렬)를 다루는 Pandas 클래스
          - 데이터베이스의 Table이나 R의 data.frame이나 Excel의 표와 동일한 역할
      - 분석할 데이터를 가지는 판다스의 가장 핵심적인 클래스
      - 행이름: index 열이름: column(컬럼은 순번이 따로 없음)
        - 행이름과 열이름은 명시적으로 지정할 수 있다
        - 명시적으로 지정하지 않으면 순번(0부터 1씩 증가) 이 index, column 명으로 사용된다
        - 하나의 행과 하나의 열은 Series로 구성된다
      - 직접 데이터를 넣어 생성하거나 데이터 셋을 파일(csv, 엑셀, DB 등)로 부터 읽어와 생성한다


  ##### DataFrame 생성
  
   ###### 직접생성
      - `pd.DataFrame(data [, index= None, columns=None]) => 보통 컬럼명은 필수적으로 지정한다
      - data
         - DataFrame을 구성할 값을 설정
            - Series, List,ndarray를 담은 2차원 배열 : 행단위
            - 열이름을  key로 컬럼의 값 value로 하는 딕셔너리: 열단위
         - index
            - index명으로 사용할 값 배열로 설정
         - columns
            - 컬럼명으로 사용할 값 배열로 설정

  ##### DataFrame 파일로 저장
    
   ###### DataFrame객체.to_파일타입()
      - DataFrame객체.to_csv(파일경로,sep=',', index=True, header=True, encoding)
          - 텍스트 파일로 저장
          - 파일경로 : 저장할 파일경로(경로/파일명)
          - sep : 데이터 구분자
          - index, header: 인덱스/ 헤더(컬럼명) 저장여부
          - encoding
              - 파일인코딩
              - 생략시 운영체제 기본 encoding 방식
          - DataFrame객체.to_excel(파일경로, index=True, header=True)
              - 엑셀파일로 저장

  ###### 파일로부터 데이터셋을 읽어와 생성하기
      - pd.read_xxxx() : xxxx=> 파일의 포맷
       ex) pd.read_csv('파일경로')
       
   ###### csv 파일 등 텍스트 파일로부터 읽어와 생성
      - pd.read_csv(파일경로, sep=",",header, index_col, na_values,encoding)
        - 파일경로: 읽어올 파일의 경로
        - sep
            - 데이터 구분자
            - 기본값: 쉼표
        - header = 정수
            - 열이름(컬럼이름)으로 사용할 행 지정
            - 기본값: 첫번째 행
            - None 설정: 첫번째 행부터 데이터로 사용하고 header(컬럼명)는 0부터 자동증가하는 값을 붙인다
        - index_col= 정수, 컬럼명
            - index명으로 사용할 열이름(문자열)이나 열의 순번(정수)을 지정
            - 생략시 0부터 자동증가하는 값을 붙인다
        - na_values
            - 읽어올 데이터셋의 값 중 결측치로 처리할 문자열 지정
            - NA, N/A, 빈값 => 결측치로 자동인식
        - encoding
            - 파일 인코딩
            - 생략시 운영체제 기본 encoding방식

![다운로드 (5)](https://user-images.githubusercontent.com/76146752/109014423-76f99580-76f7-11eb-96cb-7e57b86d6d4c.png)
![다운로드 (6)](https://user-images.githubusercontent.com/76146752/109014425-782ac280-76f7-11eb-98ab-12da07dcf8f1.png)

 ##### 데이터 프레임의 기본 정보 조회
   - csv파일 읽기
    ex) df = pd.read_csv('data/movie.csv')
   - shape
    ex) df.shape
   - head()
    ex) df.head() => 기본값 10 / 앞에서부터 10개의 데이터를 조회
   - tail()
    ex) df.tail() => 뒤에서 10개의 데이터 
   - info()
   - isnull().sum() => 컬럼별 null체크 (sum() null값 총 개수)
   - index/columns : index와, 컬럼명 조회
   - describe() :숫자형- 기술통계값, 문자열- 총개수, 유니크값, 최빈값
    ex) df.describe(include = 'object') => 데이터값이 문자열인 값들에 대해서만 조회
    
    
##### 컬럼이름/ 행이름 조회 및 변경
  ###### 컬럼이름/ 행이름 조회
    - DataFrame객체.columns
       - 컬럼명 조회
       - 컬럼명은 차후 조회를 위해 따로 변수에 저장하는 것이 좋다
         ex) cols = df.columns
       - DataFrame객체.index
         - 행명 조회

  ###### 컬럼이름/행이름 변경
   - 컬럼과 인덱스는 불변의 성격을 가짐
   - columns와 index 속성으로는 통째로 바꾸는 것은 가능하나 index로 하나씩 바꾸는건 안됨
     - 'df.columns = ['새이름','새이름',...,'새이름']
     - df.columns[1] = '새이름' 이렇게 하나만 따로 지정하는 건 안됨(error)

  ###### 컬럼이름/행이름 변경 관련 메소드
    - DataFrame객체.rename(index = 행이름 변경설정, columns = 열이름변경설정, inplace =False)
    - DataFrame객체.rename(mapper= 행이름변경설정, axis =축번호 , inplace=False)
       - 개별 컬럼이름/행이름 변경하는 메소드
       - 변경한 DataFrame을 반환
       - 변경설정: 딕셔너리 사용
          - {'기존이름': '새이름',...}
          - inplace: 변경사항을 원본에 적용할지 여부

    - DataFrame객체.set_index(컬럼이름(index명으로 지정할 컬럼,inplace=False)
        - 특정 컬럼을 행의 index명으로 사용
        - 열이 index명이 되면서 그 컬럼은 Dataset에서 제거된다
    - DataFram객체.reset_index(drop = False, inplace:False)
         - index를 첫번째 컬럼으로 복원
         - drop = True :기존 index명을 제거하고 index명을 순번으로 변경(0,1,2..)

 ###### 행/열 삭제
   - DataFrame객체.drop(columns, index, inplace=False) 또는 DataFame객체.drop(labels=삭제할 컬럼/index이름, axis = 삭제할 축)
    ex) df.drop(labels=['korean'], axis=1)
        df.drop(labels=['korean'], axis=1)
   - columns : 삭제할 열이름 또는 열이름 리스트
    ex) df.drop(columns= 'korean') , df.drop(columns = ['korean','English']
   - index : 삭제할 index명 또는 index리스트
    ex) df.drop(index=['id-5','id-4'])
        df.drop(labels=['id-1','id-4'],axis=0)
    **-행, 열 제거할 때 순번은 사용할 수 없음(이름으로만 제거가능) or reset_index로 index를 순번으로 바꾼뒤 제거** 
   - inplace: 원본을 변경할지 여부(boolean) 

 ##### 행별, 열별 값 조회
  ###### 열(컬럼) 조회 - Series로 리턴
  
    - df['컬럼명']
      ex) df['korean']
    - df.컬럼명
      ex) df.korean
    - 팬시 indexing
      - 여러개의 컬럼을 조회할 경우 컬럼명들을 담은 리스트/튜플로 조회
     **주의
      - df[컬럼index]는 조회안됨
      - df[0:3] 으로 조회하면 행이 슬라이싱되어 나옴(0번~2번행)
      - 만약 indexing이나 slicing을 이용해 컬럼값 조회하려면 columns 속성을 이용한다
        ex) df[df.columns[:3]]
      - 조회결과
        - 한 개 컬럼조회: Series로 반환(행명을 index명으로 조회값을 값으로 가지는 Series)
        - 여러개 컬럼조회: DataFrame으로 반환
          ex) df[['korean','math','music']] #fancy indexing을 통해 여러개 조회
      
##### 다양한 열선택 기능을 제공하는 메소드들
   
   - select_dtypes(include=[데이터타입..,],exclude=[데이터타입,..])
     - 전달한 데이터 타입의 열들을 조회
     - include: 조회할 열 데이터 타입
     - exclude: 제외하고 조회할 열 데이터 타입
   - filter(items=[], like='', regex='')
     - 매개변수에 전달하는 열의 이름에 따라 조회
        - 각 매개변수중 하나만 사용할 수 있다
        - item = []
           - 리스트와 일치하는 열들 조회
           - 이름이 일치하지 않아도 Error발생 안함
