# 리눅스 기본 명령어

개발자가 꼭 알아야 하는 핵심 명령어들입니다.

## 파일 및 디렉토리 관리

- [ls - 파일 목록](/linux/commands/ls.md)
- `cd` - 디렉토리 이동
- `pwd` - 현재 위치
- `mkdir -p` - 디렉토리 생성 (상위 디렉토리도 생성)
- `rm -rf` - 파일/디렉토리 삭제
- `cp -r` - 디렉토리 복사
- `mv` - 파일 이동/이름 변경
- `find` - 파일 검색
- `rsync` - 파일 동기화
- `tar` - 백업/복원

## 파일 내용 확인

- `cat` - 파일 내용 출력
- `less` - 파일 내용 페이지 단위로 보기
- `head` - 파일 앞부분 출력
- `tail` - 파일 끝부분 출력
- `vim/nano` - 텍스트 에디터
- `diff` - 파일 비교


## 시스템 모니터링

- `top/htop` - 실시간 시스템 상태
- `ps aux` - 프로세스 목록
- `df -h` - 디스크 사용량
- `free -h` - 메모리 사용량
- `uptime` - 시스템 가동 시간
- `iostat` - I/O 통계
- `vmstat` - 가상 메모리 통계
- `sar` - 시스템 활동 리포트

## 네트워크 관리

- `netstat -tuln` - 열린 포트 확인
- `lsof -i` - 네트워크 연결 상태
- `ss` - 소켓 통계
- `ping` - 연결 테스트
- `traceroute` - 경로 추적
- `curl` - HTTP 요청/응답 확인
- `wget` - 파일 다운로드
- `nmap` - 포트 스캔

## 로그 관리

- `tail -f` - 실시간 로그 모니터링
- `journalctl` - systemd 로그
- `dmesg` - 커널 로그
- `grep` - 로그 필터링
- `awk` - 로그 분석
- `sed` - 로그 편집

## 프로세스 관리

- `kill -9` - 프로세스 강제 종료
- `pkill` - 프로세스명으로 종료
- `nohup` - 백그라운드 실행
- `screen/tmux` - 세션 관리
- `systemctl` - 서비스 관리
- `service` - 서비스 시작/중지

## 보안 및 권한

- `chmod` - 파일 권한 변경
- `chown` - 소유자 변경
- `sudo` - 관리자 권한으로 실행
- `su` - 사용자 전환
- `passwd` - 비밀번호 변경
- `ssh-keygen` - SSH 키 생성

## 원격 관리

- `ssh` - 원격 접속
- `scp` - 원격 파일 복사
- `rsync` - 원격 동기화
- `sftp` - 파일 전송
- `ssh-copy-id` - SSH 키 등록

## 패키지 관리

- `apt/yum/dnf` - 패키지 설치 (Linux)
- `brew` - 패키지 설치 (macOS)
- `dpkg/rpm` - 패키지 관리
- `docker` - 컨테이너 관리
- `kubectl` - 쿠버네티스 관리

## 웹 서버 관리

- `nginx -t` - 설정 파일 검증
- `apache2ctl` - Apache 관리
- `certbot` - SSL 인증서 관리
- `openssl` - SSL/TLS 관리
- `curl -I` - HTTP 헤더 확인

## 데이터베이스 관리

- `mysql` - MySQL 접속
- `psql` - PostgreSQL 접속
- `redis-cli` - Redis 접속
- `mongo` - MongoDB 접속
- `pg_dump` - PostgreSQL 백업

## 성능 분석

- `strace` - 시스템 콜 추적
- `ltrace` - 라이브러리 콜 추적
- `perf` - 성능 분석
- `valgrind` - 메모리 디버깅
- `tcpdump` - 네트워크 패킷 분석

## 개발 도구

- `git` - 버전 관리
- `make` - 빌드 도구
- `gcc/g++` - C/C++ 컴파일러
- `jq` - JSON 처리
- `cron` - 자동 백업 스케줄링