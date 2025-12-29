# gunicorn 알아보기
이전 챕터에서 django에 nginx를 붙이고 실행했습니다.  
하지만 운영서버를 배포할때는 gunicorn을 사용한다고 했습니다.  
왜 그럴까요?  
이 챕터에서는 gunicorn이 뭔지, 어떤 역할을 하는지 알아보겠습니다  

# 1. gunicorn이란?
gunicorn은 django를 여러 워커로 동시 실행하는 서버 프로그램입니다.  
<img src="/network/nginx/images/nginx_django_connection.png" width="80%">  
이 그림은 이전에 실습한 nginx+django 연결 구조입니다.  
왜 이 구조로는 운영서버로 부적합한걸까요?
<img src="/network/gunicorn/images/multi_request.png" width="80%">  
그림처럼 다수의 유저가 요청을 보내면 어떻게 될까요?  
runserver로는 한 번에 하나의 요청만 처리할 수 있기때문에 그림의 유저는 각각의 요청이 완료되기를 기다려야 합니다.

반면 gunicorn은 여러 파이썬 프로세스를 동시에 실행하여 다수의 요청을 처리할 수 있습니다.
<img src="/network/gunicorn/images/multi_django.png" width="80%">  
이 그림처럼 gunicorn은 여러 파이썬 프로세스를 동시에 실행해서, 동시에 여러 유저의 요청을 처리할 수 있습니다.
1. 유저가 요청을 보냅니다
2. nginx가 요청을 받아, gunicorn에 전달합니다
3. gunicorn이 요청을 받아서 처리할 django 애플리케이션에 전달합니다