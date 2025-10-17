## 회원기능 구현하기
회원기능을 구현하기 위한 과정을 진행해보겠습니다.

# 1. 커스텀 유저모델 생성하기
### 1-1. 커스텀 유저모델 생성
장고에서 기본적으로 제공하는 User모델을 사용하지 않고, 내가 정의한 유저모델을 사용하려면 커스텀 유저모델을 생성해야합니다.  
`users/models.py` 파일을 열어서 아래 코드를 추가합니다.  
```python
from django.db import models
from django.contrib.auth.models import AbstractBaseUser

class User(AbstractBaseUser):
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128)
    username = models.CharField(max_length=30, unique=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    date_joined = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now=True)
    birthdate = models.DateField(null=True, blank=True)
    phone = models.CharField(max_length=11, null=True, blank=True)
    address = models.CharField(max_length=200, null=True, blank=True)

    def __str__(self):
        return self.email

    def get_full_name(self):
        return self.username

    def get_short_name(self):
        return self.username
```

### 코드 설명
`AbstractBaseUser`란?
- 장고에서 기본적으로 제공하는 User모델을 사용하지 않고, **내가 정의한 유저모델을 사용할 때 사용**합니다
- 기본적으로 제공하는 필드 외에 별도로 필드를 추가할 수 있습니다
    - 기본적으로 제공하는 필드: email, password, username, is_active, is_staff, is_superuser, date_joined, last_login
    - 코드에서 별도로 추가한 필드: birthdate, phone, address

### 1-2. `settings.py` 수정하기
`settings.py` 파일을 열어서 아래 코드를 추가합니다.  
```python
AUTH_USER_MODEL = 'users.User'
```
### 코드 설명
- `AUTH_USER_MODEL`: 사용자 모델을 지정합니다. 이 설정을 통해 장고는 커스텀 유저모델을 사용합니다.

### 1-3. 마이그레이션 실행하기
`python manage.py makemigrations` 명령어를 실행해서 마이그레이션 파일을 생성합니다.  
`python manage.py migrate` 명령어를 실행해서 마이그레이션을 실행합니다.  

### 코드 설명
- `makemigrations`: 모델 변경사항을 마이그레이션 파일로 생성합니다
- `migrate`: 마이그레이션 파일을 실행해서 데이터베이스에 적용합니다

---

# 2. JWT 세팅하기
djangorestframework-simplejwt는 장고에서 JWT를 사용하기 위한 라이브러리입니다.  
`pip install djangorestframework-simplejwt` 명령어를 실행해서 설치합니다.  

### 2-1. `settings.py` 수정하기
`settings.py` 파일을 열어서 아래 코드를 추가합니다.  
```python
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ],
}

INSTALLED_APPS = [
    ...
    'djangorestframework_simplejwt',
    ...
]
```

### 2-2. `urls.py` 수정하기
`urls.py` 파일을 열어서 아래 코드를 추가합니다.  
```python
from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]
```

### 2-3. 테스트

`http://127.0.0.1:8000/api/token/` 에 요청을 보내면 아래와 같은 응답이 나옵니다
```json
{
  "access":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX3BrIjoxLCJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiY29sZF9zdHVmZiI6IuKYgyIsImV4cCI6MTIzNDU2LCJqdGkiOiJmZDJmOWQ1ZTFhN2M0MmU4OTQ5MzVlMzYyYmNhOGJjYSJ9.NHlztMGER7UADHZJlxNG0WSi22a2KaYSfd1S-AuT7lU",
  "refresh":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX3BrIjoxLCJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImNvbGRfc3R1ZmYiOiLimIMiLCJleHAiOjIzNDU2NywianRpIjoiZGUxMmY0ZTY3MDY4NDI3ODg5ZjE1YWMyNzcwZGEwNTEifQ.aEoAYkSJjoWH1boshQAaTkf8G3yn0kapko6HFRt7Rh4"
}
```

---

# 3. JWT란?

JWT는 문자열을 암호화하여 그 값으로 유저를 인증하는 방식입니다.  
이 문자열을 JWT토큰(JSON Web Token)이라고 합니다.  
JWT토큰은 열쇠와 같은 역할을 합니다.  
웹서버는 DB에 저장된 유저 정보를 확인하지 않고, JWT토큰만 확인하여 유저를 인증합니다.  

- `Access Token`: 웹 서비스를 이용하기 위한 열쇠
- `Refresh Token`: Access Token의 만료시간이 지나거나 유효하지 않을 때, 새로운 Access Token을 발급받기 위한 열쇠

## 3-1. JWT 구조
JWT는 3가지 문자열로 구성되어 있습니다.

- `Header`: 토큰의 타입(JWT), 암호화 알고리즘(HS256)
- `Payload`: 토큰에 담길 정보(유저 정보)
- `Signature`: 토큰의 서명

그런데 어떻게 DB조회 없이 저 문자열만 보고 유저를 인증할 수 있을까요?  
그것은 토큰을 만들 때 장고의 SECRET_KEY를 사용하여 "확인번호"를 붙이기 때문입니다.

**쉬운 비유로 설명하면:**
- 웹서버는 Access Token을 만들 때 SECRET_KEY로 "이 토큰이 진짜인지 확인할 수 있는 번호"를 계산해서 토큰 뒤에 붙입니다.
- 반대로, Access Token을 받으면 그 확인번호가 맞는지 SECRET_KEY로 다시 계산해서 확인합니다.
- 확인번호가 맞다면 "아, 이 토큰은 우리가 만든 것이구나"라고 인식하고 유저를 인증합니다.

**주의사항:**
SECRET_KEY를 아는 사람이라면 누구나 가짜 토큰을 만들 수 있습니다. 그래서 실제 서비스에서는 SECRET_KEY를 매우 안전하게 보관해야 합니다.

<img src="backend-1hour/images/django/jwt_1.jpeg" width="80%">
<img src="backend-1hour/images/django/jwt_2.jpeg" width="80%">
<img src="backend-1hour/images/django/jwt_3.jpeg" width="80%">