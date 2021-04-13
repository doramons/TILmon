## NLP(Natural Language Processing) 자연어 처리란

### 자연어
  - 사람이 사용하는 고유한 언어
  - 인공언어의 반대 의미
      - 인공언어: 특정 목적을 위해 인위적으로 만든 언어
      - ex) 프로그래밍 언어

### 자연어 처리
  - 사람이 사용하는 자연어를 컴퓨터가 사용할 수 있도록 처리하는 과정
  - 자연어 처리 응용분야
      - 번역 시스템
      - 문서 요약
      - 감성분석
      - 대화형 시스템(챗봇)
      - 정보 검색 시스템
      - 텍스트 마이닝
      - 음성인식

### 텍스트 분석 수행 프로세스
  1. 텍스트 전처리
      - 클렌징(cleansing)
        - 특수문자, 기호 필요없는 문자 제거
        - 대소문자 변경
      - stop word(분석에 필요없는 토큰) 제거
      - 텍스트 토큰화
        - 분석의 최소단위로 나누는 작업
        - 보통 단어단위나 글자단위로 나눈다
      - 어근 추출(stemming/Lemmatization)을 통한 텍스트 정규화 작업
  2. Feature vectorization
      - 문자열 비정형 데이터인 텍스트를 숫자타입의 정형데이터로 만드는 작업
      - BOW와 Word2Vec
  3. 머신러닝 모델 수립, 학습, 예측, 평가

### NLTK
  - Natural Language Toolkit
  - https://www.nltk.org/
  - 자연어 처리를 위한 파이썬 패키지

#### NLTK 설치
  - nltk 패키지 설치 pip 설치
      `pip install nltk`
  - conda 설치
      `conda install -y nltk`
  - NLTK 추가 패키지 설치
      ```python
         import nltk
         nltk.download()
         nltk.download('패키지명')
      ```
      
#### NLTK 주요기능
  - 말뭉치(corpus) 제공
    - 말뭉치:언어 연구를 위해 텍스트를 컴퓨터가 읽을 수 있는 형태로 모아놓은 언어 자료를 말한다
    - 예제용 말뭉치 데이터를 제공한다

  - 텍스트 정규화를 위한 기능 제공
    - 토큰 생성
    - 여러 언어의 Stop word(불용어) 제공
    - 형태소 분석
        - 형태소
            - 의미가 있는 가장 작은 말의 단위
        - 형태소 분석
            - 말뭉치에서 의미있는(분석시 필요한) 형태소들만 추출하는 것
        - 어간추출(Stemming)
        - 원형복원(Lemmatization)
        - 품사부착(POS tagging - Part Of Speech)
  - 분석 기능을 제공해주는 클래스 제공
      - Text
      - FreqDist

### NLTK 텍스트 정규화 기본 문법
  #### 텍스트 토큰화
   
   - 분석을 위해 문장을 작은 단위로 나누는 작업
   - **토큰(Token)**
      - 나뉜 문자열의 단위를 말한다
      - 정하기에 따라 문장, 단어일 수도 있고 문자일 수도 있다
   - Tokenizer
      - NLTK 주요 tokenizer
          - sent_tokenize() : 문장단위로 나눠준다
          - word_tokenize() : 단어단위로 나눠준다
          - regexp_tokenize() : 토큰의 단위를 정규표현식으로 지정
          - 반환타입: 토큰하나 하나를 원소로 하는 list

   - 
      ``` python
          txt = """Beautiful is better than ugly.
                Explicit is better than implicit.
                Simple is better than complex.
                Complex is better than complicated.
                Flat is better than nested.
                Sparse is better than dense.
                Readability counts.""""
           import nltk
           nltk.download('punkt')
           
           # 문장 단위로 토큰화
           sent_list = nltk.sent_tokenize(txt) # 매개변수: 토큰화할 대상 문서(문자열)
           
           # 단어단위로 토큰화(공백기준)
           word_list = nltk.word_tokenize(txt)
           
           print(type(word_list)), len(word_list)
           
           # 토큰의 형식(패턴)을 정규표현식으로 지정
           reg_list = nltk.regexp_tokenize(txt, '\w+') # \w : 0-9a-zA-Z가-힣_ +: 1글자 이상
       ```
       
#### Stopword(불용어)
  - 문장내에서는 많이 사용되지만 문장의 전체 맥락과는 상관없는 단어들
      - ex) 조사, 접미사, 접속사, 대명사 등
  - stopword 단어들을 List로 묶어서 관리한다
      - nltk가 언어별로 Stop word 제공
      - 실제 분석대상에 맞는 stop word 를 만들어서 사용한다

  - 
    ``` python
        nltk.download('stopwords')
        
        from nltk.corpus import stopwords
        
        # 언어별 불용어 사전 loading
        sw_arabic = stopwords.words('arabic')
        
        sw = stopwords.words('english')
        # stopword는 원하는 정보에따라서 추가하거나 빼서 사용할 수 있음
        sw.append('although')
        
        #만들수도 있음
        sw_korean = [
          '그녀','그','이것','저것','그것'
          ]
          
#### tokenize_text() 함수 구현
  - 문장별 토큰화 시키는 함수 구현
  - 쉼표, 마침표 등 구두점(punctuation)은 공백처리한다
  - stopword를 제외한다
  - 
    ``` python
        def tokenize_text(doc):
            """
            하나의 문서를 받아서 토큰화해서 반환하는 함수
            문장별로 단어리스트를 2차원 배열형태로 반환
            구두점/특수문자, 숫자, 불용어(stopword)들은 모두 제거
            모두 소문자로 구성
            [매개변수]
              doc : 변환대상 문서
            [반환값]
              list : 2차원 형태의 리스트( 문장, 단어)
              
            """
            
            # 받은 문장을 다 소문자로 변환
            text = doc.lower()
            
            # 문장단위로 토큰화
            sent_tokens = nltk.sent_tokenize(text)
            
            # stopword 리스트 생성
            sw = stopwords.words('english')
            sw.append(['unless','although']) # 불용어 추가
            
            result_list = [] # 최종결과를 담을 리스트
            
            # 문장별로 단어단위 토큰화
            for sent in sent_tokens:
              # 문장 단위 토큰을 단어단위로 토큰화 작업
              tmp_word = nltk.regexp_tokenize(sent, '[a-zA-Z]+')
              # 불용어 제거
              word_list = [w for w in tmp_word if w not in sw]
              
              result_list.append(word_list)
              
          return result_list
          
#### 형태소 분석
  - 형태소
      - 일정한 의미가 있는 가장 작은 말의 단위
  - 형태소 분석
      - 말뭉치에서 의미있는(분석에 필요한) 형태소들만 추출하는 것
      - 보통 단어로부터 어근, 접두사, 접미사, 품사 등 언어적 속성을 파악하여 처리한다
  - 형태소 분석을 위한 기법
      - 어간추출(Stemming)
      - 원형(기본형) 복원 (Lemmatization)
      - 품사부착(POS tagging - Part Of speech)

#### 어간추출(Stemming)
  - 어간: 활용어에서 변하지 않는 부분
      - painted, paint, painting => 어간:paint
      - 보다, 보니, 보고 => 어간 보-
  - 어간 추출
      - 단어에서 어미를 제거하고 어간을 추출하는 작업
  - 목적
      - 같은 의미를 가지는 단어의 여러가지 활용이 있을 경우 다른 단어로 카운트되는 문제점을 해결한다.
          - flower, flowers 가 두 개의 단어로 카운트 되는 것을 flower로 통일한다
  - nltk의 주요 어간 추출 알고리즘
      - Porter Stemmer
      - Lancaster Stemmer
      - Snowball Stemmer
  - 메소드
      - `stemmer객체.stem(단어)`
  - stemming의 문제
      - 완벽하지 않다는 것이 문제이다
          - ex) new와 news는 다른 단어인데 둘 다 new로 처리한다
      - 처리 후 눈으로 직접 확인해야한다
      - 
        ``` python
            from nltk import PorterStemmer, LancasterStemmer, SnowballStemmer
            
            # stemming은 단어들을 모두 소문자로 변환한 뒤 처리
            words = [
              'Working','Works','Worked',
              'Painting','Paints','Painted',
              'happy','happier','happiest'
            ]
            
            # 1. stemmer 객체를 생성
            # 2. stem(단어)을 호출해서 단어별로 어간추출 작업을 진행
            
            ps = PorterStemmer()
            print([ps.stem(word) for word in words])
            
            ls = LancasterStemmer()
            print([ls.stem(word) for word in words])
            
            sbs = SnowballStemmer('english')
            print([sbs.stem(word) for word in words])
        ```
        
#### 원형(기본형) 복원(Lemmatization)
  - 단어의 기본형을 반환한다
    - ex) am ,is , are => be
  - 단어의 품사를 지정하면 정확한 결과를 얻을 수 있다
  - `WordNetLemmatizer객체.lemmatize(단어 [, pos=품사])`
  > 어간추출과 원형복원은 문법적 또는 의미적으로 변한 단어의 원형을 찾는 역할은 동일하다
  > **원형복원**은 품사와 같은 문법적요소와 문장내에서의 의미적인 부분을 감안해 찾기 때문에 어간추출 방식보다 더 정교하다
  -
    ``` python
        nltk.download('wordnet')
        
        from nltk.stem import WordNetLemmatizer
        
        words = ['is','are','am','has','have']
        
        lemm = WordNetLemmatizer()
        lemm.lemmatize('are',pos='v') # 품사가 동사
        
        print([lemm.lemmatize(word, pos'v') for word in words])
        
        words2 = ['happy','happier','happiest'] # 형용사 : a
        
        lemm = WordNetLemmatizer()
        lemm.lemmatize('happier',pos='a') # 품사를 형용사로 지정
        
        lemm.lemmatize('meeting', pos'v'), lemm.lemmatize('meeting', pos='n') # 같은 단어도 품사를 다르게 지정하면 원형이 다름
        
        
 #### 품사부착 - POS Tagging(Part-Of-Speech Tagging)
  - 형태소에 품사를 붙이는 작업
  - NLTK는 펜 트리뱅크 태그세트(Penn Treebank Tagset)이용
      - 명사 : N으로 시작 (NN-일반명사, NNP- 고유명사)
      - 형용사 : J로 시작(JJ, JJR-비교급, JJS-최상급)
      - 동사 : V로 시작 (VB-동사, VBP-현재형 동사)
      - 부사: R로 시작 (RB-부사)
      - `nltk.help.upenn_tagset(['키워드'])` : 도움말
  - `pos_tag(단어_리스트)`
      - 단어와 품사를 튜플로 묶은 리스트를 반환

  - 
    ``` python
        nltk.download('tagsets')
        nltk.download('averaged_percetron_tagger')
        
        nltk.help.upenn_tagset()
        
        nltk.help.upenn_tagset('JJ')
        
        from nltk.tag import pos_tag
        words = ['Book','book','car','go','Korea','have','good']
        
        post_tag(words)
        
        
    ```
#### txt 원형복원
  - 각 token에 품사를 부착
  - 원형복원 처리
  - 
    ``` python
        pos_taged_tokens = pos_tag(tokens)
        
        def get_wordnet_postag(pos_tag):
            """
            펜 트리뱅크 태그셋의 품사를 (pos_tag() 반환형식)을 WordNetLemmatizer(원형복원)가 사용하는 품사 형식으로 변환
            - n : 명사, a: 형용사, v:동사, r:부사
            """
            if pos_tag.startswith('J'):
                return 'a'
            elif pos_tag.startswith('N'):
                return 'n'
            elif pos_tag.startswith('V'):
                return 'v'
            elif pos_tag.startswith('R'):
                return 'r'
            else:
                return None
       
        
        wordnet_pos_taged_tokens = [(word, get_wordnet_postag(tag)) for word in pos_taged_tokens if get_wordnet_postag(tag) != None]
        
        lemm = WordNetLemmatizer()
        
        token_lemm = [lemm.lemmatize(word, pos=tag) for word, tag in wordnet_pos_taged_tokens]
        
        
     ```

#### 텍스트 전처리 프로세스
   - 클렌징(cleansing)
      - 특수문자, 기호 필요없는 문자 제거
      - 대소문자 변경
   - stop word(분석에 필요없는 토큰)제거
   - 텍스트 토큰화
      - 분석의 최소단위로 나누는 작업
      - 보통 단어단위나 글자단위로 나눈다
   - 어근추출(Stemming/Lemmatization)을 통한 텍스트 정규화 작업


  - 
    ``` python
        def tokenize_text2(doc):
            """
            tokenize_text() 함수 + 원형복원을 추가
            """
            
            # 소문자 변환
            text = doc.lower()
            
            # 문장 단위로 토큰화
            sent_tokens = nltk.sent_tokenize(text)
            
            # StopWords 객체
            sw = stopwords.word('english')
            
            sw.extend(['although','unless'])
            
            result_list = []
            
            for sent in sent_tokens:
                word_tokens = nltk.regxp_tokenize(sent, r'[a-zA-Z]+')
                
                work_tokens = [w for w  in word_tokens if w not in sw]
                
                # 원형복원
                word_tokens = pos_tag(word_tokens)
                
                word_tokens = [lemm.lemmatize(word, post = tag) for word, tag in work word_tokens]
                
                result_list.append(wod_tokens)
            return result_list
      ```
      
### 분석을 위한 클래스들
  #### Text클래스
   - 문서 분석에 유용한 여러 메소드 제공
   - **토큰 리스트**을 입력해 객체생성 후 제공되는 메소드를 이용해 분석한다
   
   - ### 생성
      - Text(토큰리스트, [name=이름])
   - ### 주요메소드  
      - text.count(단어)
           - 매개변수로 전달한 언어의 빈도수
      - text.plot(N)
          - 빈도수 상위 N개 단어를 선그래프로 시각화
      - text.dispersion_plot(단어리스트)
          - 매개변수로 전달한 단어들이 전체 말뭉치의 어느 부분에 나오는지 시각화

      - 
        ``` python
            news_words = [word for word_list in news_tokens for word in word_list]
            news_words2 = []
            for word_list in news_tokens:
              news_words2 += word_list
              
            from nltk import Text
            import matplotlib.pyplot as plt
            
            # Text객체 생성
            text = Text(news_words, name='손흥민뉴스')
            
            # text.count(단어) : 단어의 빈도수 조회
            news_text.count('parent'), news_text.count('son')
            
            # 빈도수 상위 단어들에 대한 선그래프
            plt.figure(figsize=(10,7))
            text.plot(20)
            plt.show()
            
            # 말뭉치 시각화
            plt.figure(figsize=(10,7))
            
            news_text.dispersion_plot(['son','korean','say'])
            
            plt.show()
        ```
  ![image](https://user-images.githubusercontent.com/76146752/114565914-b2065700-9cac-11eb-8f1c-9af9453c85d8.png)
  ![image](https://user-images.githubusercontent.com/76146752/114565927-b599de00-9cac-11eb-847a-679d3ac49de3.png)

#### FreqDist
  - document에서 사용된 토큰(단어)의 사용빈도 데이터를 가지는 클래스
      - 토큰(단어)를 key, 개수를 value로 가지는 딕셔너리 형태
  - 생성
      - Text 객체의 vocab() 메소드로 조회한ㄷ
      - 생성자(Initializer)에 토큰 List를 직접 넣어 생성가능
  - 주요메소드
      - B() : 출연한 고유 단어의 개수
      - N() : 총 단어수
      - get(단어) 또는 FreqDist['단어'] : 특정 단어의 출연 빈도수
      - freq(단어) : 총 단어수 대비 특정단어의 출연비율
      - most_common() : 빈도수 순서로 정렬하여 리스트로 반환

     -      
       ``` python
           # FreqDist 객체 생성
           freq = news_text.vocab()

           from nltk import FreqDist
           freq2 = FreqDist(news_words)

           "총 단어수: {}, 고유단어개수: {}".format(freq.N(), freq.B())

           "단어 london의 빈도수: {},{},{}".format(freq.get('london'), freq['london'], news_text.count('london'))

           "단어 london의 출연비율: {},{}".format(freq.get('london')/freq.N(), freq.freq('london'))

           # 단어의 빈도수를 내림차순으로 정렬해서 반환
           freq.most_common()
       ```

#### wordcloud
     - 
       ``` python
           !pip install wordcloud
           
           # 한글처리를 위해서는 한글을 지원하는 폰트의 경로를 지정해야한다
           # 폰트경로조회
           import matplotlib.font_manager as fm
           
           for f in fm.fontManager.ttflist:
              print(f.name, f.fname)
              
           [(f.name, f.fname) for f in fm.fontManger.ttflist if 'malgun' in f.name.lower()]
           
           font_path = 'C:\\Windows\\Fonts\\malgun.ttf'
           
           from wordcloud import WordCloud
           # 설정
           wc = WordCloud(font_path=font_path,
                          max_words = 100, # 최대 나오는 단어의 개수
                          prefer_horizontal = 0.7, # 가로쓰기 비율
                          relative_scaling = 0.5, # 0~1 사이의 실수. 1에 가까울수록 빈도수가 많은 단어와 적은 단어의 크기 차이를 크게한다
                          min_font_size = 1,
                          max_font_size = 50, # 가장 작은 폰트의 크기, 가장 큰 폰트의 크기 지정
                          background_color = 'white'
                          )
           # WordCloud 객체에 데이터 넣기
           word_cloud = wc.generate_from_frequencies(freq) # 딕셔너리: {단어:빈도수, 단어:빈도수,....}
           
           # 파일로 저장
           word_cloud.to_file('word_cloud.png')
           
           plt.figure(figsize=(15,15))
           plt.imshow(word_cloud)
           plt.axis('off')
           plt.show()
       ```
   ![image](https://user-images.githubusercontent.com/76146752/114570706-04e20d80-9cb1-11eb-82ea-9bb5163e35a6.png)

#### scikit-learn의 CounterVectorizer를 이용해 TDM 만들기
  
  - TDM/DTM
      - Term-Document-Matrix
      - 문서안에서 문서를 구성하는 단어들이 몇번 나왔는지를 표현하는 행렬
  - TDM 행렬 반환
      - 행: 문서
      - 컬럼: 고유단어
      - value: 개수
  - 학습: fit(raw document)
      - raw document - 문장을 원소로 가지는 1차원 배열형태 문서
      - 전체 문장들(corpus)에서 고유단어들을 찾아낸뒤 index를 붙인다
  - 변환: transform(raw document)
      - 문장별(원소) 단어 count
  - CountVectorizer 주요 속성, 메소드
      - cv.vocabulary_
          - 단어-index반환(딕셔너리)
      - get_feature_names()
          - index순서대로 단어들 반환
  - 
    ``` python
        docs = [
            "This is the first document. I write this document", # 1번문서
            "I like apple. I read document" # 2번 문서
        ]
        from sklearn.feature_extraction.text import CountVectorizer
        cv = CountVectorizer()
        
        cv.fit(docs)
        
        cv.vocabulary_
        
        dtm = cv.transform(docs)
        dtm.toarray()
        
        cv.get_feature_names()
        
        import pandas as pd
        pd.DataFrame(dtm.toarray(), columns = cv.get_feature_names())
        
        import pandas as pd
        
        df = pd.DataFrame(freq.most_common(), columns=['단어','빈도수/문서1'])
        df.head()
        
        tdm = df.set_index('단어')
        
        dtm = tdm.T
    ```
            
        
        
        
