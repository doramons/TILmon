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

    - class
        - Bounding Box안의 물체의 class 또는 확률
    - confidence score
        - Bounding Box 안에 실제물체가 있을 것이라고 확신하는 확신의 정도(확률)의 값으로 0.0~1.0 사이의 값
![image](https://user-images.githubusercontent.com/76146752/117920382-bc5a5600-b329-11eb-9ac1-b36beb171d9a.png)

### Object Detection 성능 평가
   #### IoU (Intersection Over Union, Jaccard overlap)
   
   - 모델이 예측한 Bounding Box(bbox)와 Ground Truth Bounding Box가 얼마나 겹치는지를 (Overlap) 나타내는 평가 지표이다
      - 두 개의 Bounding Box가 일치할수록 1에 가까운 값이 나오고 일치하지 않을수록 0에 가까운 값이 계산된다
   - 일반적으로 IoU값 0.5를 기준으로 그 이상이면 검출할 것으로 미만이면 잘못찾은 것(제거)으로 한다
      - 이 기준이 되는 값을 IoU Threshold(임계값) 라고 한다
      - 0.5 수치는 ground truth와 66.% 이상 겹쳐(overlap)돼야 나오는 수치이면 사람의 눈으로 봤을때 잘 찾았다고 느껴지는 수준이다
![image](https://user-images.githubusercontent.com/76146752/117932335-2fb89380-b33b-11eb-9ac2-17c03195d5b3.png)
![image](https://user-images.githubusercontent.com/76146752/117932355-334c1a80-b33b-11eb-91da-b7fd73550981.png)
![image](https://user-images.githubusercontent.com/76146752/117932365-37783800-b33b-11eb-8d8d-67d15da3a43d.png)

#### NMS(Non Max Suppression)
  - Object Detection 알고리즘은 Object가 있을 것이라 예측하는 위치에 여러개의 bounding Box들을 예측한다
  - NMS는 Detect(검출)된 Bounding Box들 중에서 비슷한 위치에 있는 겹치는 bbox들을 제거하고 가장 적합한 bbox를 선택하는 방법이다
![image](https://user-images.githubusercontent.com/76146752/117932560-75755c00-b33b-11eb-9bdf-ec77cc69776f.png)

#### NMS 실행 로직
  1. Detect(검출)된 Bounding Box 중 Confidence threshold (신뢰 임계값)이하의 박스들을 제거한다 (confidence threshold는 하이퍼파라미터)
    > Confidence score: bounding box내에 object(물체)가 있을 확률
  2. 가장 높은 confidence score를 가진 bounding box 순서대로 내림차순 정렬을 한 뒤 높은 confidence score를 가진 bounding box 와 겹치는 다른 bounding box를 모두 조서하여 Iou가 특정 threshold(임계값) 이상인 bounding box들을 모두 제거한다 (ex. IoU threshold >0.5)
    - 가장 높은 confidence score를 가진 bounding box와 IoU가 높게 나온다는 것은 그만큼 겹치는 박스이므로 같은 물체를 예측한 bounding box일 가능성이 높다
    - 이 작업을 남아있는 모든 bounding box에 적용한 뒤 남아있는 박스만 선택한다
![image](https://user-images.githubusercontent.com/76146752/117933203-46131f00-b33c-11eb-9b77-dfaa0de15650.png)

  1. 0.9, 0.85, 0.8, 0.75, 0.75, 0.65 의 confidence score 순으로 정렬
  2. 0.9인 bbox를 기준으로 각 bbox와 IoU를 계산한다
    - 0.8(고양이쪽)와 0.85(강아지쪽)은 IoU가 0이다(일치하는 것이 없다) 그래서 0.85는 유지한다
    - 고양이 쪽의 0.9 bbox와 0.8 bbox의 IoU가 높다( 0.8이다) 그러면 같은 object에 대한 bbox일 확률이 높으므로 0.8은 제거한다
    - 위와 같이 bbox들을 제거해 나가면 confidence 높은 것만 남기고 중복되는 다른 것들은 제거할 수 있다
![image](https://user-images.githubusercontent.com/76146752/117933909-07319900-b33d-11eb-9267-f28278a23712.png)
























