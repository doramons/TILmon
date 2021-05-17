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
      googleimagesdownload --keywords "Poloar bears, baloons, Beaches" --limit 1000 /chromedir C:\Users\domain\\Downloads\chromedriver_win32\chromedriver.exe
      
  - 옵션 : https://google-images-downlaod.readthedocs.io./en/latest/arguments.html


#### 설정파일

``` python
    %%writefile config.json
    {
        "Records":[
            {
                "keywords":"사과",
                "limits":5,
                "color-type":"full-color",
                "print_url":true,
                "print_size":true
             },
             {  
                "keywords":"수박",
                "limit":10,
                "color-type":"full-color",
                "print_url":true,
                "print_size":true
             },
             {
                 "keywords":"복숭아",
                 "limit":10,
                 "color-type":"full-color",
                 "print_url":true,
                 "print_size":true,
                 "chromedriver":"c:\\tools\\chormedriver.exe"
              }
          ]
     }
     
     !googleimagesdownload --config_file config.json
     
```

### 파이썬 코드로 다운로드

``` python
    pip install git+https://github.com/Joeclinton1/google-images-download.git
    
    from google_images_download import google_iamges_downlaod
    
    response = google_images_download.googleimagesdownload()
    
    args = {
        "keywords":"tiger,lion",
        "limit":30,
        "format":"jpg",
        "print_url":True,
        "print_size":True
    }
    path = response.download(args)
    
```

### 영상 무료 제공 사이트
  다음 사이트들은 영상에 저자권없이 무료로 다운받아 사용할 수 있는 사이트들
  
   - pixabay: https://pixabay.com/ko/
   - Unsplash: https://unsplash.com/

### 이미지 캡쳐를 이용한 데이터 수집

 - OpenCV의 VideoCapture를 이용해 이미지 수집

``` python
    pip install opencv-contrib-python
    
    import cv2
    import sys
    import os
    import time
    import uuid
    
    IMAGE_DIR = 'images'
    if not os.path.isdir(IMAGE_DIR):
      os.mkdir(IMAGE_DIR)
      
    labels = ['one','two','three','four','five']
    
    n_images = 15 # 카테고리별로 몇장씩 만들지
    
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
      print('웹캠 연결 실패')
      sys.exit(1) # 종료
      
    # 웹캠이미지 사이즈 설정
    cap.set(cv2.CAP_PROP_FRAME_WIDTH,640)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT,480)
    
    break_all = False # 중복 반복문의 전체를 빠져나오기 위한 bool
    
    # label별로 반복해서 캡쳐
    for label in labels:
      print(f"{label} 라벨캡쳐")
      time.sleep(2) # 2초대기
      
      # 이미지 n_images 개수만큼 캡쳐
      # 한번 반복할때마다 한장씩 캡쳐
      for img_num in range(n_images):
          ret, frame = cap.read() # 캡쳐: 성공여부, 캡쳐이미지
          
          frame = cv2.flip(frame,1)
          filename = "{}-{}.jpg".format(label,str(uuid.uuid1()))
          file_path = os.path.join(IMAGE_DIR,filename)
          
          #화면에 출력
          cv2.imshow('frame',frame)
          #캡처이미지를 파일로 저장
          cv2.imwrite(file_path, frame)
          print(f"{img_num}번째,",end=" ")
          
          if cv2.waitKey(2000) == 27: # 27:esc를 누르면 강제종료
            print('강제종료')
            break_all = True
            break
        if break_all: # 반복문 전체를 빠져나오도록 설정
          break
        print()
        
    # 종료: 카메라, 출력장을 종료
    cap.release()
    cv2.destroyAllWIndows()
```

### LabelImg를 이용한  Object Detection 데이터 Labeling

  - github에서 다운 받은 뒤 압축 풀기
      - https://github.com/tzutalin/labelImg
  - 의존 라이브러리 설치
      - conda install pyqt=5
      - conda install -c anaconda lxml
      - pyrcc5 -o libs/resources.py resources.qrc
  - data\predefined_classes.txt 변경
      - Labeling할 대상 클래스들로 변경
  - 실행
      - `python labelImg.py`
      - 메뉴: view > Auto savel mode 체크
      - opendir - labeling할 이미지 디렉토리 열기
      - change save dir: annotation 파일 저장 디렉토리 설정
      - Labeling Format 지정 :  Pascal VOC, YOLO 
  - 주요 단축키
      - w :	BBox 그리기
      - d :	다음 이미지
      - a  :	이전 이미지
      - del :	BBox 삭제
      1ctrl+shift+d	현재 이미지 삭제
```
    
    
              
               

















