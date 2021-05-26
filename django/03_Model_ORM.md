## ORM이란
  - Object Relational Mapping - 객체 관계 매핑
    - 객체와 관계형 데이터베이스의 데이터를 자동으로 연결하여 SQL문없이 CRUD(데이터베이스 작업)를 작성할 수 있다.
    ![image](https://user-images.githubusercontent.com/76146752/119693799-96839400-be87-11eb-8c9f-867ac12ffd5c.png)
  - 장점
    - 비즈니스로직과 데이터베이스 로직을 분리할 수 있다. 재사용성, 유지보수성이 증가한다.
    - DBMS에 대한 종속성이 줄어든다
  - 단점
    - DBMS 고유의 기능을 사용할 수 없다.
    - DB의 관계가 복잡할 경우 난이도 또한 올라간다.

### ORM
  - ORM을 사용할 경우 SQL문 없이 DB작업을 하는 것이 가능하지만 작성한 코드를 통해 어떤 SQL이 실행되는지 파악하고 있어야한다.
  - 장고는 SQL문을 직접 실행할 수도 있지만 가능하면 ORM을 사용하는 것이 좋다
  - django ORM이 지우너하는 DMBS
    - mysql, oracle, postgresql, sqlite3

### Model 생성 절차
  - 장고 모델을 먼저 만들고 데이터베이스에 적용
    1. models.py에 Model 클래스 작성
    2. admin.py에 등록 (admin app에서 관리할 경우)
      - admin.site.register(모델클래스)
    3. 마이그래이션(migration)파일 생성 - (makemigrations 명령)
      - 변경 사항 DB에 넣기 위한(migrate)내역을 가진 파일로 app/migrations 디렉토리에 생성된다
      - python manage.py makemigrations
      - SQL문 확인
        - python manage.py sqlmigrate app이름 마이그레이션파일명
    4. Database에 적용 (migrate 명령)
      - python mangage.py migrate

  - DB에 테이블이 있을 경우 다음을 이용해 장고 Model 클래스들을 생성할 수 있다.
    - inspectdb 명령 사용
      - # 터미널에 출력
        `python manage.py inspectdb`
      - # 파일에 저장
        `python manage.py inspectdb > app/파일명
     - inspectdb로 생성되 model 코드는 초안이다. 생성코드를 바탕으로 수정한다

### Mdoel 클래스
  - ORM은 DB 테이블과 파이썬 클래스를 1대 1로 매핑한다. 이 클래스를 Model이라고 한다
  - models.py에 작성
    - django.db.models.Model 상속
    - 클래스 이름은 관례적으로 단수형으로 지정하고 Pascal 표기법을 사용한다.
    - Database 테이블 이름은 "App이름_모델클래스이름"형식으로 만들어 진다.
      - 모델의 Meta 클래스의 db_table 속성을 이용해 원하는 테이블 이름을 지정할 수 있다
    - Field 선언
      - Field는 테이블의 컬럼과 연결되는 변수를 말하며 class 변수로 선언한다.
      - 변수명은 소문자로 하고 snake표기법을 사용한다.
      - primary 컬럼은 직접 지정하거나 생략한다.
        - PK 컬럼 변수를 생략하면 1씩 자동 증가하는 값을 가지는 id 컬럼이 default로 생성된다.

### Model 클래스 - Field 타입
  - 테이블 속성은 클래스 변수로 선언
    - 변수명 = Field객체()
      - 변수명: 컬럼명
      - Field 객체: 컬럼 데이터타입에 맞춰 선언

  - 장고 필드 클래스
    - 문자열 타입
      - CharField, TextField
    - 숫자 타입
      - integerField, PositiveIntegerField, FloatField
    - 날짜 시간 타입
      - DateTimeField, DateField, TimeField
    - 파일
      - FileField, ImageField
      - ImageField를 사용하기 위해서는 pillow 패키지를 설치해야한다.
    - 논리형 필드
      - BooleanField
    - 모델 간의 관계
      - ForeignKey: 외래키 설정(부모 데이블 연결 모델 클래스 지정) . 1대 다의 관계
      - ManyToMany: 다 대 다 관계 설정
      - OneToOneField: 1 대  1 관계 설정
    - 기타
      - EmailField
      - URLField
  - 주요 필드 옵션
    - max_length : 문자 타입의 최대 길이(글자수) 설정
    - blank: 입력값 유효성(validation) 검사 시에 empty값 허용 여부 (default: False)
    - null (DB 옵션): DB필드에 NULL 허용 여부( 디폴트: False)
    - unique(DB옵션) : 유일성 여부(디폴트: False)


















###
