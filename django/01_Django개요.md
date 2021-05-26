## Django 개요
  - 파이썬 오픈소스 웹 어플리케이션 프레임워크
      - 장고(Django) - https://www.djangoproject.com/
      - 플라스크(Flask) - https://flask.palletsprojects.com/
      - 장고는 제공되는 기능이 많은 대신 자유도가 떨어진다. 파이썬 기반 웹 프레임 워크 중 사용자가 가장 많으며 문서나 커뮤니티가 가장 크다
      - 플라스크는 가벼운 프레임워크를 지향하며 미리 제공되는 기능은 적은 대신 자유도가 높다

### 장고의 특징
  - MVT 패턴 구조의 개발
  - ORM 을 이용한 Database 연동
  - 자동으로 구성되는 관리자 기능
  - 유연한 URL 설계 지원
  - 화면 구성을 위한 template system 제공

### 장고 설치
  - 가상환경 생성
    - conda create -n django -env python=3.7
  - django 설치
    - conda install django
    - pip install django

### MVT 패턴
  - 장고는 역할에 따라 Model, View, Template 세 종류의 컴포넌트로 나눠 개발하며 이것을 MVT 패턴이라고 한다
      - M(Model)
        - 데이터베이스의 데이터를 다룬다
        - ORM을 이용해 SQL문 없이 CRUD 작업을 처리한다
      - V(View)
        - Client 요청을 받아서 Client에게 응답할 떄까지의 처리를 담당한다.
        - CLient가 요청한 작업을 처리하는 흐름(workflow)을 담당한다
        - 구현 방식은 함수 기반방식(FBV)과 클래스 기반 방식(CBV) 두가지가 있다
      - T(Template)
        - Client에게 보여지는 부분(응답화면)의 처리를 담당한다.

  - MVT 패턴의 장점
      - 전체 프로젝트의 구조를 역할에 따라 분리해서 개발할 수 있다. 그럼으로써 각자의 역할에 집중하여 개발할 수 있고 서로간의 연관성이 적어지기 때문에 유지 보수성, 확장성, 유연성이 좋아진다.
![image](https://user-images.githubusercontent.com/76146752/119685447-553bb600-be80-11eb-85bc-39b1cdb28cf8.png)





