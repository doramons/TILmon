## Image란?
### Image는 width x height x channel 의 pixels로 이루어진 matrix
  
  - width : 너비로 이미지의 가로길이를 의미한다
  - height : 높이로 이미지의 세로길이를 의미한다
  - pixel: image가 가지고 있는 값으로 width x height 개수만큼 존재한다. image를 표현하는 bit방식에 따라 값의 범위가 달라진다
  - 일반적인 image는 unsigned integer 8-bit로 표현
    - 0 ~ 255로 표현
  - bit수가 높아질수록 표현할 수 있는 색의 범위가 증가한다
 ![image](https://user-images.githubusercontent.com/76146752/116854837-496b2400-ac33-11eb-87ba-847ceae65bab.png)


## Open CV 개요
![image](https://user-images.githubusercontent.com/76146752/116854878-58ea6d00-ac33-11eb-84f4-1e7dce9b108d.png)

 - https://opencv.org/
 - 튜토리얼: https://docs.opencv.org/master/
 - Open  Source Computer Vision Library로 실시간 computer vision을 목적으로 개발됨
 - Intel에서 개발하다가 open source화 됨
 - Cross Platform이기 때문에 Windows, Mac, Linux, OS에 상관없이 동작 가능
 - C/C++로 개발되었으나 Python,JAVA,MATLAB의 개발환경도 지원하다
 - 실시간에 초점을 맞추고 나온 Library이기 때문에 mobile camera나 로봇 등 recognition module로 붙여 영상처리에 활용된다

## OpenCV 설치
  - !pip install opencv-contrib-python

## 이미지 일기
  - `imread(filename [,flag]) : ndarray`
    - 이미지를 읽는다
    - filename: 읽어들일 이미지 파일경로
    - flag: 읽기 모드
        - cv2.IMREAD_XXXXX 상수를 이용한다
        - IMREAD_COLOR가 기본(BGR모드)
            - matplotlib에서 출력시 rgb모드로 변환해야 한다


``` python
    import cv2
    import numpy as np
    
    lenna = cv2.imread('./images/lenna.bmp')
    print(type(lenna),lenna.shape)
    
    # 출력
    cv2.imshow('lenna', lenna) # 'window이름' , ndarray(이미지배열)
    cv2.waitKey(0) # 키보드 입력을 기다린다(0: 입력될때까지 기다린다, 양수 = 밀리초)
    cv2.destroyAllWindows() # 모든 창(window)를 종료
```

### matplotlib으로 출력
  - jupyter notebook 내에 출력이 가능
  > - opencv 컬러 이미지: BGR(Blue,Green,Red)
  > - matplotlib : RGB
  > opencv로 불러온 이미지를 matplotlib로 출력하면 R과 B가 바뀌어서 출력됨
  > 

 ``` python
     import matplotlib.pyplot as plt
     plt.figure(figsize=(10,10))
     plt.imshow(lenna[:,:,::-1]) # 마지막 RGB채널의 값을 reverse하여 출력(그대로 출력하면 R과 B가 뒤바뀌어 출력됨)
     
     plt.show()
```
![image](https://user-images.githubusercontent.com/76146752/116859400-eed5c600-ac3a-11eb-9d24-73801c752e0f.png)

### 색공간 변환
  - cv2.cvtColor(src, code)
    - image의 color space를 변환한다
    - src:: 변환시킬 이미지(ndarray)
    - code
        - 변환시킬 색공간 타입지정
        - cv2.COLOR_XXX2YYY형태의 상수 지정(XXX를 YYY로 변환)
            - cv2.COLOR_BGR2GRAY/cv2.COLOR_GRAY2BGR(BGR<->GRAY)
            - cv2.COLOR_BGR2RGB/cv2.COLOR_RGB2BGR(BGR <->RGB)
            - cv2.COLOR_BGR2HSV/cv2.COLOR_HSV2BGR(BGR <->HSV)

   > ### HSV
   >  - Hue: 색상, 색의 종류
   >  - Saturation: 채도, 색의선명도
   >  - Value: 명도, 밝기
   >  
![image](https://user-images.githubusercontent.com/76146752/116889933-155e2600-ac68-11eb-9180-b2f3906d3a75.png)
![image](https://user-images.githubusercontent.com/76146752/116889952-18f1ad00-ac68-11eb-8054-4556e230f1b5.png)


``` python
    #BGR -> RGB
    lenna_rgb = cv2.cvtColor(lenna, cv2.COLOR_BGR2RGB)
    plt.figure(figsize=(10,10))
    plt.imshow(lenna_rgb)
    plt.axis('off')
    plt.show
```
![image](https://user-images.githubusercontent.com/76146752/116890131-3f174d00-ac68-11eb-9f05-7647828c9a25.png)




``` python
    #BGR -> GRAY
    lenna_gray= cv2.cvtColor(lenna, cv2.COLOR_BGR2GRAY)
    plt.figure(figsize=(10,10))
    plt.imshow(lenna_gray, cmap='gray')
    plt.axis('off')
    plt.show()
    
```
![image](https://user-images.githubusercontent.com/76146752/116890275-69690a80-ac68-11eb-8dd1-bbf752341b2d.png)

``` python
    blue = lenna[:,:,0] #BGR이라 0이 blue
    green = lenna[:,:,1]
    red = lenna[:,:,2]
```

### 채널확인
  - 채널별로 나눠 이미지 출력

``` python
    plt.figure(figsize=(20,20))
    plt.subplot(2,2,1)
    plt.title('original', fontsize=20)
    plt.imshow(lenna[:,:,::-1])
    plt.axis('off')
    
    plt.subplot(2,2,2)
    plt.title('blue',fontsize=20)
    plt.imshow(blue, cmap='gray')
    plt.axis('off')
    
    plt.subplot(2,2,3)
    plt.title('green',fontsize=20)
    plt.imshow(green,cmap='gray')
    plt.axis('off')
    
    plt.tight_layout()
    plt.show()
```
![image](https://user-images.githubusercontent.com/76146752/116892152-7d157080-ac6a-11eb-8320-a0632e3995a4.png)

### cv2에서 이미지 출력
  - cv2.imshow(winname, mat)
     - 창을 띄워 이미지를 출력한다
     - winname: 창 이름
        - 창이름이 같으면 같은 창에 띄운다
     - mat : 출력할 이미지(ndarray)
        - dtype이 uint8이어야 정상 출력된다(float일 경우 255를 곱해서 출력한다)
  - cv2.imwrite(filename, img): bool
     - 이미지 파일로 저장
     - filename : 저장할 파일경로
     - img : 저장할 이미지(ndarray)

``` python
    cv2.imshow('img',lenna)
    print(cv2.waitKey(0))
    cv2.imshow('img',lenna_gray)
    print(cv2.waitKey(0)) # 입력된 키의 번호
    cv2.destroyAllWindows()
    
    ord('q'), ord('a') # ord() : 문자를 정수로 변환
    
    # 특정 키를 클릭했을 때 종료
    cv2.imshow('img',lenna)
    while True:
      if cv2.waitKey(0) == ord('q'): # q를 입력할때만 종료
          break
    cv2.destroyAllWindows()
    
    # 파일로 저장
    import os
    if not os.path.isdir('output'):
      os.mkdir('output')
      
    cv2.imwrite('./output/lenna_gray.jpg',lenna_gray) # 있는 디렉토리에 저장해야 한다
```

### 동영상 처리
  #### 동영상 읽기
  
  - VideoCapture 클래스 사용
      - 객체 생성
        - VideoCapture('동영상파일 경로'): 동영상파일
        - VIdeoCapture(웹캠 ID) : 웹캠
  - VideoCapture의 주요 메소드
      - isOpened(): bool
          - 입력대상과 연결되었는지 여부 반환
      - read() : (bool, img)
          - Frame 이미지로 읽기
          - 반환값
              - bool: 읽었는지 여부
              - img : 읽은 이미지(ndarray)

#### 웹캠

``` python
    import cv2
    
    # VideoCapture(정수) : 웹캠 연동
    cap = cv2.VideoCapture(0) # 웹캠이 하나밖에 없으므로 0
    
    # 연동 성공여부
    if cap.isOpened() == False:
      print('웹캠 연결 실패')
      exit(1) # 프로그램 실행 종료, 1: 비정상 종료
      
    while True:
        # 웹캠으로부터 영상이미지(Frame)을 읽기
        ret, img = cap.read() # ret: boolean, img: ndarray -이미지
        
        if not ret: # 이미지 캠쳐 실패
            print('이미지 캡쳐 실패')
            break
            
        # 캡쳐한 이미지를 화면에 출력
        img = cv2.flip(img,-1) # 양수: 수평반전. 0 : 수직반전, 음수: 수평+ 수직반전
        cv2.imshow('Frame', img)
        
        if cv2.waitKey(1) :  == ord('q') :
            break
            
    cap.release() # 웹캠 연결 종료
    cv2.destroyAllWindows() # 출력창을 종료
```

#### 동영상

``` python
    import cv2
    
    # VideoCapture(정수) : 웹캠 연동
    
    cap = cv2. VideoCapture('images/wave.mp4')
    
    # 연동 성공 여부
    if cap.isOpened() == False:
      print('영상과 연결 실패')
      exit(1) # 프로그램 실행 종료1 : 비정상 종료
      
    FPS = cap.get(cv2.CAP_PROP_FPS) # 영상의 fps값을 조회 30: 1초에 30프레임을 출력
    delay_time = int(np.round(1000/FPS)) # 1000 밀리초 (1초)/FPS
    cnt = 0
    while True:
      # 웹캠으로부터 영상이미지(Frame)을 읽기
      ret, img = cap.read() # ret: boolean, img: ndarray-이미지
      if not ret:
        print('이미지 캡쳐 실패')
        break
        
      # 캡처한 이미지를 화면에 출력
      img = cv2.flip(img, 1) # 양수: 좌우반전, 0: 상하반전, 음수: 상하좌우 반전
      cv2.imshow('Frame', img)
      # 파일로 저장
      cv2.imwrite('test/output_{}.jpg'.format(cnt), img)
      
      cnt+=1
      
      if cv2.waitKey(delay_time) == ord('q'): # q를 입력받으면 웹캠 이미지 읽기(capture)종료
      
    cap.release() #웹캠 연결 종료
    cv2.destroyAllWindows() #출력창을 종료
```

#### 동영상 저장
  - capture(read)한 이미지 프레임을 연속적으로 저장하면 동영상 저장이 된다
  - VideoWriter 객체를 이용해 저장
      - `VideoWriter(filename, codec, fps, size)`
          - filename : 저장경로
          - codec
              - VideoWriter_fourcc 이용
              ![image](https://user-images.githubusercontent.com/76146752/116949476-4a489800-acbd-11eb-93a5-fc6396031b18.png)

          - fps
              - FPS(Frame Per Second) -초당 몇 프레임인지 지정
          - size
              - 저장할 frame크기로 원본 동영상이나 웹캠의 width, height 순서로 넣는다
      - VideoWriter().write(img)
          - Frame 저장

``` python
    # 웹캠
    import cv2
    cap = cv2.VideoCapture(0) # 웹캠 연결
    
    if not cap.isOpened():
      print('웹캠 연결 실패')
      exit(1)
    # Frame(이미지) 한장을 캡처 - 웹캠의 width , height 조회
    ret, img = cap.read()
    if not ret:
      print('캡처 실패')
      exit(1)
    
    height, width = img.shape[0], img.shape[1]
    fps = cap.get(cv2.CAP_PROP_FPS)
    delay = int(np.round(1000/fps))
    
    codec = cv2.VideoWriter_fourcc(*"MJPG") # 이렇게 풀려서 들어감 -> ("M","J","P","G")
    
    # VideoWriter 생성
    writer = cv2.VideoWriter('output/webcam_output.avi', codec,fps(width,height))
    
    if not writer.isOpened():
      print('동영상 파일로 출력할 수 없습니다')
      exit(1)
      
    while True:
      ret, img = cap.read()
      if not ret:
         print('캡처 실패')
         break
      img = cv2.flip(img,1)
      writer.write(img)
      cv2.imshow('frame',img)
      
      if cv2.waitKey(1) == ord('q'):
          break
          
    cap.release() # 웹캠 연결 종료
    writer.release() #출력 연결 종료
    cv2.destroyAllWindows() # 출력 화면을 종료
```
    
    
    
    
    
![image](https://user-images.githubusercontent.com/76146752/116947676-53833600-acb8-11eb-9fd1-f3030ff51b67.png)

### VideoCapture 속성
![image](https://user-images.githubusercontent.com/76146752/116947810-a52bc080-acb8-11eb-99ea-4aa7ef50b75e.png)
