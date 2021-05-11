## Object Detection 개요
### 컴퓨터 비전(Computer Vision)
- 인간의 시각과 관련된 부분을 컴퓨터 알고리즘을 이용해 구현하는 방법을 연구하는 분야로 최근에는 딥러닝 알고리즘을 이용한 방식이 주류를 이루고 있다

#### 주요 컴퓨터 비전 분야
  - Image Classification (이미지 분류)
  - Image Segmentation
  - Object Detection (물체검출)
![image](https://user-images.githubusercontent.com/76146752/117837396-65666980-b2b4-11eb-82e9-e009023f4459.png)


- ### Object Detection = Localization + Classification
   - **Object Detection**은 이미지에 존재하는 Object(물체)들을 Bounding Box를 이용해 그 위치를 찾아내고 (Localization) class를 분류(Classification)하는 작업이다
   - Deep learning을 이용한 Object Detection모델들은 localization과 classification을 하나의 네트워크에서 처리하는 One stage detector와 각각의 네트워크에서 순차적으로 실행하는 Two stage detector 두가지 방식이 있다
  
- ### Object Detection의 출력값
    - **Bounding Box(BBox)의 Location(위치)**
        - x,y,w,h를 이용
          - x,y : Bounding Box 중심점의 좌표
          - w,h : Bounding Box의 너비(width)와 높이 (height)
        - x_min, y_min, x_max, y_max를 이용
          - x_min, y_min: 왼쪽 위(Left-Top)의 x,y 좌표
          - x_max, y_max: 오른쪽 아래(right-bottom)의 x,y 좌표
            > - 알고리즘에 따라 실제 좌표를 또는 비율로 반환한다
            >   - x,y,w,h를 전체 이미지의 너비와 높이 대비 비율로 정의한다






