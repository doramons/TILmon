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


