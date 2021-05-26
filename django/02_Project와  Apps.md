## Project와 Apps
  - project
    - 전체 프로젝트
  - app
    - 프로젝트를 구성하는 하위 서비스
  ![image](https://user-images.githubusercontent.com/76146752/119686373-3b4ea300-be81-11eb-9d71-6f32396ea25b.png)

### App
  - App은 프로젝트 안의 하나의 작은 서비스로 볼 수 있다.
  - 하나의 프로젝트는 여러 개의 app을 가질 수 있다.
  - 장고 프로젝트를 app별로 나누어 개발하는 이유는 재사용성이다.
      - 재사용성의 목적이 아니라면 하나의 app에 모든 구현을 다 해도 관계 없다
  - App을 생성하면 반드시 settings.INSTALLED_APP에 등록해야 한다
  - App을 생성하면 기본 모듈 파일들이 자동으로 생성된다. 추가 모듈은 파일을 직접 만들어 넣는다.
      - 꼭 기본적으로 생성된 모듈만 사용해야 하는 것은 아니다. 만약 특정 모듈이 복잡해질 경우 패키지로 나눠 개발할 수도 있다.

### Project와 Apps 만들기
  - 프로젝트 만들기
    - django-admin startproject 프로젝트명 .
    - ex) django-admin startproject mysite

  1. 프로젝트 디렉토리 생성 후
    - django-admin startproject 전체설정 경로명 .
    - ex) 
    > mkdir mysite (프로젝트 디렉토리 생성)
    > cd mysite
    > django-admin startproject config .
  
  - App 만들기
  
  1. python manage.py startapp App이름
    `python manage.py startapp mysite`
  2. project/전체설정경로/settings.py 에 등록
    - INSTALLED_APPS 설정에 생성한 APP의 이름을 등록
    ![image](https://user-images.githubusercontent.com/76146752/119687834-769da180-be82-11eb-898f-4166ff2658ee.png)

  3. project/전체설정/url.py에 path 등록
    ![image](https://user-images.githubusercontent.com/76146752/119687917-87e6ae00-be82-11eb-803f-1dcef852ec91.png)
### Project 구조
![image](https://user-images.githubusercontent.com/76146752/119690520-bb2a3c80-be84-11eb-988f-84797356fd14.png)
  - config - 프로젝트 전체 설정 디렉토리
    - settings.py
      - 현재 프로젝트에 대한 설정을 하는 파일
    - urls.py
      - 최상위 URL 패턴 설정
      - 사용자 요청과 실행할 app의 urls.py를 연결해준다
    - wsgi.py
      - 장고를 실행시켜주는 환경인 wsgi에 대한 설정
  - app 디렉토리(polls)
    - admin.py
      - admin 페이지에서 관리할 model 등록
    - apps.py
      - Application이 처음 시작할 때 실행될 코드를 작성
    - models.py
      - app에서 사용할 model 코드 작성
    - views.py
      - app에서 사용할 view 코드 작성
    - urls.py
      - 사용자 요청 URL과 그 요청을 처리할 View를 연결하는 설정을 작성
  - manage.py
    - 사이트 관리를 하는 스크립트

#### manage.py
  - python manage.py 명령어
    - startapp: 프로젝트에 app을 새로 생성
    - makemigrations : 어플리케이션의 변경을 추적해 DB에 적용할 변경사항을 정리한다.
    - migrate: makemigrations 로 정리된 DB 변경 내용을 Database에 적용한다
    - sqlmigrate: 변경사항을 DB에 적용할 때 사용한 SQL 확인
    - runserver:테스트 서버를 실행한다.
    - shell :장고 shell 실행
    - createsuperuser: 관리자 계정 생성
    - changepassword: 계정의 비밀번호 변경

#### 흐름
![image](https://user-images.githubusercontent.com/76146752/119693181-02b1c800-be87-11eb-888c-c3ac8f44f29e.png)

  
