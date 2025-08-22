# 블로그 만들어보기
블로그를 만들어보면서, 나머지 내용을 배워보겠습니다.  
이번 챕터부터는 vscode나 cursor 등의 텍스트 에디터를 사용해주세요.

## 앱 생성하기
장고는 앱 단위로 기능을 구현합니다.  
자동차를 만들때, 각 부품을 만들고 이를 조립하는 것과 같습니다.  
장고에서는 각 부품을 앱으로 만듭니다.  

아래 명령어로 포스트 앱을 생성합니다.  
```bash
python3 manage.py startapp posts
```
위 명령어를 실행하면 posts 앱이 생성됩니다.  
폴더 구조는 아래와 같습니다
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
위 명령어로 `posts`앱을 생성했으면, 이제 설정파일에 앱을 등록해야 합니다.  
`mysite/settings.py` 파일을 열어서 `INSTALLED_APPS` 부분에 `'posts'` 를 추가합니다.  
```python
INSTALLED_APPS = [
    'posts',
]
```
이제 `posts`앱을 사용할 준비가 되었습니다.  
다음 챕터에서는 `posts` 앱에 포스트와 댓글을 생성해보겠습니다.  