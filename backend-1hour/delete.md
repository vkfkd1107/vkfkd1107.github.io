# 포스트 삭제하기 API 만들기

이 글에서는 기존에 작성한 포스트를 삭제할 수 있는 기능을 만들어보겠습니다.  
마치 블로그에서 글을 삭제하는 것처럼, 더 이상 필요하지 않은 포스트를 완전히 지울 수 있게 해보겠습니다.

---

## 삭제 기능 만들기

`posts/views.py` 파일에 아래 코드를 추가해줍시다.

```python
class PostDelete(APIView):
    def delete(self, request, pk):
        post = Post.objects.get(id=pk)
        post.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
```

> **코드 설명**
- `PostDelete`: 포스트를 삭제하는 기능을 담당하는 클래스입니다
- `delete`: 삭제를 위한 메서드입니다
- `pk`: 삭제하려는 포스트의 고유 번호입니다
- `HTTP_204_NO_CONTENT`: 삭제가 성공했을 때 보내는 응답 코드입니다(선택사항)


>#### 삭제 방법

포스트를 삭제할 때는 DELETE 메서드를 사용합니다.

| 방법 | 설명 |
|------|------|
| DELETE | 포스트를 완전히 삭제 |

>#### 데이터베이스에서 삭제하는 방법

데이터베이스에서 포스트를 삭제하는 방법은 두 가지가 있습니다:

**방법 1: 조건에 맞는 포스트들을 한 번에 삭제하기**
```python
# 예시: 특정 조건에 맞는 포스트들을 모두 삭제
Post.objects.filter(title="test").delete()
```

**방법 2: 특정 포스트 하나만 삭제하기**
```python
# 예시: 특정 번호의 포스트를 찾아서 삭제
post = Post.objects.get(id=pk)
post.delete()
```




## URL 설정하기

이제 삭제 기능을 사용할 수 있도록 URL을 설정해줍시다.

`posts/urls.py` 파일에 아래 코드를 추가해줍시다.

```python
# posts/urls.py
from django.urls import path
from .views import PostDelete

urlpatterns = [
    path('delete/<int:pk>/', PostDelete.as_view()),
]
```

> **URL 설명**
- `delete/<int:pk>/`: 삭제할 포스트의 번호를 받아서 삭제 기능으로 연결해줍니다
- `<int:pk>`: 삭제하려는 포스트의 고유 번호를 의미합니다

## Postman으로 테스트하기

이제 Postman에서 삭제 기능을 테스트해보겠습니다.

**포스트 번호 확인하기**
- Django 관리자 페이지에서 삭제하려는 포스트의 상세 페이지로 들어가면
- 상단에 "Post #숫자" 형태로 포스트 번호가 표시됩니다

**Postman 설정**
```
주소: http://127.0.0.1:8000/posts/delete/포스트번호/
방법: DELETE
내용: (비어있음)
```

삭제가 완료되면 포스트 목록에서 해당 포스트가 사라진 것을 확인할 수 있습니다.

> **주의사항**
> - 삭제된 포스트는 복구할 수 없으므로 신중하게 삭제하세요
> - 삭제 후에는 204 상태 코드가 반환됩니다



