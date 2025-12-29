# Admin 페이지 접속하기

장고는 관리자 페이지를 제공하는 프레임워크입니다.  
이 장고 관리자 페이지에 접속하고, static 파일을 서빙하는 방법을 알아보겠습니다.  

### 1. `migrate` 실행
DB migration을 실행하여 데이터베이스를 적용합니다.
```
python3 manage.py makemigrations
python3 manage.py migrate
```

### 2. `createsuperuser` 실행
어드민 페이지에 접속하기 위해 슈퍼유저를 생성합니다.
```
python3 manage.py createsuperuser
```

### 3. 내 인스턴스 퍼블릭 ip로 접속
내 인스턴스 퍼블릭 ip로 접속하면 장고 관리자 페이지가 노출됩니다.
<img src="/network/nginx/images/django_admin.png" width="80%">  

### 4. DEBUG 모드 비활성화
프로덕션환경에서는 보안을 위해, DEBUG 모드를 비활성화해야합니다.
활성화한다면, 아래와 같은 문제가 발생할 수 있습니다.
- 에러 페이지에 민감한 정보 노출
- Django 내부 구조 노출
- 성능 저하
- 보안 취약점 증가

settings.py 파일을 열어서 DEBUG 값을 False로 변경합니다.
```python
DEBUG = False
```
이렇게 변경한 후, 시크릿창에서 기본 퍼블릭아이피 주소로 접속하면 장고의 시작화면이 아닌 404 에러가 발생합니다.  
그 이유는, urls.py에 admin path만 등록되어 있기 때문입니다.  
<img src="/network/nginx/images/django_admin_error.png" width="80%">  
또한 시크릿창에서 어드민 페이지를 다시 접속해보면 화면이 깨진 것을 확인할 수 있습니다.  

static 파일을 서빙하기 위해, 별도의 설정을 해야합니다.


### 5. settings.py에 static 경로 설정
settings.py 파일을 열어서 static 경로를 설정합니다.
```python
STATIC_URL = '/static/'
STATIC_ROOT = '/var/www/staticfiles/'
```

### 6. collectstatic 실행

```bash
mkdir -p /var/www/staticfiles/
sudo chown -R www-data:www-data /var/www/staticfiles/
python3 manage.py collectstatic
sudo chown -R www-data:www-data /var/www/staticfiles/
```
이렇게 실행하면, static 파일을 staticfiles 폴더에 수집할 수 있습니다.
```
static/
├── admin/
├── css/
├── js/
├── media/
└── robots.txt
```

### 7. nginx 설정
nginx 설정 파일을 열어서 static 파일을 서빙할 수 있도록 설정합니다.
```nginx
server {
    listen 80;
    server_name localhost;
    location /static/ {
        alias /var/www/staticfiles/;
    }
}
```
`nginx systemctl reload nginx`

### 8. 확인
퍼블릭아이피 주소로 접속하면 장고의 시작화면이 노출됩니다.  
<img src="/network/nginx/images/django_admin_success.png" width="80%">  