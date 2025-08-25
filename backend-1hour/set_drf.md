# API 만들기

저희는 API를 만들기 위해 DRF라는 도구를 설치해서 사용할 것입니다

# DRF란?

DRF(Django REST Framework)는 Django에서 API를 쉽게 만들 수 있도록 도와주는 도구입니다  
우리가 정의한 모델의 데이터를 쉽게 변환하여 응답할 수 있도록 도와줍니다

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


<img src="/backend-1hour/images/django/django_detail.png" width="70%">  

더 자세히 살펴보면 이렇게 동작합니다
1. **프론트엔드**에서 백엔드에 request를 보냅니다
2. **urls.py** 파일에서 요청을 받고, 어느 뷰에 요청을 보낼지 결정합니다
3. **뷰**에서 요청을 받습니다
4. **뷰**에서 데이터베이스에 접근하여 데이터를 가져옵니다
5. **뷰**에서 데이터를 가공하여 response를 보냅니다
6. **프론트엔드**에서 response를 받습니다

작성중...