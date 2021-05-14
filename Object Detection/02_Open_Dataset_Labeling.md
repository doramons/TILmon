## Object Detection을 위한 주요 Open Dataset

### Open Dataset이란
  - 2009년 ImageNet 데이터세 이후 다양한 단체들에서 Object Detection, semantic segmentation, pose estimation 등 다양한 컴퓨터 비전 문제에 활용할 수 있는 Image Datset을 제공하고 있다.
  - Computer Vision을 위한 Open Dataset들은 이미지와 그 이미지에 대한 문제영역 관련 Annotation 파일을 제공한다

### Annotation이란
  - 학습시킬 때 필요한 정보를 제공하는 문서(text) 파일
  - 보통 각 이미지파일의 위치, 학습시 필요한 출력정보(y, output) 등을 제공한다
      - 출력 정보: 이미지내의 Object(물체)들을 Bounding Box 위치정보, 
      
      
#### Annotation 예
![image](https://user-images.githubusercontent.com/76146752/117984683-fe5bba00-b372-11eb-943e-9a50bd9e77b6.png)


### PASCAL VOC(Visual Object Classes)
  - http://host.robots.ox.ac.uk/pascal/VOC/
  - 2005년에서 2012년까지 열렸던 VOC Challenges 대회에서 사용한 데이터셋으로 각 대회별 데이터셋을 Opendataset으로 제공한다
      - 이 중 2007년도와 2012년도 이미지가 많이 쓰인다
  - 20개 Class
  - VOC 2007: Train/Validation/Test를 위한 총 9963개 이미지를 제공하고 이미지 내의 22640 물체에 대한 annotate를 제공한다
  - VOC 2012: Train/Validation/Test를 위한 총 11530개 이미지를 제공하고 이미지 내의 27450 물체에 대한 annotate와 6929개의 segmentation 을 제공한다
  - Annotation 파일은 xml 포멧으로 제공

### PASCAL VOC의 class들
 - 4개 그룹의 20개 클래스로 구성돼있다

1. Person: person
2. Animal : bird, cat, cow, dog, horse, sheep
3. Vehicle: aeroplane, bicycle, boat, bus, car, motorbike, train
4. Indoor: bottle, chair, dining table, potted plant, sofa, tv/monitor

### MS-COCO Dataset
  - COCO (Common Objects in Context)
  - https://cocodataset.org/
  - https://arxiv.org/pdf/1405.0312.pdf
  - 연도별로 데이터 셋을 제공한다

### 특징

  - Object Detection, segmentation을 위한 고해상도의 33만장의 이미지와 20만개 이상의 Label을 제공
  - 총 80개의 category의 class들을 제공
      - class 목록:
      - 
      https://gist.github.com/AruniRC/7b3dadd004da04c80198557db
![image](https://user-images.githubusercontent.com/76146752/117987924-e2a5e300-b375-11eb-8cdc-7cacc591eba2.png)

### 그외 Datasets
  - Open Image
    - 구글에서 공개하는 Image Data로 현존 최대 규모 범용 이미지 데이터이다. V5 기준 600개 category에 약 9천만장의 데이터셋을 제공
    - https://storage.googleapis.com/openimages/web/index.html
    - https://github.com/cvdfoundation/open-images-dataset
  - KITTI
    - 차 주행관련 데이터셋을 제공한다
    - http://www.cvlibs.net/datasets/kitti/
  - AIHub
    - 과학기술정보통신부와 한국정보화진흥원(NIA)에 주관하는 곳으로 이미지, 텍스트, 법률, 농업, 영상, 음성 등 다양한 분야의 딥러닝 학습에 필요한 데이터를 수지ㅂ

## 이미지 수집
### google images download 라이브러리
  - 다운받고 싶은 이미지 keyword를 입력하면 구글에서 이미지 검색해서 다운로드 하는 라이브러리
  - CLI (Commnad Line Interface) 환경에서 명령어를 이용해 다운받는 방법과 python 코드로 작성해 다운받는 2가지 방식을 다 지원한다.
  - doc : https://google-images-download.readthedocs.io/en/latest/installation.html
  - github : https://github.com/Joeclinton1/google-images-download

#### 설치
  - `!pip install git+https://github.com/Joeclinton1/google-images-download.git
  - 100개 이상의 이미지를 다운받기 위해서는 chromdriver를 받아서 옵션에 설정한다
      - https://chromedriver.chromium.org/downloads

``` python
    !pip install git+https://github.com/Joeclinton1/google-images-download.git
    
```

#### 명령 프롬프트에서 실행
  - 구문
      googleimagesdownload --옵션 옵션값
      ex) googleimagesdownload --keywords "Polar bears, balons, Beaches" --limit 20 -f jpg
      
  - chrome driver 연동시 `--chromedriver 드라이버경로` 설정
      googleimagesdownload --keywords "Poloar bears, baloons, Beaches" --limit 1000 /chromedir C:\Users\domain\\Downloads\chromedriver_sin32\chromew

 



























