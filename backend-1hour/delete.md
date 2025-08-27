# CRUD API 만들기

APIView로 (Create)·읽고(Read)·수정(Update)·삭제(Delete)’ 하는 **CRUD API**를 만들겠습니다.

---


## 삭제하기
이번에는 title이 "test"인 포스트를 삭제해보겠습니다.

`posts/views.py` 파일에 아래 코드를 추가해줍시다.

```python
class PostDelete(APIView):
    def delete(self, request, pk):
        post = Post.objects.filter(title="test")
        post.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
```

이제 urls.py 파일에 아래 코드를 추가해줍시다.

```python
# posts/urls.py
from django.urls import path
from .views import PostDelete

urlpatterns = [
    path('delete/<int:pk>/', PostDelete.as_view()),
]
```
