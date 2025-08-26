# API 만들기

저희는 API를 만들기 위해 DRF라는 도구를 설치해서 사용할 것입니다

# Django & DRF 한눈에 이해하기
Django(장고)는 **파이썬으로 웹 서버**를 빠르게 만들 수 있는 프레임워크입니다.  
Django REST Framework(DRF)는 Django 위에서 **API(데이터만 주고받는 통신)** 를 더 쉽게 작성하도록 도와주는 확장 도구입니다


# DRF 세팅 후 API 만들기

## 1. DRF 설치

```bash
pip install djangorestframework
```

## settings.py 수정
설치 후 `settings.py` 파일의 `INSTALLED_APPS`에 `rest_framework`를 추가해줍니다

```python
INSTALLED_APPS = [
    ...
    'rest_framework', # 추가
    ...
]
```

## url 설정

### 1. posts앱에서 urls.py 파일 생성
urls.py 파일을 생성해주고 아래와 같이 작성해줍니다  

```python
# posts/urls.py

from django.urls import path
from posts import views

urlpatterns = []
```

### 2. 루트 urls.py에 방금 생성한 앱의 urls.py 파일 연결

```python
# mysite/urls.py

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('posts/', include('posts.urls')), # 추가
]
```


### 3. views.py에 뷰 작성
아래와 같이 작성해줍니다
```python
# posts/views.py

from posts.models import Post

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.serializers import ModelSerializer


class PostList(APIView):
    class PostSerializer(ModelSerializer):
        class Meta:
            model = Post
            fields = [
                "id",
                "author",
                "title",
                "content",
                "created_at",
                "updated_at",
            ]

    def get(self, request):
        posts = Post.objects.all()
        serializer = self.PostSerializer(posts, many=True)
        return Response(serializer.data)
```

### 4. posts앱의 urls.py에 뷰 연결

```python
# posts/urls.py

from django.urls import path
from posts import views

urlpatterns = [
    path('list/', views.PostList.as_view()),
]
```

이 단계를 모두 완료했다면, API하나가 만들어졌습니다. 테스트를 하기 위해,  
어드민에서 데이터를 추가해주고 [postman을 설치](https://www.postman.com/downloads/)해주세요  
postman 사용법은 [이 링크](https://learning.postman.com/docs/getting-started/first-steps/sending-the-first-request/)를 참고해주세요


### 5. 테스트
<img src="/backend-1hour/images/django/test_api.png" width="50%">  

```mermaid
메소드: GET
주소: 127.0.0.1:8000/posts/list/
```
테스트 결과가 성공하면 사진과 같은 결과가 나옵니다


# 설명
API만들고 테스트까지 완료했으니, 이제 코드를 설명해보겠습니다

### 프로젝트 구조 및 파일 설명
현재 프로젝트 폴더 구조는 아래와 같습니다
각 파일에 대해 설명하겠습니다
```
my-first-django/
└── mysite/
    ├── manage.py
    └── mysite/
        ├── __init__.py
        ├── settings.py
        ├── urls.py
        ├── wsgi.py
        └── asgi.py
    └── posts/
        ├── migrations/
        |   └── __init__.py
        ├── __init__.py
        ├── admin.py
        ├── apps.py
        ├── models.py
        ├── tests.py
        └── views.py
    └── db.sqlite3
```

| 파일명 | 설명 |
|------|--------|
| `manage.py` | 이 파일을 통해 runserver, migrate 등 명령어를 실행할 수 있습니다 |
| `settings.py` | 앱등록, 외부 라이브러리 설정, 데이터베이스 설정 등 프로젝트 전체적인 설정을 할 수 있습니다 |
| `mysite/urls.py` | 프로젝트에 등록된 앱의 urls.py 파일을 등록합니다 |
| `posts/models.py` | 데이터베이스 모델 정의 |
| `posts/views.py` | API 로직 작성 |
| `posts/urls.py` | posts 앱의 URL 설정을 할 수 있습니다. 뷰와 연결해줍니다. |
| `db.sqlite3` | 데이터를 저장하는 파일입니다 |


### API 작동 구조
이전에 웹은 그림과 같이 작동한다 설명했습니다

<img src="/backend-1hour/images/web.png" width="80%">  

저희는 이 그림에서 **백엔드가 request를 받고, response를 보내는 부분**을 만들어준 것입니다.


<img src="/backend-1hour/images/django/django_detail.png" width="100%">  

더 자세히 살펴보면 이렇게 동작합니다
1. **프론트엔드에서 요청(Request) 보내기**

2. **URL 매핑(URLs.py)으로 목적지 결정**  
   - (1) `mysite/urls.py`에서 왼쪽부터 주소를 비교해 가장 먼저 맞는 패턴을 찾고 해당 앱의 `urls.py`로 전달  
     예) `127.0.0.1:8000/posts/list/` → `path('posts/', include('posts.urls'))`  
     매칭되는 패턴이 없으면 **404 오류** 발생  
   - (2) `posts/urls.py`에서 나머지 주소를 비교해 특정 뷰로 전달  
     예) `path('list/', views.post_list)`

3. **뷰(View)에서 로직 처리**

4. **DB에 쿼리(SQL)를 전송해 데이터 조회**

5. **DB가 결과를 뷰에 반환**

6. **뷰가 데이터를 직렬화 등으로 가공해 응답(Response) 생성**

7. **프론트엔드가 응답을 받아 화면에 표시**  


### 🧩 기초 개념 한눈에 보기   <!-- 이동 & 한글 병기 -->
| 용어 | 한 줄 설명 |
|------|-----------|
| API | 프로그램끼리 통신 규칙 |
| HTTP 메서드 | **GET**(읽기) · **POST**(쓰기) · **PATCH**(부분 수정) · **DELETE**(삭제) |
| ORM | SQL 대신 파이썬 객체로 DB 접근 (`Post.objects.all()`) |
| Serializer | 파이썬 ↔ JSON 변환 |
| **ModelSerializer** | 모델 정보를 바탕으로 Serializer 코드를 “자동” 생성 |
| QuerySet | ORM이 반환하는 “레코드 모음” 객체 |

### 🧩 추가 개념: Serializer가 필요한 이유
> “DB에서 꺼낸 파이썬 객체를 프론트엔드가 읽을 수 있는 **JSON** 포장지로 싸 준다.”

### 🧩 추가 개념: ORM 메서드 & `many=True`
1. ORM 기본 메서드  
   | 메서드 | 기능 | 예시 코드 | 반환 타입 |
   |--------|------|-----------|-----------|
   | `all()` | 전부 조회 | `Post.objects.all()` | QuerySet |
   | `filter()` | 조건 조회 | `Post.objects.filter(author="Lee")` | QuerySet |
   | `get()` | 하나만 조회 | `Post.objects.get(id=1)` | 단일 객체 |
   | `create()` | 새 레코드 | `Post.objects.create(title="Hi", …)` | 단일 객체 |

2. `many=True`  
   • 직렬화 대상이 **여러 개(QuerySet)** 임을 ModelSerializer에 알림.  
   • 기본값은 `many=False`.

```python
single_post = Post.objects.get(id=1)
serializer = PostSerializer(single_post)          # 단일 ↔ many=False

post_list = Post.objects.all()
serializer = PostSerializer(post_list, many=True) # 여러 개 ↔ many=True
```

### 코드 설명
실습에서 작성한 코드를 단계별로 다시 보며 **왜 이렇게 작성했는지** 알아봅니다.

1. **settings.py – DRF 등록**

```python
INSTALLED_APPS = [
    ...
    'rest_framework',  # DRF 기능을 활성화
    ...
]
```
• DRF를 앱에 등록해야 `APIView`, `Response` 등 DRF 클래스들을 사용할 수 있습니다.

2. **posts/urls.py – 뷰 연결**

```python
urlpatterns = [
    path('list/', views.PostList.as_view()),
]
```
• `/posts/list/` 로 들어온 요청을 `PostList` 뷰로 보냅니다.  
• `as_view()`는 클래스 기반 뷰를 함수처럼 호출할 수 있게 만들어 줍니다.

3. **mysite/urls.py – 앱 라우팅**

```python
urlpatterns = [
    path('admin/', admin.site.urls),
    path('posts/', include('posts.urls')),  # posts 앱의 URL 묶음
]
```
• URL의 첫 구간이 `posts/` 로 시작하면 **posts 앱**으로 라우팅됩니다.  
• 다른 패턴이 없으면 404 오류가 반환됩니다.


4. **posts/views.py – PostList 뷰**

```python
class PostList(APIView):
    # ModelSerializer: Post 모델 구조를 참고해 JSON 규칙을 자동으로 만들어 줌
    class PostSerializer(ModelSerializer):
        class Meta:
            model  = Post                                  # 어떤 모델을 직렬화할지
            fields = [                                     # 응답에 포함할 필드
                "id", "author", "title",
                "content", "created_at", "updated_at",
            ]

    # GET 요청(읽기)을 처리
    def get(self, request):
        posts = Post.objects.all()                         # ① QuerySet: 모든 글 조회
        serializer = self.PostSerializer(posts, many=True) # ② QuerySet → JSON 변환,   # ✅ 여러 개라서 many=True가 꼭 필요!
        return Response(serializer.data)                   # ③ 변환된 JSON 응답
```

① **QuerySet** – ORM 덕분에 `SELECT * FROM Post` SQL을 직접 쓰지 않아도 됨  
② **ModelSerializer** – 모델 구조를 보고 필드·검증 코드를 “자동” 생성하여 직렬화  
③ **Response** – 직렬화된 JSON 데이터를 HTTP 응답 본문에 담아 반환


5. **요청 → 응답 흐름 요약**

```mermaid
브라우저 / Postman  
│ GET /posts/list/  
▼  
mysite/urls.py (posts/ 라우팅)  
▼  
posts/urls.py (list/ 라우팅)  
▼  
views.PostList.get()  
▼  
DB(Post 모델) → 직렬화 → Response(JSON)  
▼  
클라이언트 화면 표시  
```


# 직접해보기
댓글 리스트를 조회하는 API를 만들어주세요