# 포스트 수정하기 API 만들기

이 글에서는 기존에 작성한 포스트를 수정할 수 있는 기능을 만들어보겠습니다.  
마치 블로그에서 글을 수정하는 것처럼, 제목과 내용을 바꿀 수 있게 해보겠습니다.

---

## 수정 기능 만들기

`posts/views.py` 파일에 아래 코드를 추가해줍시다.

```python
class PostUpdate(APIView):
    class PostSerializer(ModelSerializer):
        class Meta:
            model = Post
            fields = [
                "title",
                "content",
            ]

    def patch(self, request, pk):
        post = Post.objects.get(id=pk)
        serializer = self.PostSerializer(post, data=request.data)
        serializer.is_valid(raise_exception=True)
        post.title = serializer.validated_data["title"]
        post.content = serializer.validated_data["content"]
        post.save()
        return Response(status=status.HTTP_200_OK)

```

> **코드 설명**
- `PostUpdate`: 포스트를 수정하는 기능을 담당하는 클래스입니다
- `patch`: 부분 수정을 위한 메서드입니다
- `pk`: 수정하려는 포스트의 고유 번호입니다

>#### 수정 방법의 종류

포스트를 수정할 때는 두 가지 방법이 있습니다:

| 방법 | 설명 | 예시 |
|------|------|------|
| PATCH | 부분 수정 | 제목만 바꾸거나 내용만 바꾸기 |
| PUT | 전체 수정 | 모든 내용을 새로 입력하기 |

>#### 데이터베이스 수정 방법

데이터베이스에서 데이터를 수정하는 방법은 두 가지가 있습니다:

**방법 1: 한 번에 여러 필드 수정하기**
```python
# 예시: 포스트의 제목과 내용을 한 번에 바꾸기
Post.objects.filter(id=pk).update(
    title="새로운 제목",
    content="새로운 내용",
)
```

**방법 2: 하나씩 수정하고 저장하기**
```python
# 예시: 포스트를 찾아서 하나씩 바꾸고 저장하기
post = Post.objects.get(id=pk)
post.title = "새로운 제목"
post.content = "새로운 내용"
post.save()
```


## URL 설정하기

이제 수정 기능을 사용할 수 있도록 URL을 설정해줍시다.

`posts/urls.py` 파일에 아래 코드를 추가해줍시다.

```python
# posts/urls.py
from django.urls import path
from .views import PostUpdate

urlpatterns = [
    path('update/<int:pk>/', PostUpdate.as_view()),
]
```

> **URL 설명**
- `update/<int:pk>/`: 수정할 포스트의 번호를 받아서 수정 페이지로 연결해줍니다
- `<int:pk>`: 포스트의 고유 번호를 의미합니다

## Postman으로 테스트하기

이제 Postman에서 수정 기능을 테스트해보겠습니다.

<img src="backend-1hour/images/update.png" alt="update" width="80%">

**포스트 번호 확인하기**
- Django 관리자 페이지에서 수정하려는 포스트의 상세 페이지로 들어가면
- 상단에 "Post #숫자" 형태로 포스트 번호가 표시됩니다

**Postman 설정**
```
주소: http://127.0.0.1:8000/posts/update/포스트번호/
방법: PATCH
내용: {
    "title": "수정된 제목",
    "content": "수정된 내용"
}
```

수정이 완료되면 포스트 목록에서 수정된 내용을 확인할 수 있습니다.
