# 순환신경망 (RNN- Recurrent Neural Network)
  Sequence Data(순차데이터) 분석을 위한 모형
  
### Sequence Data(순차데이터)
  - 순서가 의미가 있으며, 순서가 달라질 경우 의미가 바뀌거나 손상되는 데이터를 말한다
![image](https://user-images.githubusercontent.com/76146752/116643440-09464000-a9ac-11eb-832d-aba1591b1ae4.png)

### Sequence data의 예
  
  #### Sequence-to-vector (many to one)
   - Sequence가 들어가면 vector(하나)가 나온다
   - 예) 주가예측 : 4일간의 주가가 들어가면 그다음날 주가가 온다
![image](https://user-images.githubusercontent.com/76146752/116643911-0a2ba180-a9ad-11eb-9b88-51e23fd2c475.png)
   - Input: 4일간의 주가
   - Output: 5일째 주가

![image](https://user-images.githubusercontent.com/76146752/116643971-262f4300-a9ad-11eb-878c-e440cf0ee44e.png)


  #### Sequence-to-sequence(many to many)
   - 예: Machine translation (번역)
 ![image](https://user-images.githubusercontent.com/76146752/116644578-b7eb8000-a9ae-11eb-97a9-bedacf1eb972.png)
   - Input : 영어 문장 전체를 단어 단위로 순차적 입력
   - Output : 번역된 한글 문장을 단어 단위로 순차적 출력
![image](https://user-images.githubusercontent.com/76146752/116644607-ccc81380-a9ae-11eb-9774-03029033ec3c.png)


  #### Vector-to-sequence (one to many)
   - 이미지 하나(Vector)가 들어가면 단어들(문장)이 나온다
   - 예) Image captioning (이미지를 설명하는 문장을 만드는 것): 하나의 그림에 문장(단어들)이 온다
  ![image](https://user-images.githubusercontent.com/76146752/116644685-fd0fb200-a9ae-11eb-8df4-537a933944a2.png)
    
   - Input : 이미지
   - Output : 이미지에 대한 설명을 단어 단위로 순차적으로 출력
  ![image](https://user-images.githubusercontent.com/76146752/116644725-1add1700-a9af-11eb-9240-696e69fa6ccd.png)

## RNN(Recurrent neural networks) 개요

  ### Memory System (기억시스템)
  ![image](https://user-images.githubusercontent.com/76146752/116645484-f1bd8600-a9b0-11eb-8aff-1c2fcd074a2e.png)

  - 4일간의 주가 변화로 5일째 주가를 예측하려면 입력받은 4일간의 주가의 순서를 기억하고 있어야 한다
  - Fully Connected Layer나 Convolution Layer의 출력은 이전 Data에 대한 출력에 영향을 받지 않는다

  ### Simple RNN
  
  ![image](https://user-images.githubusercontent.com/76146752/116648301-a9ee2d00-a9b7-11eb-8918-1714974bd545.png)
  
  - RNN은 내부에 반복(Loop)를 가진 신경망의 한 종류
  - 각 입력 데이터는 순서대로 들어오며 Node/Unit은 **입력데이터(x)와 이전 입력에 대한 출력 데이터(ℎ𝑛−1)** 를 같이 입력받는다
  - 입력 데이터에 weight를 가중합한 값과 이전 입력에 대한 출력 값에 weight를 가중한 값을 더해 activation을 통과한 값이 출력값이 된다 그리고 이 값을 다음 Sequence 데이터 처리에 전달한다


  #### 기본 순환신경망의 문제
  
   - Sequence가 긴 경우 앞 쪽의 기억이 뒤쪽에 영향을 미치지 못해 학습능력이 떨어진다
      - 경사 소실 (Gradient Vanishing)문제로 처음 input값이 점점 잊혀지는 현상 발생
   - ReLU activation, parameter initialization의 조정 등 보다 모형의 구조적으로 해결하려는 시도
      - Long Short Term Memory(LSTM; Hochreiter & Schmidhuber, 1997)
      - Gated Recurrent Unit(GRU; Kyunghyun Cho et al.,2014)

## LSTM (Long Short Term Memory)
  
   - RNN을 개선한 변형 알고리즘
      - 바로 전 time step의 처리결과와 전체 time step의 처리 결과를 같이 받는다
   - 오래 기억할 것은 유지하고 잊어버릴 것은 빨리 잊어버리자
![image](https://user-images.githubusercontent.com/76146752/116651437-2b48be00-a9be-11eb-8b5a-2c4100c9234a.png)
   LSTM의 노드는 RNN의 hidden state에 Cell state를 추가로 출력을 한다
   
   - Cell State
      - 기억을 오래 유지하기 위해 전달하는 값
      - 이전 노드들의 출력값에 현재 입력에 대한 값을 더한다
![image](https://user-images.githubusercontent.com/76146752/116651563-71058680-a9be-11eb-8310-d27fba287054.png)


### LSTM의 구조
  - Forget gate
  - Input gate
  - output gate
![image](https://user-images.githubusercontent.com/76146752/116651623-91354580-a9be-11eb-9992-b07b02525844.png)

#### Forget gate
  - 현재 노드의 입력값을 기준으로 Cell state의 값에서 **얼마나 잊을지** 결정 (얼마나 중요한지 에 따라서)
  ![image](https://user-images.githubusercontent.com/76146752/116651683-ac07ba00-a9be-11eb-85da-5e3e93b18aaf.png)

#### Input gate
  - 현재 노드의 입력값을 Cell state에 추가
  ![image](https://user-images.githubusercontent.com/76146752/116651716-be81f380-a9be-11eb-8053-a4e25461141d.png)

#### Cell State 업데이트
  - forget gate의 결과를 곱하고 input gate의 결과를 더한다
      - 의미: 이전 메모리에 현재 입력으로 대체되는 것을 지우고 현재 입력의 결과를 더한다
  ![image](https://user-images.githubusercontent.com/76146752/116652145-8dee8980-a9bf-11eb-94b7-a5b9444acda6.png)


#### Output gate
  - LSTM에서 output은 hidden state로 다음 Input Data를 처리하는 Cell로 전달된다
  ![image](https://user-images.githubusercontent.com/76146752/116652235-becebe80-a9bf-11eb-9342-9674911ee2a3.png)









