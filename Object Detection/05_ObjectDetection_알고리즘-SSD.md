## Object Detection 모델
  - Object Detection = Localization + classification
      - Object Detection은 이미지에 존재하는 object(물체)들을 Bounding Box를 이용해 그 위치를 찾아내고(Localization) class를 분류(CLassification)하는 작업이다
      - Deep learning을 이용한 Object Detection 모델들은 One stage detector와 Two stage detector 두가지 방식이 있다

### One stage vs Two stage detector

  - One stage Detector
      - Localization과 classification을 하나의 네트워크에서 처리한다
  - Two stage Detector
      - Localization과 classification을 처리하는 모델을 따로 만들어서 각각 순차적으로 처리한다
      - 정확도가 높은 대신 속도가 느리다. 느리다는 단점 때문에 Real-Time Detection이 안됨다

![image](https://user-images.githubusercontent.com/76146752/118074829-c04dad00-b3e9-11eb-8191-e8b23473d76c.png)









