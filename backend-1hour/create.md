# CRUD API 만들기

이 글에서는 DRF APIView를 사용해 Create(생성) 기능을 구현해 보겠습니다.

---

# Post 생성하기
`posts/views.py` 파일에 아래 코드를 추가해줍시다.

```python
# posts/views.py
from posts.models import Post
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.serializers import ModelSerializer
from django.contrib.auth.models import User

class PostCreate(APIView):
    class PostSerializer(ModelSerializer):
        class Meta:
            model = Post
            fields = [
                "title",
                "content",
            ]

    def post(self, request):
        serializer = self.PostSerializer(data=request.data) # 요청받은 데이터를 serializer에 넣어줍니다
        serializer.is_valid(raise_exception=True)   # serializer에 있는 데이터가 유효한지 확인하고 유효하지 않으면 에러를 일으킵니다: 필드 누락, 타입 불일치 등
        user = User.objects.first() # 아직 로그인 기능이 없으므로 임시로 DB에 첫 번째로 저장된 유저를 사용합니다
        if user is None:
            return Response(
                {"detail": "테스트용 유저가 없습니다."},
                status=status.HTTP_400_BAD_REQUEST
            )
        Post.objects.create(
            author=user,
            title=serializer.validated_data["title"],
            content=serializer.validated_data["content"],
        )
        return Response(status=status.HTTP_201_CREATED)
```

#### ORM Create
```python
모델이름.objects.create(
    필드이름1=값1,
    필드이름2=값2,
    필드이름3=값3,
    필드이름4=값4,
)
```
데이터를 생성하는 orm 문법입니다

### 주요 상태 코드 한눈에 보기  
| 코드 | 의미 | 언제 나올까요? |
|------|------|----------------|
| 200  | OK (정상) | 조회·수정 등 **요청이 성공**했을 때 |
| 201  | Created | 새 글이 **정상적으로 생성**됐을 때 |
| 400  | Bad Request | 보낸 데이터가 형식 오류 등으로 **검증에 실패**했을 때 |
| 401  | Unauthorized | 인증(로그인)이 되지 않았을 때 |
| 403  | Forbidden | 권한이 없을 때 |
| 404  | Not Found | 요청한 경로나 파일이 없을 때 |
| 500  | Internal Server Error | 서버 오류가 발생했을 때 |

이제 urls.py 파일에 아래 코드를 추가해줍시다.

```python
# posts/urls.py
from django.urls import path
from .views import PostCreate

urlpatterns = [
    path('create/', PostCreate.as_view()),
]
```

## postman에 그림과 같이 요청을 보냅니다
<img src="backend-1hour/images/create.png" alt="create" width="80%">

```
url: `http://127.0.0.1:8000/posts/create/`
method: `POST`
body: `{
    "title": "value1",
    "content": "value2"
}`
```

포스트 리스트 API를 조회하면, 생성한 포스트가 조회됩니다.


> 이렇게도 할 수 있습니다 (ModelSerializer 대신 Serializer를 사용)
```python
# posts/views.py
from posts.models import Post
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.serializers import Serializer
from django.contrib.auth.models import User

class PostCreate(APIView):
    class PostSerializer(Serializer):
        title = serializers.CharField()
        content = serializers.CharField()

    def post(self, request):
        serializer = self.PostSerializer(data=request.data) # 요청받은 데이터를 serializer에 넣어줍니다
        serializer.is_valid(raise_exception=True)   # serializer에 있는 데이터가 유효한지 확인하고 유효하지 않으면 에러를 일으킵니다
        user = User.objects.first() # 유저관련 기능을 만들지 않았기 때문에 임의의 유저를 지정했습니다
        Post.objects.create(
            author=user,
            title=serializer.validated_data["title"],
            content=serializer.validated_data["content"],
        )
        return Response(status=status.HTTP_201_CREATED)
```
### ModelSerializer vs Serializer
- ModelSerializer: 모델과 직접적으로 연결되어 있어서 모델 정보를 참조하여 따로 선언해줄 필요 없이 필드의 정보를 가져옵니다
- Serializer: 모델과 직접적으로 연결되어 있지 않아서 모델의 필드를 직접 선언해줘야 합니다


### 기능 추가: 입력한 이메일의 유저 정보로 포스트를 생성하기
```python
# posts/views.py
from posts.models import Post
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.serializers import ModelSerializer
from django.contrib.auth.models import User

class PostCreate(APIView):
    class PostSerializer(serializers.Serializer):
        user_email = serializers.EmailField()
        title = serializers.CharField()
        content = serializers.CharField()

    def post(self, request):
        serializer = self.PostSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        # 추가한 코드: 입력한 이메일의 유저정보를 찾고, 없으면 404 오류를 반환, 에러가 발생하면 500 오류를 반환
        try:
            user = User.objects.get(email=serializer.validated_data["user_email"])
        except User.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        Post.objects.create(
            author=user,
            title=serializer.validated_data["title"],
            content=serializer.validated_data["content"],
        )
        return Response(status=status.HTTP_201_CREATED)
```

# 직접 해보기
1. 댓글을 생성하는 기능을 추가해보세요. 유저 객체에 대해 FK키로 연결되야합니다.
2. 이메일 도메인이 `salarify.kr`, `naver.com`, `gmail.com` 인 유저만 댓글을 생성할 수 있게 기능을 추가해보세요
    - 그 외의 유저가 댓글을 생성하려하면, 실패하게 만들어주세요
    - 상태코드도 알맞게 반환해야합니다
