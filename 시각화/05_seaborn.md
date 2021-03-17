#### Seaborn
   - matplotlib을 기반으로 다양한 테마와 그래프를 제공하는 파이썬 시각화 패키지
   - http://seaborn.pydata.org/
    - 공식 사이트의 [gallary] (http://seaborn.pydata.org/examples/index.html)에 제공하는 다양한 그래프와 예제를 확인 할 수 있다.
    - 설치: 아나콘다에 포함되어있음
        ```
          pip install seaborn
          conda install seaborn
        ```
        
        ``` python
            import seaborn as sns
            tips = sns.load_dataset('tips')
        ```
        
 ##### rugplot, kdeplot, distplot
   - 1차원 연속형 값들의 분포를 시각화 하는 그래프

 ##### rugplot
   - 각 데이터들의 위치를 보여준다
   - 
     ``` python
         plt.figure(figsize=(6,6))
         sns.ruplot(tips['total_bill'])
         plt.show()
     ```
   ![다운로드 (10)](https://user-images.githubusercontent.com/76146752/111252666-faead180-8654-11eb-9d86-954f85693f78.png)
   
##### kdeplot
   - 히스토그램을 부드러운 곡선 형태로 표현한다
   - kde(kernel Density Estimation) : 확률밀도추정
   - 
      ``` python
          plt.figure(figsize=(6,6))
          sns.kdeplot(tips['total_bill'])
          plt.show()
      ```
     ![image](https://user-images.githubusercontent.com/76146752/111252894-751b5600-8655-11eb-9e2a-e18469e18a30.png)
     
##### distplot
   - 히스토그램에 kdeplot, rugplot 한 번에 그린다
        - kdeplot은 default로 나오고 rugplot은 default로 안나옴
   - 
     ``` python
        plt.figure(figsize=(6,6))
        sns.displot(tips['total_bill'],
                    hist = False,
                    kde = True,
                    rug = True)
        plt.show()
        #distplot은 dataframe과 컬럼을 나눠서 지정못함
     ```
  ![image](https://user-images.githubusercontent.com/76146752/111253259-3afe8400-8656-11eb-8768-8f97ad04bc12.png)
  
#### boxplot(), violinplot(), swamplot()
   - 연속형 데이터(양적데이터)들의 분포를 확인하는 그래프를 그린다
   - 범주별로 연속형 데이터의 분포를 비교할 수 있다

 ##### boxplot()
   - 
     ``` python
         plt.figure(figsize=(6,6))
         plt.subplot(1,2,1)
         sns.boxplot(y=tips['total_bill'])
         plt.title('수직 boxplot')
         
         plt.subplot(1,2,2)
         sns.boxplot(x=tips['total_bill'])
         plt.title('수평 boxplot')
         # 값을 x에 두는지 y에 두는지에 따라 수직 수평의 boxplot 생성
         plt.show()
      ```
   ![image](https://user-images.githubusercontent.com/76146752/111253879-43a38a00-8657-11eb-87cb-2189f1c89bd6.png)

     ``` python
         plt.figure(figsize=(7,7))
         sns.boxplot(x='smoker',y='total_bill', data=tips)
         #x,y축에 범주형값의 컬럼을 넣으면 범주로 나눠서 boxplot으로 생성
         plt.show()
     ```
  ![image](https://user-images.githubusercontent.com/76146752/111254039-8c5b4300-8657-11eb-986b-1f9efd88de8f.png)

     ``` python
         plt.figure(figsize=(10,7))
         sns.boxplot(x='smoker',y='total_bill', hue='sex', data=tips)
         #두개의 컬럼을 기준으로 범주를 나누려면 x,y축중에 한 축에 범주형 값의 컬럼을 넣고 hue에 범주형 컬럼 추가
         plt.show()
     ```
![image](https://user-images.githubusercontent.com/76146752/111254129-bc0a4b00-8657-11eb-817a-cab8b459818b.png)


  ##### violin plot
   - boxplot 위에 분포밀도(kernel density)를 좌우 대칭으로 덮어쓰는 방식으로 데이터 분포를 표현함
   - boxplot값에서 분포밀도 까지 담고 있기 때문에 보다 정확한 데이터 분포를 볼 수 있다
   - 매개변수는 boxplot과 동일하다
   - 
      ``` python
          plt.figure(figsize=(7,7))
          sns.violinplot(y='tip',x='day',hue='smoker' , data=tips)
          plt.show()
      ```
   ![image](https://user-images.githubusercontent.com/76146752/111254393-4eaaea00-8658-11eb-825a-bf28e873dcfd.png)

 ##### swarmplot
   - 실제 값들을 점으로 찍어준다
   - boxplot이나 violin plot의 보안해주는 역할로 쓰인다
   - swarmplot은 가운데 분류를 기준으로 분포시키는데 실제 값이 있는 위치에 점을 찍으므로 좀더 정확하게 어디에 값이 있는지 알 수 있다
   - 
     ``` python
         plt.figure(figsize=(7,7))
         sns.swarmplot(x='smoker', y = 'tip', data=tips, color = 'k')
         plt.show()
     ```
     ![image](https://user-images.githubusercontent.com/76146752/111255827-253f8d80-865b-11eb-900f-63805cbf6a18.png)

 ##### countplot()
   - 막대그래프(bar plot)을 그리는 함수
   - 범주형 변수의 고유값의 개수를 표시
   - matplotlib의 bar()
   - 
      ``` python
          plt.figure(figsize=(7,7))
          sns.countplot(x='day', data=tips)
          # 범주형 컬럼을 지정하면 고유값별로 개수를 세서 막대그래프 반환
          plt.show()
      ```
![image](https://user-images.githubusercontent.com/76146752/111259044-7e122480-8661-11eb-96e2-44526e06ee4f.png)


      ``` python
          # 요일별-흡연여부별
          plt.figure(figsize=(7,7))
          sns.countplot(x='day', data=tips)
          # 범주형 컬럼을 지정하면 고유값별로 개수를 세서 막대그래프 반환
          plt.show()
      ```
   ![image](https://user-images.githubusercontent.com/76146752/111259760-f1686600-8662-11eb-80dc-d3ab224cd06a.png)

#### scatterplot, lmplot, jointplot, pairplot
   - 산점도를 그린다
  
 ##### scatterplot
   팔레트 - https://seaborn.pydata.org/tutorial/color_palettes.html#palette-tutorial
   
   - 
      ``` python
          plt.figure(figsize=(6,6))
          sns.scatterplot(x='total_bill', y='tip',data=tips, alpha=0.5)
          plt.show()
      ```
  ![image](https://user-images.githubusercontent.com/76146752/111263553-663e9e80-8669-11eb-82d3-605c3b9f38db.png)

   - 
      ``` python
          plt.figure(figsize=(6,6))
          sns.scatterplot(x='total_bill', y='tip', hue='sex', data=tips,alpha=0.7, palette='rainbow')
          # colormap 지정: matplotlib/pandas - cmap, seaborn- palette
          plt.show()
      ```
   ![image](https://user-images.githubusercontent.com/76146752/111263847-dea55f80-8669-11eb-8384-44db5274c435.png)

##### lmplot()
   - 선형회귀 적합선을 포함한 산점도를 그린다
   - linear model
   - 
      ``` python
          sns.lmplot(x='total_bill',y='tip', hue='smoker',data=tips, height=5)
          plt.show()
      ```
   ![image](https://user-images.githubusercontent.com/76146752/111264070-3ba11580-866a-11eb-8826-235ff543b365.png)

##### jointplot()
   - scatter plot과 각 변수의 히스토그램을 같이 그린다
   - pandas DataFrame만 사용할 수 있다
   
   
   
   
   
   
   
