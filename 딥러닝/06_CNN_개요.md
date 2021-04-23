## CNN - 합성곱 신경망(Convolutional Neural Network)
  - 1989년 Yann Lecun이 LeNet 모델을 만들면서 제안한 Deep learning 구조
  - 주로 컴퓨터 비전(이미지, 동영상관련 처리)에서 사용되는 딥러닝 모델로 Convolution 레이어를 이용해 데이터의 특징을 추출하는 전처리 작업을 포함시킨 신경망(Neural Network) 모델
![image](https://user-images.githubusercontent.com/76146752/115798032-42147100-a410-11eb-8616-7bd2b9846e63.png)

### CNN 응용되는 다양한 컴퓨터 비전 영역

1. ### Image Classification(이미지 분류)
  - 입력된 이미지가 어떤 라벨에 대응되는지 이미지에 대한 분류를 처리
 ![image](https://user-images.githubusercontent.com/76146752/115799124-c23bd600-a412-11eb-8691-5e93aea512f2.png)
  - 객체 탐지와 분류를 같이 사용하는 모델들이 나옴
2. ### Object Detection(객체 탐지)
  - 이미지 안의 object(물체)들의 위치정보를 찾아 Bounding Box(사각형 박스)로 표시
  - 하나의 물체를 찾는것은 Localization, 2개 이상은 Object Detection

![image](https://user-images.githubusercontent.com/76146752/115799237-ff07cd00-a412-11eb-99fe-c185c44b5282.png)
 - 열체크하거나 침입탐지 등 영상처리에서도 많이사용함 (YOLO)
3. ### Image Segmentation
  - 이미지의 전체 픽셀에 대해 분류한다
![image](https://user-images.githubusercontent.com/76146752/115799325-37a7a680-a413-11eb-96a2-7dadc3cf7ceb.png)

#### Classification, Localization, Object Detection, Segmentation 차이
![image](https://user-images.githubusercontent.com/76146752/115799363-4d1cd080-a413-11eb-9324-e1ef38c7be94.png)

4. ### Image Captioning
  - 이미지에 대한 설명문을 자동으로 생성

![image](https://user-images.githubusercontent.com/76146752/115799465-835a5000-a413-11eb-8df0-976148659fc5.png)

5. ### Super Resolution
  - 저해상도의 이미지를 고해상도의 이미지로 변환
 ![image](https://user-images.githubusercontent.com/76146752/115799496-92d99900-a413-11eb-9534-35f4a81f1153.png)
  - 옛날 사진 복구 /몽타주 그리거나할때 많이 쓰일 것 같음
6. ### Neural Style Transfer
  - 입력이미지와 스타일 이미지를 합쳐서 합성된 새로운 이미지 생성
  - 이미지 스타일 변경해주는것
  - ex) 사진을 피카소 그림스타일로 변경 등

![image](https://user-images.githubusercontent.com/76146752/115799584-cae0dc00-a413-11eb-847e-2bfda6234e9a.png)
  - 사진 필터 입히거나 보정할 때 사용되지 않을까( 사진 예술 하거나 등등)
7. Text Detection & OCR
  - Text Detection : 이미지 내의 텍스트 영역을 Bounding Box로 찾아 표시
  - OCR : Text Detection이 처리된 Bounding Box 안의 글자들이 어떤 글자인지 찾는다

![image](https://user-images.githubusercontent.com/76146752/115803984-fa481680-a41c-11eb-933d-4b38e3745e2b.png)
  - 파파고 사진인식 번역이나 폰트 찾기 등에 사용될듯
8. Human Pose Estimation
  - 인간의 주요 신체부위를  keypoint라는 점으로 추정해 연결하여 현재 포즈를 예측한다
![image](https://user-images.githubusercontent.com/76146752/115804135-51e68200-a41d-11eb-9580-47818e25dccc.png)
  - 닌텐도 위 같은 게임에 쓰이지 않을까 (동작인식)

### 이미지 인식( Image Recognition)이 어려운 이유
  - ### 사람과 컴퓨터가 보는 이미지의 차이
    - 컴퓨터가 보는 이미지는 0~255 사이의 숫자로 이뤄진 행렬임
    - 그 숫자들로 사진을 인식한다...? 쉽지 않음

![image](https://user-images.githubusercontent.com/76146752/115804228-88240180-a41d-11eb-975a-8977202eaf2e.png)

### 1. 배경과 대상이 비슷해서 구별이 안되는 겨우
  -  명암이나 배경에 의해 경계가 구별이 안되는 경우
![image](https://user-images.githubusercontent.com/76146752/115819963-deec0400-a43a-11eb-80f0-a050c9860976.png)

### 2. 같은 종류의 대상도 형태가 너무 많다.
  - 같은 고양이 인데도 다양한 크기, 동작을 하고 있음

![image](https://user-images.githubusercontent.com/76146752/115820022-fcb96900-a43a-11eb-82c5-5b1ef5d01438.png)

### 3. 대상이 가려져 있는경우
![image](https://user-images.githubusercontent.com/76146752/115820041-06db6780-a43b-11eb-9062-da88281a79f3.png)

### 4. 같은 class에 다양한 형태가 있다

![image](https://user-images.githubusercontent.com/76146752/115820087-1b1f6480-a43b-11eb-9765-dc1f07808fb9.png)

## 기존 이미지 처리 방식과 딥러닝의 차이

### Handcrafted Feature ( 기존 이미지 처리 방식)
  - 분류하려고 하는 이미지의 특징들을 사람이 직접 찾아서 만든다 (Feature Extraction)
      - 그 찾아낸 특징들을 기반으로 학습시킨다
  - 미처 발견하지 못한 특징을 가진 이미지에 대해서는 분류를 하지 못하기 때문에 성능이 떨어진다

### End to End Learning
  - 이미지 특징 추출부터 분류까지 인간이 개입하지 않고 자동으로 학습시킨다
![image](https://user-images.githubusercontent.com/76146752/115827379-2c6e6e00-a447-11eb-86e7-aa9d29069d2c.png)

## CNN 구성
  - 이미지로부터 부분적 특성을 추출하는 **Feature Extraction** 부분과 분류를 위한 **Classfication 부분**으로 나눈다
  - **Feature Extraction 부분에 이미지 특징 추출에 성능이 좋은 Convolution Layer를 사용한다**
      - Feature Extraction : Convolution Layer
      - Classification : Dense Layer (Fully connected layer)

    ![image](https://user-images.githubusercontent.com/76146752/115864830-6bfe7f80-a472-11eb-944e-f4e6d5a61c40.png)
    
## Dense Layer를 이용한 이미지 처리의 문제점

  - 이미지를 input으로 사용하면 dimension(차원)이 매우 큼
  - 64\*64 픽셀의 이미지의 경우
      - 흑백은 Unit(노드)당 64 \* 64 = 4096 개 학습 파라미터 ( 가중치 - weight)
      - 컬러는 Unit(노드) 당 64\* 64 \* 3 (RGB 3가지)  = 12288 학습 파라미터 ( 가중치-weight )
      
  - Hidden unit의 수에 따라 wieght의 수가 지나치게 커지기 때문에 메모리 부족과 많은 계산 필요
  - Fully connected layer(dense layer) 만을 사용한다면 이미지의 공간적 구조학습이 어려움



## 합성곱 연산 이란
 - Convolution Layer는 이미지와 필터간의 **합성곱 연산**을 통해 이미지의 특징을 추출해낸다
![image](https://user-images.githubusercontent.com/76146752/115865405-3908bb80-a473-11eb-809c-a53c2b54014f.png)
![image](https://user-images.githubusercontent.com/76146752/115865412-3c9c4280-a473-11eb-81ca-3e7f012e6389.png)

##  이미지와 합성곱
  
  - 필터(커널) : 이미지에서 특성(패턴)을 추출
  
  - 대상 이미지
 ![image](https://user-images.githubusercontent.com/76146752/115865563-740aef00-a473-11eb-8474-04eb8b3d3188.png)

  - 필터(커널)
![image](https://user-images.githubusercontent.com/76146752/115865585-7d945700-a473-11eb-8dc9-6c07165cd32f.png)

![image](https://user-images.githubusercontent.com/76146752/115865664-9a308f00-a473-11eb-8edc-a8f31565d7d0.png)

![image](https://user-images.githubusercontent.com/76146752/115865674-9e5cac80-a473-11eb-9de4-260bc0895be6.png)
필터와 이미지의 노란 박스 부분을 합성곱하면 6600이 나온다

![image](https://user-images.githubusercontent.com/76146752/115865703-a9174180-a473-11eb-93eb-17d068152e66.png)
필터와 이미지의 노란박스부분을 합성곱하면 0이 나온다

## **필터와 부분 이미지의 합성곱 결과가 값이 나온다는 것은 그 부분 이미지에 필터가 표현하는 이미지 특성이 존재한다는 것이다**
![image](https://user-images.githubusercontent.com/76146752/115866286-6bff7f00-a474-11eb-888a-dff67fb1ffcd.png)


#### 검증된 필터 적용의 예

![image](https://user-images.githubusercontent.com/76146752/115866334-7c175e80-a474-11eb-90a9-dadc8908e22e.png)

![image](https://user-images.githubusercontent.com/76146752/115866345-820d3f80-a474-11eb-8b9b-a6733d6dcdc0.png)

  - Sobel 필터
  - X-Direction Kernel : 이미지에서 수평 윤곽선 (edge)를 찾는다
  - Y-Direction Kernel : 이미지에서 수직 윤곽선 (edge)를 찾는다
  - 합성곱은 내적으로 연산이 되기 때문에 세로 모양의 필터(X-Direction)가 수직방향의 특징을 찾음

![image](https://user-images.githubusercontent.com/76146752/115866859-4626aa00-a475-11eb-8f96-41d973bf1376.png)
왼쪽 : Y 적용 , 오른쪽 : X 적용

![image](https://user-images.githubusercontent.com/76146752/115867124-a3baf680-a475-11eb-96a2-9352a4c04784.png)
 - 둘을 합치면 위와 같이 원본 이미지의 특징 중 윤곽선을 추출할 수 있다

## CNN에서 Filter

  - CNN의 Layer 는 이런 Filter(Kernel)들로 구성되어 있다
  - CNN은 주어진 Filter(Kernel)를 사용하는 것이 아니라 Filter(kernel)의 값을 가중치(파라미터)로 데이터를 학습해서 찾아낸다
  - 한 Layer를 구성하는 Filter들은 Input 이미지에서 각각 다른 패턴들을 찾아낸다

### CNN도 레이어를 쌓는다
  - 첫번째 레이어는 부분적 특징을 찾는다
  - 다음 단계에서는 이전 레이어에서 찾아낸 부분적 특징들을 합쳐 점점 추상적 개념을 잡아낸다

![image](https://user-images.githubusercontent.com/76146752/115868762-e7aefb00-a477-11eb-8e86-6ab757b1ede0.png)

### Convolutional operation의 작동방식

  - hyper parameter 정의
      - Filter의 크기 : 보통 홀수 크기로 잡는다 (3 * 3, 5 * 5), 주로 3 * 3을 많이 사용함
          - 필터의 채널은 input image의 채널과 동일함
      - Filter의 수 : 필터의 개수 Feature map output의 깊이가 된다
  - 흑백 이미지는 하나의 행렬로 구성
  - 컬러 이미지는 RGB의 각 이미지로 구성되어 3개의 행렬로 구성

![image](https://user-images.githubusercontent.com/76146752/115868902-162cd600-a478-11eb-98d3-2e025bb6fb5c.png)

  - ### 예
    - Input image는 6x6x3 형태 (높이, 너비, 채널)
    - Filter : 3x3x3크기의 필터 1개 (높이, 너비, 채널)
    - Output : 4x4 feature map 1개 생성
![image](https://user-images.githubusercontent.com/76146752/115870451-3c537580-a47a-11eb-8ceb-3d3e3baa59ae.png)

  - ### 예
    - Input image는 6x6x3 형태의 volume
    - Filter : 3x3x3크기의 필터 2개 
    - Output : 4x4 feature map 2개 생성

![image](https://user-images.githubusercontent.com/76146752/115870600-6b69e700-a47a-11eb-8b65-73c91ef328b5.png)


### Padding
  - 이미지 가장자리의 픽셀은 convolution 계산에 상대적으로 적게 반영
  - 이미지 가장자리를 0으로 둘러싸서 가장자리 픽셀에 대한 반영횟수를 늘림
    - 'valid' padding
        - padding 을 적용하지 않음
        - Output(Feature map)의 크기가 줄어든다
    - 'same' padding
        - Input과 Output의 이미지 크기가 동일하게 되도록 padding 수를 결정
        - **보통 same 패딩을 사용한다**
        - Output의 크기는 Pooling Layer를 이용해 줄인다

![image](https://user-images.githubusercontent.com/76146752/115870921-dddac700-a47a-11eb-8b08-1835e3fd6edc.png)


### Strides

  - Filter(kernel)가 한 번 Convolution 연산을 수행한 후 옆 혹은 아래로 얼마나 이동할 것인가
  - stride = 2 : 한 번에 두칸씩 이동 (feature map의 너비와 높이가 2배수로 다운 샘플링 되었음을 의미)
  - 보통 stride는 1을 지정한다
![image](https://user-images.githubusercontent.com/76146752/115872634-fea41c00-a47c-11eb-8314-e8441ac632d7.png)


### Max Pooling Layer(최대풀링)

  - 해당 영역의 input 중 가장 큰 값을 출력
  - 일반적으로 2 * 2크기에 stride는 2를 사용함 (겹치지 않게함)
  - 강제적인 subsampling 효과 (추출한 특징중 도드라지는 특징만 추출)
      - weight 수를 줄여 계산속도를 높임
      - 특징의 공간적 계층구조를 학습한다 => 부분적 특징을 묶어 전체적인 특징의 정보를 표현하게 된다
  - 학습할 weight가 없음: 일반적으로 convolutional layer + pooling layer를 하나의 레이어로 취급

![image](https://user-images.githubusercontent.com/76146752/115873195-9efa4080-a47d-11eb-825c-a43c409b6b92.png)


Max pooling layer(2x2 pooling kernel, stride 2, no padding)

#### 참고
  
  - W : input 이미지의 width 
  - H : input 이미지의 height
  - F : filter size
  - S : strides
  - P : the number of zero-paddings
    
    - output width = (𝑊−𝐹+2𝑃) / 𝑆 + 1
    - output height = (𝐻−𝐹+2𝑃) / 𝑆 + 1

  - ex) input : 32 x 32 x 3 , 5 x 5 filter 10개, 1 stride, 0 pad => (28x28x10)
  - ex) input : 32 x 32 x 3 , 3 x 3 filter 10ro, 1 stride, 1 pad => (16x16x10)

### Fully-connected layer

  - Feature Extraction layer들을 거처 나온 output에 대해 분류는 fully-connected layer 에서 처리한다
  - output을 flatten 한 뒤에 처리한다

![image](https://user-images.githubusercontent.com/76146752/115874225-d0bfd700-a47e-11eb-8f80-9a1d6c575bbe.png)

### Example of CNN architecture

![image](https://user-images.githubusercontent.com/76146752/115874328-ef25d280-a47e-11eb-966c-c7774e043d1c.png)
![image](https://user-images.githubusercontent.com/76146752/115874383-01077580-a47f-11eb-8af2-b52c0c3f12e7.png)
 
 - 일반적으로 convolutional layer (+ReLU or other activations) + pooling layer를 여러ㅓ 개 쌓음
 - convolution layer가 진행될수록 **feature map의 크기는 줄어들고 깊이(개수)는 증가**
 - 마지막에 Fully connected layer( + ReLU or other activations) 추가하여 분류를 처리한다
 - Output 형태에 맞는 output layer
    - 이진분류 or 다중 클래스 분류

### Keras CNN 구조

  - Input shape : (image_height, image_width, image_channels)
      - 이미지 데이터는 보통 3차원으로 입력
          - image_channels (컬러: 3, 흑백: 1)
  - Convolution 레이어 : tensorflow.keras.layers.Conv2D(filters, kernel_size, strides=(1,1), padding = 'valid', activation=None)
      - `filters` : 필터의 개수 ( 필터의 개수만큼 특징 맵이 나와서 출력됨)
      - `kernel_size` : height and width of the 2D convolution window - 필터의 크기(가장 많이 쓰이는게 3x3 => 3)
      - `strides` : the strides of the convolution along the height and width
      - `padding` : 'valid' or 'same' (default: valid)
          - valid : padding 안줌
          - same : Input layer크기가 그대로 나오도록 패딩 연산함
      - activation : 활성함수
  - MaxPooling 레이어: tensorflow.keras.layers.MaxPooling2D(pool_size=(2,2), strides = None, padding = 'valid')
      - `pool_size` : Pooling window size
      - `strides` : default = `pool_size`
      - `padding` : 'valid' or 'same'
          - maxpooling의 경우 크기가 달라지지 때문에 padding은 same보다 valid를 쓰는 경우가 많음
  - tensorflow.keras.layers.Flatten()
      - Flattens the input
      - Fully connected layer를 적용하기 위함


