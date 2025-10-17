# 주요 디렉토리

AWS EC2 인스턴스를 생성하면 제일 루트 디렉토리는 이렇게 된다
```bash
.
├── bin -> usr/bin
├── boot
├── dev
├── etc
├── home
├── lib -> usr/lib
├── lib64 -> usr/lib64
├── local
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin -> usr/sbin
├── srv
├── sys
├── tmp
├── usr
└── var
```

AWS에서 EC2를 생성하면, 각 폴더와 파일에 들어가서 무언가를 설정하고 설치하여 웹서버를 구축한다.  
또한, 웹서버에 문제가 생겼을 때, 각 폴더와 파일을 확인하여 문제를 해결한다.  
이것들을 하려면, 각 폴더와 파일에 대한 이해가 필요하다.
