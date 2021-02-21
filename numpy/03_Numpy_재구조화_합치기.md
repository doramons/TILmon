####배열의 형태(shape) 변경

    #####reshape()을 이용한 차원 변경
      - numpy.reshape(a, newshape) 또는 ndarray.reshape(newshape)
          - a: 형태를 변경할 배열
      - newshape : 변경할 형태 설정
          - 원소의 개수를 유지하는 shape으로만 변환 가능(size는 바뀔수 x)
            ex) (4,5) => (2,2,5)
        - 원본 배열을 변경하지 않는다 (shape를 바꾼 새로운 배열(카피본)을 반환)
        - newshape을 지정할 때 특정 축에 -1을 주면 원소수에 맞춰서 size를 정한다.(전체 축 중에 하나만 사용 가능)
          ** size가 20인 배열 a.reshape(2,2,-1) => shape 은 (2,2,5) 인 배열이됨
          
          
          
####차원 늘리기 (확장)

    ##### numpy.newaxis 속성을 이용해 차원 늘리기
        
        -  size가 1인 축(axis)를 늘릴 때 사용한다
            - 지정한 axis에 size 1인 축을 추가한다
            ex) a = np.arange(1,6) => shape이 (5,)인 배열
                x = a[np.newaxis, :] => x에 배열a를 shape (1,5)로 변환한 배열 반환
                
                a = np.arange(1,6) => shape이 (5,)인 배열
                x = a[:, np.newaxis] => x에 배열a를 shape (5,1)로 변환한 배열 반환
                
        - slicing에 사용하거나 indexing에  ...과 같이 사용한다
            - slicing의 경우 원하는 위치의 축을 늘릴 수 있다
            - index에 ...과 사용하는 경우 첫번째나 마지막 축을 늘릴 때 사용한다
            
        - indexing에 ... 과 같이 사용
            - ndarray[..., np.newaxis]
            - 첫번째 축이나 마지막 축을 늘릴 때만 사용가능
              ex) b : (4,5) -> b2: (1,4,5) => 0축 늘리기
                  b2 = b[np.newaxis, ...]
                  b2.shape
                  b3 = b[...,np.newaxis]
                  b3.shape
                  
             - numpy.expand_dims(배열,axis)
                -  매개변수로 받은 배열에 지정한 axis의 rank를 확장한다
                 ex) a => shape (5,) 인 배열
                     a1 = np.expand_dims(a, axis=1) => 1번축 확장 (5,1)
                     a2 = np.expand_dims(a, axis=0) => 0번축 확장 (1,5)
                     
                     
####차원 줄이기(축소)
  - numpy.squeeze(배열, axis=None), 배열객체.squeeze(axis=None)
      - 배열에서 지정한 축(axis)을 제거하여 차원(rank)를 줄인다
      - 제거하려는 축의 size는 1이어야 한다(size가 1이 아닌 축은 제거되지 않는다)
      - 축을 지정하지 않으면 size가 1인 모든 축을 제거한다
          (3,1,1,2) => (3,2)
          
          
          
####배열객체.flatten()
  - 다차원 배열을 1차원으로 만든다
   ex) (2,3) -> (6,)
       (2,2,2,3,)-> (24,)
       
       
####numpy.append(), numpy.insert(),numpy.delete()
    
    -append(배열,추가할값, axis=None)
      - 배열의 마지막 index에 추가할 값을 추가
      - axis : 축 지정
        - None(기본값) : flatten한 뒤 추가한다
        
    -insert(배열, index, 추가할 값, axis = None)
       - 배열의 index에 추가할 값을 추가
       - axis : 축 지정
          -None(기본값) :flatten 한 뒤 삽입한다
          
     -delete(배열, 삭제할index, axis = None)
        - 배열의 삭제할 index값들을 삭제한다
        - 삭제할 index는 index 또는 slice
        - axis : 축 지정
            - None(기본값) : flatten 한 뒤 삭제
            
####배열 합치기
  
    - np.concatenate(합칠 배열리스트, axis = 0)
      - 여러 배열을 축의 개수(rank)를 유지하며 합친다
      - axis 파라미터 : 축지정
          - 지정된 축을 기준으로 합친다
          - default : 0
      - 합치는 배열의 축의 개수(rank)은 같아야 한다
      - axis속성으로 지정한 축 이외의 축의 크기가 같아야한다
      - 결과의 축의개수(rank)는 대상 배열의 rank와 같다
          - 1차원끼리 합치면 1차원결과가 나옴
          
    - 합칠대상 배열의 rank가 2일 경우(행렬)
        -vstack()
        -hstack()
        -np.concatenate()의 간단버전
        
     - vstack(합친배열리스트)
        - 수직으로 쌓는다
        - concatenate() 의 axis=0와 동일
        - 합칠 배열들의 열수가 같아야 한다
        
     - hstack(합친배열리스트)
        - 수평으로 쌓는다
        - concatenate()의 axis = 1와 동일
        - 합칠 배열들의 행 수가 같아야 한다
        
####배열 분할하기

      - split(배열, 분할기준, axis)
          - 지정한 축을 기준으로 배열을 나눈다
          - 반환값: 분할한 narray를 가진 리스트로 리턴
          - 배열: 분할할 배열
          - 분할기준
              - 정수 : 지정개수만큼 분할
              - 2D의 경우 axis=0: 행기준 분할, axis=1: 열 기준 분할
              
         ex) np.split(a,3) #3개로 분할 , 분할된 배열의 크기가 동일해야한다 ,axis 기본값은0, 3으로 나눠지지 않으면 error)
             np.split(a,[2,6]) -> index 2,6을 기준으로 3분할됨 ([0,1],[2,3,4,5],[6,7,8,9])
       - vsplit(배열, 분할기준)
          - 행 기준 분할
          - split()의 axis=0과 동일
          - 분할기준
              - 정수: 지정 개수만큼 분할
              - 리스트 : 분할 기준 index들
              
           
              
        - hsplit(배열, 분할기준)
           - 열 기준 분할
           - split()의 axis=1과 동일
           - 분할기준
              - 정수: 지정개수만큼 분할
              - 리스트: 분할 기준 index들
              
        ** 주의: 분할기준을 정수(개수)로 할 경우 분할 후 원소수가 같아야한다
        
















####배열 합치기
  
  - np.concatenate(합칠 배열리스트, axis = 0)
      - 여러 배열을 축의 개수(rank)를 유지하며 합친다
      - axis 파라미터 : 축지정
          - 지정된 축을 기준으로 합친다
          - default : 0
      - 합치는 배열의 축의 개수(rank)은 같아야 한다
      - axis속성으로 지정한 축 이외의 축의 크기가 같아야한다
      - 결과의 축의개수(rank)는 대상 배열의 rank와 같다
          - 1차원끼리 합치면 1차원결과가 나옴
          
  - 합칠 대상 배열의 rank가 2일 경우(행렬)
  
      - vstack()
      - hstack()
      - np.concatenate()의 간단 버전
      
     
     
     
####배열 분할 하기
  
  - split(배열, 분할기준, axis)
      - 지정한 축을 기준으로 배열을 나눈다
      - 반환값: 분할한 narray를 가진 리스트로 리턴
      - 배열: 분할할 배열
      - 분할기준
          - 정수 : 지정개수만큼 분할
          - 리스트 : 분할 기준 index들
      - axis(축)
          - 분할할 기준 축을 지정한다 axis = 0 (기본)
          - 2D의 경우 axis=0: 행 기준 분할, axis=1: 열 기준 분할
          
   - vsplit(배열, 분할기준)
       - 행 기준 분할
       - split()의 axis=0과 동일
       - 분할기준
            - 정수 : 지정 개수만큼 분할
            - 리스트 : 분할 기준 index들
            
   - hsplit(배열, 분할기준)
        - 열 기준 분할
        - split()의 axis =1과 동일
        - 분할 기준
            - 정수: 지정개수만큼 분할
            - 리스트: 분할 기준index들
       - **주의** : 분할기준을 정수(개수)로 할 경우 분할 후 원소수가 같아야 한다
       
   - 
            
      
      
          
