#### Database 연동모듈
  - sqlite3 : 파이썬에 내장되어 있어 바로 연동할 수 있다
  - cx_Oracle : 오라클 연동 모듈
      - pip install cx_Oracle로 설치
  - PyMySQL : MySql 연동 모듈
      - pip install PyMySQL 로 설치
     
##### cx_Oracle을 이용한 SQL 전송
   - connection : DB 연결정보를 가진 객체
      - connection() 함수를 이용해 연결
   - cursor
      - SQL문 실행을 위한 메소드 제공
      - connection.cursor() 함수를 이용해 조회

##### 연결
   - username, password, host
   ex) conn = cx_Oracle.connect('c##scott','tiger','localhost:1521/XE')
   
##### cursor 생성
   - cursor = conn.cursor()

##### sql 실행
   ex) cursor.execute('select * from emp')
      result = cursor.fetchall()
      
##### 연결 끊기
   - cursor.close
   - conn.close()

#### 판다스 오라클 연동
   - pd.read_sql('select문', con=connection)
   ex) conn = cx_Oracle.connect('c##scott/tiger@localhost:1521/XE')
       emp_df = pd.read_sql('select * from emp',con= conn, index_col = 'EMP_ID')
