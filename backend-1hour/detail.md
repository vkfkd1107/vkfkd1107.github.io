# CRUD API 만들기

APIView로 (Create)·읽고(Read)·수정(Update)·삭제(Delete)’ 하는 **CRUD API**를 만들겠습니다.

---



## 특정 포스트의 상세내역 조회하기
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
        author_name = serializers.CharField(source="author.username")
        class Meta:
            model = Post
            fields = [
                "author_name",
                "title",
                "content",
                "created_at",
            ]

    class PostCommentSerializer(ModelSerializer):
        class Meta:
            model = Comment
            fields = [
                "content",
                "created_at",
            ]

    def get(self, request, pk):
        post = Post.objects.get(id=pk)
        comments = post.comments.all()
        return Response(comments, status=status.HTTP_200_OK)

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

