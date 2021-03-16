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
        
###### scatter plot(산점도)
   - DataFrame을 이용해서만 그린다(Series는 x)
