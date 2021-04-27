## GlobalAveragePooling (GAP)

- Feature map의 채널별로 평균값을 추출
- 1x1xchannel의 Feature map 을 생성
- `model.add(keras.layers.GlobalAveragePooling2D())`
![image](https://user-images.githubusercontent.com/76146752/116251731-e9472e80-a7a9-11eb-9225-7ae1f621a4a4.png)

- Feature Extraction layer에서 추출한 Feature map을 Classifier layer로 Flatten해서 전달하면 많은 연결노드와 파라미터가 필요하게 된다. GAP를 사용하면 노트와 파라미터의 개수를 효과적으로 줄일 수 있다.
- Feature map의 채널수가 많을 경우 GAP를 사용하는 것이 효과적이나 채널수가 적다면 Flatten을 사용하는 것이 좋다
![image](https://user-images.githubusercontent.com/76146752/116252362-77231980-a7aa-11eb-861d-1b477c2215ba.png)

``` python
    # 이미지 다운로드
    import gdown
    url = 'https://drive.google.com/uc?id=1nBE3N2cXQGwD8JaD0JZ2LmFD-n3D5hVU'
    fname = 'cats_and_dogs_small.zip'
    gdown.download(url,fname, quiet=False)
    
    !mkdir data
    
    # 압출풀기
    !unzip -q ./cats_and_dogs_small.zip -d data/cats_and_dogs_small
```

![image](https://user-images.githubusercontent.com/76146752/116253343-5e673380-a7ab-11eb-9091-5c7f785353db.png)

## Transfer learning (전이학습)

- 큰 데이터 셋을 이용해 미리 학습된 pre-trained Model의 Weight를 사용하여 현재 하려는 예측 문제에 활용
- ### Convolution base(Feature Extraction 부분)만 활용
    - Convolution base는 이미지에 나타나는 일반적인 특성을 파악하기 위한 부분이므로 재사용할 수 있다
    - Classifier 부분은 학습하려는 데이터셋의 class들에 맞게 변경해야 하므로 재사용할 수 없다
        - ex) 동물 class를 구분하는 모델에 dog/cat 분류 모델을 사용하는 경우 dog/cat 구분하는 weight만 사용하고 분류기는 따로 지정해야함
- pretrained convolution layer의 활용
    - Feature extraction
        - 학습시 학습되지 않고 Feature를 추출하는 역할만 한다
    - Fine tuning
        - 학습시 Pretrained Convolution layer도 같이 학습해서 내 데이터셋에 맞춘다

## Feature extraction

  - 기존의 학습된 network에서 fully connected layer를 제외한 나머지 weight를 고정하고 새로운 목적에 맞는 fully connected layer를 추가하여 추가된 weight만 학습하는 방법
  - `tensorflow.keras.applications` module이 지원하는 image classification models
![image](https://user-images.githubusercontent.com/76146752/116254867-ac306b80-a7ac-11eb-8fcb-0016e6d56fa2.png)

> ## ImageNet
>   - 웹상에서 수집한 약 1500만장의 라벨링된 고해상도 이미지로 약 22000개 카테고리로 구성된다

> ## ILSVRC(ImageNet Large Scale Visual Recognition Challenge)대회
>   - 2010년부터 2017년까지 진행된 컴퓨터 비전 경진대회
>   - ImageNet의 이미지중 **1000개 카테고리 약 120만 장의 학습용 이미지, 5만장의 검증 이미지, 15만장의 테스트 이미지를** 이용해 대회를 진행한다
>   - **2012년** CNN기반 딥러닝 알고리즘인 **Alexnet**이 2위와 큰 차이로 우승하며 이후 딥러닝 알고리즘이 대세가 되었다. 특히 2015년 우승한 ResNet은 0.036의 에러율을 보이며 우승했는데 이는 사람의 에러율이라 알려진 0.05보다 높은 정확도였다. 
>   - ILSVRC에서 우승하거나 좋은 성적을 올린 모델들이 컴퓨터 비전분야 발전에 큰 역할을 해왔으며 이후 다양한 딥러닝 모델의 백본(backbone)으로 사용되고 있다.

![image](https://user-images.githubusercontent.com/76146752/116256531-3d541200-a7ae-11eb-94e9-a0a22534aaf0.png)

## VGG16 모델
  
  - ImageNet ILSVRC challenge 2014에서 2등한 모델로 Simonyan and Zisserman(Oxford Univ.) 에 의해 제안
      - VGGNet이 준우승을 하긴 했지만, 구조의 간결함과 사용의 편의성으로 인해 1등한 GoogleLeNet보다 더 각광받았다
  - 단순한 구조로 지금까지 많이 사용
  - 총 16개 layer로 구성됨
  - 네트워크 깊이가 어떤 영향을 주는지 연구하기 위해 설계된 네트워크로 동일한 kernel size에 convolution의 개수를 늘리는 방식으로 구성됨
      - 11 layer, 13 layer, 16 layer, 19 layer의 네트워크를 테스트함
      - 19 layer의 성능이 16 layer보다 크게 나아지지 않음
  - Filter의 수가 64, 128, 256, 512 두 배씩 커짐
  - 항상 3x3 filter, stride = 1, same padding, 2x2 MaxPooling 사용
      - 이전 AlexNet이 5x5필터를 사용했는데 VGG16은  3x3 필터 두개를 쌓아 사용했다
          - 3x3필터 두개를 쌓는 것이 5x5 하나를 사용하는 것보다 더 적은 파라미터를 사용하며 성능이 더 좋았다
      - Feature map의 사이즈를 convolution layer가 아닌 Max Pooling을 사용해 줄여줌
  - VGG16의 단점은 마지막에 분류를 위해 Fully Connected Layer 3개를 붙여 파라미터 수가 너무 많아졌다. 약 1억4천만 개의 parameter(가중치) 중 1억2천만개정도가 Fully Connected Layer의 파라미터임

![image](https://user-images.githubusercontent.com/76146752/116258187-b0aa5380-a7af-11eb-9a35-8a26a741f477.png)

## ResNet (Residual Networks)

  - 이전 모델들과 비교해 shortcut connection 기법을 이용해 layer수를 획기적으로 늘린 CNN모델로 ILSVRC 2015년 대회에서 우승을 차지함
![image](https://user-images.githubusercontent.com/76146752/116259335-ad639780-a7b0-11eb-9152-80e24351bcfb.png)

  - 레이어를 깊게 쌓으면 성능이 더 좋아지지 않을까? 
      - 실제는 Test 셋 뿐만 아니라 Train set에서도 성능이 나쁘게 나옴
  - Train set에서도 성능이 나쁘게 나온 것은 최적화 문제로 보고, 레이어를 깊게 쌓으면 최적화하기가 어렵다고 생각함

![image](https://user-images.githubusercontent.com/76146752/116259595-e4d24400-a7b0-11eb-9078-9a0edcebe932.png)

## Idea
![image](https://user-images.githubusercontent.com/76146752/116260028-4e525280-a7b1-11eb-9110-ebfff74e36ef.png)
  
  - 입력값을 그대로 출력하는 identity block을 사용하면 성능이 떨어지지 않는다
  - 그럼 Convolution block을 identity block으로 만들면 최소한 성능은 떨어지지 않고 깊은 Layer를 쌓을 수 있지 않을까?

## Solution
  - Residual block

![image](https://user-images.githubusercontent.com/76146752/116260500-b4d77080-a7b1-11eb-94e5-f704366704dc.png)
![image](https://user-images.githubusercontent.com/76146752/116260608-cc165e00-a7b1-11eb-8cb7-0b12aa1b26f0.png)

  - 기존 Layer들의 목표는 입력값인 X를 출력값인 Y로 최적의 매핑할 수 있는 함수 H(X)를 찾는 것이다. 그래서 H(X) -Y가 최소값이 되는 방향으로 학습을 진행하면서 H(X)를 찾음. 그런데 레이어가 깊어지면서 최적화에 어려움으로 성능이 떨어지는 문제가 발생
  - ResNet은 layer를 통과해서 나온 값이 **입력값과 동일하게 만드는 것을 목표로 하는 identity block**을 구성한다
  - Identity block은 입력값 X를 레이어를 통과시켜서 나온 Y에 입력값 X를 더해서 합치도록 구성한다

      - 𝐻(𝑥)=𝐹(𝑥)+𝑥
      - 𝑥:𝑖𝑛𝑝𝑢𝑡,𝐻(𝑥):𝑜𝑢𝑡𝑝𝑢𝑡,𝐹(𝑥):𝑙𝑎𝑦𝑒𝑟통과값
  - 목표 H(x)(레이어 통과한 값)이 input인 x와 동일한 것이므로 F(x)를 0으로 만들기 위해 학습을 한다
  - F(x)는 **잔차(Residual)** 가 된다. 그리고 잔차인 F(x)가 0이 되도록 학습하는 방식이므로 Residual Learning이라고 한다
  - 입력인 x를 직접 전달하는 것을 **shortcut connection** 또는 **identity mapping** 또는 **skip connection**이라고 한다
      - 이 shortcut은 파라미터없이 단순히 값을 더하는 구조이므로 연산량에 크게 영향이 없다
  - 그리고 Residual을 찾는 레이어를 **Residual Block, Identity Block**이라고 한다

## 성능향상
  - H(x) = F(x) + x을 x에 대해 미분하면 최소한 1이므로 Gradient Vanishing 문제를 극복한다
  - 잔차학습이라고 하지만 Residual block은 Convolution Layer와 Activation Layer로 구성되어 있기 때문에 이 Layer를 통과한 Input으로부터 Feature map을 추출하는 과정은 진행되며 레이어가 깊으므로 다양한 더욱 풍부한 특성들을 추출하게 되어 성능이 향상된다.


## ResNet 구조
  - Residual block들을 쌓는 구조
  - 모든 Identity block은 두개의 3x3 convv layer로 구성됨
  - 일정 레이어 수별로 filter의 개수를 두배로 증가시키며 stride를 2로 하여 downsampling 함 (Pooling Layer는 Identity block의 시작과 마지막에만 적용)

![image](https://user-images.githubusercontent.com/76146752/116265136-d6d2f200-a7b5-11eb-985b-8c18e8024595.png)
![image](https://user-images.githubusercontent.com/76146752/116265259-ed794900-a7b5-11eb-9720-88314fa196f2.png)

## Pretrained Model 사용

 - tensorflow.(eras.applications 패키지를 통해 제공
 - 모델이름이 클래스 이름
    - VGG16, ResNet153 등등
 - 생성자 매개변수
    - `weights`: 모형의 학습된 weight. 기본값 - 'imagenet'
    - `include_top`: fully connected layer를 포함할지 여부. True 포함시킴, False: 포함 안시킴
    - `input_shape`: 사용자가 입력할 이미지의 크기 shape. 3D 텐서로 지정 (높이, 너비, 채널). 기본값 (224,224,3)

``` python
    from tensorflow.keras.applications import VGG16, ResNet50V2
    
    conv_base_VGG = VGG16(weights='imagenet', # Imagenet 데이터셋으로 학습된 가중치
                          include_top = False, # classification는 가져오지 않음
                          input_shape = (150,150,3))
                          
    conv_base_ResNet = ResNet50V2(weights = 'imagenet',
                                  include_top = False,
                                  input_shape = (150,150,3))
```

## Feature extraction의 두가지 방법

  1. 빠른 추출방식
      - 예측하려는 새로운 데이터를 위의 `conv_base`에 입력하여 나온 출력값을 numpy 배열로 저장하고 이를 분류 모델의 입력값으로 사용 convolution operation을 하지 않아도 되기 때문에 빠르게 학습. 하지만 data augmentation 방법을 사용할 수 없음
  2. 받아온 특성 Layer를 이용해 새로운 모델 구현하는 방식
      - 위의 `conv_base` 이후에 새로운 layer를 쌓아 확장한 뒤 전체 모델을 다시 학습. 
      - 모든 데이터가 convolution layer들을 통과해야 하기 때문에 학습이 느림
      - 단 conv_base의 가중치는 업데이트 되지 않도록 한다
      - data augmentation 방법을 사용할 수 있음

## 빠른 특성 추출 방식
  
## Pretrained Network를 이용해 새로운 모델 구현하는 방식

  - Conv_base의 feature extractiono부분에 fully connected layer를 추가하여 모형 생성
  - Conv_base에서 가져온 부분은 학습을 하지 않고 weight를 고정
      - **Layer.trainable = Fasle**

``` python
    LEARNING_RATE = 0.001
    N_EPOCHS = 20
    N_BATCHS = 100
    IMAGE_SIZE =150
    
    import tensorflow as tf
    from tensorflow import keras
    from tensorflow.keras import layers
    
    def create_model():
      conv_base = VGG16(weights = 'imagenet', include_top=False, input_shape=(IMAGE_SIZE,IMAGE_SIZE,3))
      
      conv_base.trainable = False # 학습시 weight 최적화를 하지 않도록 설정
      # VGG16 모델의 weight들은 이미 최적화 되어있기 떄문에 역전파 하여 업데이트 될 필요없음
      
      model = keras.Sequential()
      model.add(conv_base)
      
      model.add(layers.GlobalAveragePooling2D())
      model.add(layers.Dense(256,activation='relu'))
      
      # 출력
      model.add(layers.Dense(1, activation='sigmoid'))
      
      return model
      
     model = create_model()
     model.compile(optimizer= keras.optimizers.Adam(learning_rate = LEARNING_RATE, loass = 'binary_crossentropy', metrics=['accuracy'])
     
     train_iterator, validation_iterator, test_iterator = get_generators()
     
     history = model.fit(train_iterator,
                         epochs = N_EPOCHS
                         steps_per_epoch = len(train_iterator),
                         validation_data = validation_iterator,
                         validation_steps = len(validation_iterator))
                         
 ```
      
      
      
      
      
      
      
      
      
