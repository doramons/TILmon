##### Pandas 시각화
  - 판다스 자체적으로 matplotlib를 기반으로 한 시각화 기능을 지원한다
  - Series나 DataFrame에 plot() 함수나 plot accessor를 사용한다

  ###### plot()
   - kind매개변수에 지정한 값에 따라 다양한 그래프를 그릴 수 있다
   - kind :그래프 종류 지정
      - 'line' : line plot (default)
      - 'bar' : vertical bar plot
      - 'barh' : horizontal bar plot
      - 'hist' : histogram
      - 'box' : boxplot
      - 'kde' : Kernel Density Estimation plot
      - 'pie' : pie plot
      - 'scatter' : scatter plot

 ###### 막대그래프
   - index가 무슨 값인지 가리키는 축으로 사용된다
   - 두개의 분류별로 그리기
      - 여러 개의 컬럼일 경우 수평 누적 막대그래프를 그린다
    -  
        ``` python
             agg_df = tips.pivot_table(index='smoker', columns = 'sex', values='tip', aggfunc='count')
             agg_df.plot.bar(figsize=(7,7))
             plt.show()
         ```

 ###### 파이차트
   -
        ``` python
            tips['day'].value_counts().plot.pie(figsize=(7,7),autopct = '%.2f%%', fontsize=15) = 
            tips.groupby('time')['tip'].mean().plot(kind='pie',figsize= (7,7),autopct='%.2f%%',fontsize=15)
            plt.show()
         ```

 ###### 히스토그램, KDE(밀도그래프)
   -
        ``` python
            tips['total_bill'].plot.hist(figsize=(6,6), bins=20)
            tips['total_bill'].plot(kind='hist',figsize=(6,6), bins=20)
            plt.show()
        ```
        
        ``` python
            tips['total_bill'].plot.kde()
            plt.show()
        ```
        
###### Boxplot(상자그래프)
   -
        ``` python
            tips[['total_bill','tip']].plot(kind='box',figsize=(7,7))
            plt.show()
        ```
        
        ``` python
            tips.plot(kind='box') # tips columns 중 datatype이 숫자형인 컬럼만 나옴
            plt.show()
        ```
        
###### line plot
   - 
     ``` python
         df['no1'].plot.line(figsize=(10,5))
         plt.show()
         # DataFrame : X- index, Y-숫자형 컬럼들 -> 컬럼별로 선그래프를 각각 그려준다
         df[['no1','no2']].plot(figsize=(10,5))
         plt.show()
         
         df.plot(figsize=(10,5), cmap='rainbow')
         plt.show()
         
         df['no3_cumsum']=df['no3'].cumsum() #누적합계
         df[['no3','no3_cumsum']].plot(figsize=(10,5))
         plt.show()
    
     
     
###### scatter plot(산점도)
   - DataFrame을 이용해서만 그린다(Series는 x)
   - 
      ``` python
          tips.plot.scatter(x='total_bill', y='size', figsize=(6,6))
          tips.plot(kind='scatter', x='total_bill', y='tip', figsize=(6,6))
      ```
      
###### 파이썬의 날짜/시간 다루기
   - datetime 모듈
      - datetime 클래스 - 날짜/시간
      - date: 날짜
      - time: 시간
    - 시간을 문자열로 비교하면 1시 -> 10시 -> 2시 이런식으로 정렬됨(시간순이 x)
    - 
      ``` python
          import datetime #module
          c = datetime.datetime.now() #현재(실행시점)일시를 datetime객체로 반환
          date = datetime.datetime(2000,4,5) #특정 일시
          date2 = datetime.datetime(2010,5,20,15,32,5) #2010년 5월 20일 15시 32분 5초
          date2.year #date2의 년도 반환
          date2.month #date2의 월 반환
          date2.day #date2의 일 반환
          date2.hour
          date2.minute
          date2.second
          date2.weekday # date2의 요일 반환(0:월, 6:일)
          date2.isocalendar() # (년도, 주차, 요일) -> 요일 (월:1 일:7)
          datetime.strftime("format문자열")
          # %Y ,%m, %d, %H, %M, %S, %A(요일문자열로)
      ```
      
###### 판다스에서 datetime 사용
    
   - dt accessor : datetime 타입의 값들을 처리하는 기능
   - 여러개의 datetime 값들을 한 번에 처리해준다
   - 
    ```python
       d = [datetime.datetime.now()] *10
       df = pd.DataFrame({
            'age' : np.random.randint(10,100,10),
            'day' : d })
       # df['day']의 년도를 일괄적으로 반환하고싶을때
       def a(d):
          return d.year
       df['day'].apply(a)
       # dt accessor 를 사용하면
       df['day'].dt.year


