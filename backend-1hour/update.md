# CRUD API 만들기

APIView로 (Create)·읽고(Read)·수정(Update)·삭제(Delete)’ 하는 **CRUD API**를 만들겠습니다.

---



## 수정하기
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
이제 urls.py 파일에 아래 코드를 추가해줍시다.

```python
# posts/urls.py
from django.urls import path
from .views import PostUpdate

urlpatterns = [
    path('update/<int:pk>/', PostUpdate.as_view()),
]
```

## postman에 그림과 같이 요청을 보냅니다
<img src="backend-1hour/images/update.png" alt="update" width="80%">

**내가 조회하려는 데이터의 어드민 상세페이지를 들어가면 상단 탭에 몇번 pk인지 표기됩니다.**

```
url: `http://127.0.0.1:8000/posts/update/{pk값}/`
method: `PATCH`
body: `{
    "title": "value3",
    "content": "value4"
}`
```
포스트 리스트 API를 조회하면, 수정한 포스트가 조회됩니다.
