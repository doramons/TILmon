## KoNLPy(코엔엘파이)
  - 한국어 처리를 위한 파이썬 패키지

### KoNLPy 설치
  - Java 실행환경 설치
  - JPype1 설치
  - KoNLPy 설치


### 1. Java설치
  - OS에 맞게 다운로드 한다
  - 환경변수 설정
      - `JAVA_HOME` : 설치 경로 지정
      - `Path` : `설치경로\bin` 경로 지정

### 2. JPype1 설치
  - 파이썬에서 자바 모듈을 호출하기 위한 연동 패키지
  - 설치 `!pip install JPype1==0.7.0`

### 3. KoNLP 설치
  - `pip install konlpy`


## KoNLPy 제공 말뭉치
  
  1. kolaw: 대한민국 헌법 말뭉치
    - constitution.txt
  2. kobill: 대한민국 국회 의안(국회에서 심의하는 안건- 법률, 예산 등) 말뭉치
    - 1809890.txt ~ 1809899.txt

  - 
    ``` pyhton
        from konlpy.corpus import kolaw, kobill
        
        # corpus 파일이름 조회
        kolaw.fileids()
        
        kobill.fileids()
        
        constitution = kolaw.open('constitution.txt')
    ```
    
## 형태소 분석기/ 사전
  - 형태소 사전을 내장하고  있으며 형태소 분석 함수들을 제공하는 모듈

### KoNLPy 제공 형태소 분석기
  - Hannanum(한나눔)
    - KAIST Semantic Web Research Center 에서 개발
  - Kkma(꼬꼬마)
    - 서울대학교 IDS(Intelligent Data Systems) 연구실 개발
  - Komoran(코모란)
    - Shineware에서 개발
    - 오픈소스버전과 유료버전이 있음
  - Mecab(메카브)
    - 일본어용 형태소 분석기를 한국에서 사용할 수 있도록 수정
    - windows에서는 설치가 안됨
  - Open Korean Text
    - 트위터에서 개발

### 형태소 분석기 공통 메소드
  - `morphs(string)` : 형태소 단위로 토큰화(tokenize)
  - `nouns(string)` : 명사만 추출하여 토큰화(tokenize)
  - `pos(string)` : 품사 부작
      - 형태소 분석기마다 사용하는 품사태그가 다르다
  - `tagset` : 형태소 분석기가 사용하는 품사태그 설명하는 속성
  -   
      ``` python
          from konlpy.tag import Okt, Komoran # Open Koreann Text
          okt = Okt()

          tokens = okt.morphs(txt)
          len(tokens)

          # 명사만 추출
          noun_tokens = okt.nouns(txt)

          # 품사부착
          pos_tokens = okt.pos(txt)

          pos_tokens2 = okt.pos(txt, join=True)

          okt.tagset

          okt.morphs('반갑습니당', norm=True)

          kom = Komoran()
          # 형태소 토큰화
          tokens = kom.morphs(txt)

          nouns_token = kom.noun(txt)

          pos_token = kom.pos(txt)
      ```
    
#### KoNLPy 형태소 분석기와 NLTK를 이용한 문서의 분석
  - 
    ``` python
        from nltk import Text
        from konlpy.corpus import kolaw
        from konlpy.tag import Komoran
      
        law = kolaw.open('constituyion.txt').read()
        
        # 명사만 추출
        kom = Komoran()
        nouns = kom.nouns(law)
        
        # 1글자인 단어들은 제거
        nouns = [word for word in nouns if len(word)>1]
        
        text = Text(nouns, name='헌법')
        
        "대한민국 빈도수: {}, 헌법 빈도수: {}. 국민 빈도수: {}".format(text.count('대한민국'), text.count('헌법'), text.count('국민'))
        
        import matplotlib as mpl
        mpl.rcParams['font.family'] = 'malgun gothic'
        
        import matplotlib.pyplot as plt
        plt.figure(figsize=(10,7))
        
        plt.title('헌법에 나온 명사 빈도수 상위 20개')
        text.plot(20)
        
        plt.show()
    ```
![image](https://user-images.githubusercontent.com/76146752/114583013-20064a80-9cbc-11eb-9cdb-9d14ccddac7f.png)

  - 
    ``` python
        plt.figure(figsize=(15,10))
        text.dipersion_plot(['법률','대통령','국가','국회','헌법'])
    ```
![image](https://user-images.githubusercontent.com/76146752/114583179-4d52f880-9cbc-11eb-9691-29e40aaea453.png)
  
  - 
    ``` python
        # 매개변수로 전달한 단어가 나오는 라인을 출력
        text.concordance('국민', width = 50, lines=10) #lines: 줄 제한
        
        freq = text.vocab()
        f'총단어수: {freq.N()}, 고유단어수: {freq.B()}, 최빈단어: {freq.max()}, 최빈단어의 빈도수: {freq.get(freq.max())}, 최빈단어의 출연비율: {freq.freq(freq.max())}'
        
        word_cnt = freq.most_common()
        
        import pandas as pd
        df = pd.DataFrame(word_cnt, columns = ['단어','빈도수'])
        
        # wordcloud
        font_path = 'C:\\WINDOWS\\Fonts\\malgun.ttf'
        
        from wordcloud import WordCloud
        wc = WordCloud(font_path=font_path,
                       max_words=200)
        word_cloud = wc.generate_from_frequencies(freq)
        
        plt.figure(figsize=(10,10))
        plt.imshow(word_cloud)
        plt.axis('off')
        plt.show()
    ```
![image](https://user-images.githubusercontent.com/76146752/114584649-dae31800-9cbd-11eb-9fd1-85980d45a307.png)


