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

#### mAP (mean Average Precision)
  - 여러개의 실제 Object가 검출된 재현율(Recall)의 변화에 따른 정밀도(Precision) 값을 평균화 한 것
  - mAP를 이해하기 위해선 precision, recall, precision-recall, curve, AP(Average Precision)을 이해해야 한다
    > precision-recall curve, AP(Average Precision)는 Object Detection(물체 검출) 알고리즘 성능 평가를 위해 사용되는 방법 중 하나이다
    > 

##### Precision(정밀도)와 Recall(재현율)
  - 정밀도는 Positive로 예측한 것 중 실제 Positive인 것의 비율 (Positive로 예측한 것이 얼마나 맞았는 지의 수치)
      - Object Detection에서는 Detect(검출) 예측결과가 실제 Object(물체)들과 얼마나 일치하는지를 나타내는 지표
  - 재현율은 실제 Positive인 것중 Positive로 예측한 것의 비율 (Positive인 것을 얼마나 맞았는지의 수치)
      - Object Detection에서는 실제 Object(물체)들을 얼마나 잘 Detect(검출) 했는지를 나타내는 지표
  
![image](https://user-images.githubusercontent.com/76146752/117943526-31885400-b347-11eb-91b7-a7623e198230.png)
 위 그림을 보면 두마리 중 새 한마리만 Detect 했다
 
 - 1개를 예측해서 1개 맞았으므로 Precision은 100%(1.0)가 된다
 - 새는 두 마리인데 하나만 Detect(검출) 했으므로 Recall은 50%(0.5)가 된다


##### Counfusion Matrix와 Object Detection

![image](https://user-images.githubusercontent.com/76146752/117943682-5c72a800-b347-11eb-9f1a-01b42c306354.png)

Object Detection에서 TP, FP, FN

![image](https://user-images.githubusercontent.com/76146752/117943799-79a77680-b347-11eb-9e5e-fd05a880d6fe.png)
    red box : Groundt truth, yellow box: prediction
    
    
#### Precision과 recall의 tradeoff(반비례관계)

> Confidence threshold: 지정된 값 이상의 confidence를 가진 결과만 예측결과로 사용하고 그 이하인 것들은 무시한다. 이 값을 0.5로 설정하면 confidence scroe가 0.5 미만인 결과(0.1,0.2,0.3 등)는 무시한다. 이 값은 하이퍼파라미터임
> 

- ### Confidence threshold를 높게 잡은 경우
    - 확신의 정도가 아주 높은 경우만 검출하기 때문에 예측한 것이 얼마나 맞았는지에 대한 지표인 **Precision지표는 높게 나온다**
    - 확신의 정도가 낮으면 detect하지 않으면 실제 문체를 얼만큼 검출했는지에 대한 **recall 지표는 낮게 나온다**

- ### Confidence threshold를 낮게 잡은 경우
    - 확신의 정도가 낮은 것들을 예측했으므로 잘못 검출한 결과가 많아지므로 Precision지표는 낮게 나온다
    - 낮은 확신의 정도인 것들도 검출하기 때문에 실제 물체를 더 많이 검출하게 되어 recall 지표가 올라간다

### 정리
  - confidence threshold를 낮게 잡으면 precision은 낮게, recall은 높게 나온다
    - recall이 올라가면 precision은 낮아진다
  - confidence threshold를 높게 잡으면 precision은 높게 recall은 낮게 나온다
    - precision이 올라가면 recall은 낮아진다

  - Precision과 Recall은 이렇게 반비례 관계를 가지기 때문에 Precision과 Recall의 성능 변화 전체를 확인해야한다. 그러한 대표적인 방법이 precision-recall curve 그래프를 이용하는 것이다

![image](https://user-images.githubusercontent.com/76146752/117966662-217c6e80-b35f-11eb-8f84-5a07e49c6788.png)


### Precision-Recall curve
 - confidence threshold의 변화에 따라 recall과 precision의 값이 변하게 된다. 이것을 **recall이 변화할 때 precision이 어떻게 변하는지를** 선그래프로 나타낸 것을 Precision-Recall curve 라고 한다
 - Object Detection 알고리즘의 성능을 평가하는 방법으로 많이 사용된다
![image](https://user-images.githubusercontent.com/76146752/117967734-5fc65d80-b360-11eb-899a-7919945becbb.png)

#### Average Precision (AP)
  - precision-recall curve 그래프는 알고리즘의 성능을 전반적으로 파악하기에는 좋으나 서로 다른 알고리즘들의 성능을 정량적으로 비교하기에는 불편하다
  - 그래서 precision-recall curve 그래프를 하나의 scalar값으로 나타낸 것이 Average precision(AP) 값이다
  - Average precision은 precision-recall curve 그래프의 선 아래 면적을 계산한 값이다 Average precision이 높을수록 그 알고리즘의 성능이 전체적으로 우수하다는 의미임
  - 대부분 Object Detection 알고리즘의 성능은 대부분 Average precision으로 평가한다
  - Average Precision 계산은 아래 그림과 같이 Precision-recall curve의 선을 단조적으로 감소하는 그래프로 바꾼 뒤 면적을 계산한다
![image](https://user-images.githubusercontent.com/76146752/117980606-19c4c600-b36f-11eb-85da-543fc647a731.png)

#### mAP(mean Average Precision)
  - 검출해야하는 object가 여러개인 경우 각 클래스당 AP를 구한 다음 그것을 모두 합해 클래스 개수로 나눈 값을 mAP라고 한다
      - 클래스들의 AP 평균
  - 대부분의 알고리즘은 mAP를 이용해 Detection 성능을 평가한다

### 논문의 평가지표 예

![image](https://user-images.githubusercontent.com/76146752/117980951-70ca9b00-b36f-11eb-8c0a-9f8d8ac6e955.png)

![image](https://user-images.githubusercontent.com/76146752/117980955-732cf500-b36f-11eb-956e-b6fc472e8e39.png)

![image](https://user-images.githubusercontent.com/76146752/117981003-82ac3e00-b36f-11eb-9db5-9765eb95a915.png)



