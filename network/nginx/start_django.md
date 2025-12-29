# 백엔드 서버 붙이기
nginx에 백엔드 서버를 붙이고, 실제로 동작하는지 확인해보겠습니다.  
백엔드 서버는 django 서버를 사용하겠습니다.

# 1. python 모듈 설치
```
sudo apt-get update
sudo apt-get install virtualenv
```

# 2. 가상환경 생성 및 django 설치

```
cd /home/ubuntu
mkdir django_project
cd django_project
python3 -m venv venv
source venv/bin/activate
```

# 3. django 프로젝트 생성 및 실행
```
pip install django
django-admin startproject mysite
cd mysite
python3 manage.py runserver
```

이 단계까지 완료하면, 장고 서버가 실행됩니다.  
아직 ec2내부에서만 설치하고 외부에서 접근할 수 있게 설정하지 않았기 때문에 아직은 nginx 기본 index 페이지만 노출됩니다.

# 4. nginx 설정
장고 서버를 종료하고 nginx 설정 파일을 수정합시다.
```
sudo vim /etc/nginx/sites-available/default
```
```nginx
server {
    listen 80;
    server_name localhost;
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
    }
}
```
**`proxy_pass http://localhost:8000;`**
- 지시어 이름: proxy_pass
- 인수: http://127.0.0.1:8000
    - 클라이언트의 요청을 127.0.0.1:8000 포트로 전달하는 설정입니다.
    - 즉, 클라이언트의 요청을 장고 서버로 전달하는 설정입니다.
**`proxy_set_header Host $host;`**
- 지시어 이름: proxy_set_header
- 인수: Host $host
    - Django Allowed Hosts 검증을 위해 django 서버로 원본 도메인명을 전달합니다.


# 5. nginx 재시작
nginx.conf, sites-available/* 등의 설정파일을 수정하면 변경사항을 적용하기 위해 리로드 또는 재시작이 필요합니다
```
sudo systemctl restart nginx
```

# 6. 확인
이제 다시 mysite 폴더로 이동해서 장고 서버를 실행합니다.
```
cd /home/ubuntu/django_project/mysite
python3 manage.py runserver
```

내 인스턴스 퍼블릭 ip로 접속하면 장고 시작 페이지가 노출됩니다.

<img src="/network/nginx/images/server_with_nginx.png" width="80%">  

---

다음 장은 Admin 페이지에 접속하고 static 파일을 서빙하는 방법을 알아보겠습니다.
[Admin 페이지 접속하기](network/nginx/django_admin.md)
