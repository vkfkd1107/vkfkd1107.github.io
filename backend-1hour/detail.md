# CRUD API 만들기

이 글에서는 DRF APIView를 사용해 READ(조회) 기능을 구현해 보겠습니다.

---
# 특정 포스트 조회하기
이번에는 포스트의 내용을 더 상세히 조회하는 API를 만들어보겠습니다.

```python
# posts/views.py
from posts.models import Post, Comment
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.serializers import ModelSerializer
from django.contrib.auth.models import User
from rest_framework import serializers


class PostDetail(APIView):
    class PostDetailSerializer(ModelSerializer):
        class Meta:
            model = Post    # 어떤 모델의 데이터를 가져올지
            fields = [    # 가져올 필드 리스트
                "title",
                "content",
                "created_at",
            ]

    def get(self, request, pk):
        post = Post.objects.get(id=pk)
        serializer = self.PostDetailSerializer(post)
        return Response(serializer.data, status=status.HTTP_200_OK)

```

이제 urls.py 파일에 아래 코드를 추가해줍시다.

```python
# posts/urls.py
from django.urls import path
from .views import PostDetail

urlpatterns = [
    path('detail/<int:pk>/', PostDetail.as_view()),
]
```
url에 `<타입:변수>` 형식으로 특정 건에 대해 요청을 보낼 수 있습니다.

### 예시1: <int:age>
`posts/urls.py`
```python
from django.urls import path
from .views import PostDetail

urlpatterns = [
    path('detail/<int:age>/', PostDetail.as_view()),
]
```
`posts/views.py`
```python
from django.http import HttpResponse

def post_detail(request, age):
    return HttpResponse(f"Age: {age}")
```

### 예시2: <str:email>
`posts/urls.py`
```python
# posts/urls.py
from django.urls import path
from .views import PostDetail

urlpatterns = [
    path('detail/<str:email>/', PostDetail.as_view()),
]
```
`posts/views.py`
```python
from django.http import HttpResponse

def post_detail(request, email):
    return HttpResponse(f"Email: {email}")
```


### PostDetail url을 조회해보면 아래와 같은 결과가 나오는것을 볼 수 있습니다
<img src="backend-1hour/images/detail_result.png" alt="detail" width="50%">


# salarify 포스트 조회하기
이번에는 특정 도메인이 이메일에 포함된 유저들의 포스트를 조회하는 API를 만들어보겠습니다

`posts/views.py`
```python
from posts.models import Post
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.serializers import ModelSerializer
from django.contrib.auth.models import User
from rest_framework import serializers
```
`posts/urls.py`
```python
from django.urls import path
from .views import PostDetail

urlpatterns = [
    path('detail/<str:email_domain>/', PostDetail.as_view()),
]
```
`posts/views.py`
```python
from posts.models import Post
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.serializers import ModelSerializer
from django.contrib.auth.models import User
from rest_framework import serializers

class PostDetail(APIView):
    class PostDetailSerializer(ModelSerializer):
        author_name = serializers.CharField(source="author.username")
        class Meta:
            model = Post
            fields = [
                "author_name",
                "title",
                "content",
                "created_at",
            ]

    def get(self, request, email_domain):
        post_list = Post.objects.filter(author__email__icontains=email_domain)
        serializer = self.PostDetailSerializer(post_list, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
```

> **author_name = serializers.CharField(source="author.username")**  
위 코드는 `author` 필드의 `username` 필드를 `author_name` 필드에 매핑하는 코드입니다

> **post_list = Post.objects.filter(author__email__icontains=email_domain)**  

위 코드는 `Post` 모델에서 `author` 필드의 `email` 필드에 `email_domain`이 포함된 데이터를 조회하는 코드입니다  
`email_domain`은 get요청의 url에 있는 변수입니다

> **serializer = self.PostDetailSerializer(post_list, many=True)**  

위 코드는 `post_list`를 `PostDetailSerializer`에서 정의한 필드에 맞게 변환하는 코드입니다
`many=True`는 `post_list`가 여러 개이기 때문에 `True`로 설정합니다  

### PostDetail url을 조회해보면 아래와 같은 결과가 나오는것을 볼 수 있습니다
<img src="backend-1hour/images/salarify_result.png" alt="detail" width="50%">




# 유저별 포스트 조회하기
이번에는 특정 유저의 포스트를 조회하는 API를 만들어보겠습니다

`posts/urls.py`
```python
from django.urls import path
from .views import PostDetail

urlpatterns = [
    path('detail/<str:user_email>/', PostDetail.as_view()),
]
```

`posts/models.py`
**author필드에 related_name="posts"를 추가해줍니다**
```python
from django.db import models
from django.contrib.auth.models import User

class Post(models.Model):
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name="posts")
```
#### related_name
related_name은 연결된 모델에서 연결된 모델의 이름을 설정합니다  
related_name으로 쉽게 연결된 모델을 참조하여 데이터를 조회할 수 있습니다  
```python
user = User.objects.get(email="test@test.com")
# 지정한 이름의 related_name으로 test@test.com의 모든 포스트를 조회할 수 있습니다
posts = user.posts.all()
```


`posts/views.py`
```python
from posts.models import Post
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.serializers import ModelSerializer
from django.contrib.auth.models import User
from rest_framework import serializers

class PostDetail(APIView):
    class PostDetailSerializer(ModelSerializer):
        class PostSerializer(ModelSerializer):
            class Meta:
                model = Post
                fields = [
                    "title",
                    "content",
                ]
        posts = PostSerializer(many=True)
        class Meta:
            model = User
            fields = [
                "username",
                "email",
                "posts",
            ]

    def get(self, request, user_email):
        user = User.objects.get(email=user_email)
        serializer = self.PostDetailSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)
```
**Serializer내부에 중첩시켜서 연결된 모델의 데이터를 조회할 수 있습니다**
결과를 확인해보면 아래와 같은 결과가 나오는것을 볼 수 있습니다


<img src="backend-1hour/images/user_post_result.png" alt="detail" width="50%">

# 직접 해보기
1. 포스트별 댓글 조회하는 API를 만들어주세요
2. 댓글 모델에 공개, 비공개여부 필드를 추가해주세요
3. 유저별로 포스트와 댓글을 조회하는 API를 만들어주세요
4. 유저의 이름, 이메일이 바껴도 댓글에 표기되는 이름은 수정되지 않게 구현해주세요. 과거 정보에 대해 기록이 남아야합니다.
