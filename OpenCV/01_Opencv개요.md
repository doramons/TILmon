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

``` python
    #BGR -> RGB
    lenna_rgb = cv2.cvtColor(lenna, cv2.COLOR_BGR2RGB)
    plt.figure(figsize=(10,10))
    plt.imshow(lenna_rgb)
    plt.axis('off')
    plt.show()
```







