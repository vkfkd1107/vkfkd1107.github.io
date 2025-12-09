# 간단한 실습
ec2에 nginx를 설치하고, 간단한 실습을 해보겠습니다.
사전준비: ec2를 생성하고, ssh로 접속합니다.

# 1. nginx 설치
```bash
sudo apt-get update
sudo apt-get install nginx
```
위 명령어를 실행하여 nginx를 설치합니다.  <br>
<img src="/network/nginx/images/install_nginx.png" width="80%">  
잘 설치하면, 퍼블릭 ip로 접속했을 때 위와같은 nginx 페이지가 나옵니다.  
nginx 패키지는 설치하면서 자동으로 활성화, 실행되기 때문에 바로 nginx 페이지가 노출됩니다

# 2. html 파일 수정해보기
`sudo vim /var/www/html/index.nginx-debian.html` 명령어를 사용하여 index.html 파일을 수정합니다.
<img src="/network/nginx/images/edit_html.png" width="80%">  
파일을 수정하고 나서, 퍼블릭 ip로 접속했을 때 위와같은 페이지가 나옵니다.  

# 3. 새로운 html 파일 생성해보기
`sudo vim /var/www/html/index.html` 명령어를 사용하여 index.html 파일을 생성합니다.
<img src="/network/nginx/images/create_index.png" width="80%">  
파일을 생성하고 나서, 퍼블릭 ip로 접속했을 때 위와같은 페이지가 나옵니다.  


그런데 기존의 index.nginx-debian.html 파일을 보여주다가 왜 index.html 파일을 보여주는걸까요?  
그 이유는 nginx 설정 파일에서 index.html 파일이 없으면 index.nginx-debian.html 파일을 보여주도록 설정되어 있기 때문입니다.

## 3-1. nginx 설정파일 확인해보기
`cat /etc/nginx/sites-available/default` 명령어를 사용하여 nginx 설정 파일을 확인합니다.

```nginx
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}
}
```
**`index index.html index.htm index.nginx-debian.html;`**  
### 구조
- 지시어 이름: index
- 인수 (여러 개 가능): index.html, index.htm, index.nginx-debian.html
    - 왼쪽부터 순차적으로 존재여부를 검사해서 첫 번째로 찾은 파일을 응답 본문으로 사용합니다.

### 동작예시  
1. 클라이언트가 사이트로 접속  
2. nginx가 root 경로 (/var/www/html)에서 보여줄 파일 찾음  
    2-1. /var/www/html/index.html 파일이 있으면 그것을 반환  
    2-2. 없으면 /var/www/html/index.htm 찾음  
    2-3. 없으면 /var/www/html/index.nginx-debian.html 찾음  
    2-4. 모두 없으면 404 오류하거나 규칙따라 처리  