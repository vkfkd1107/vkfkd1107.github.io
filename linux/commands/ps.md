# ps (Process Status)

현재 실행되는 프로세스 목록을 출력하는 명령어입니다.

## 이런 상황에서 사용할 수 있습니다
### 1. 컴퓨터가 느려질 때
- **문제**: 컴퓨터가 갑자기 느려짐
- **해결**: `ps` 명령어로 어떤 프로그램이 CPU를 많이 사용하는지 확인
- **결과**: 문제가 되는 프로그램을 찾아서 종료

### 2. 메모리가 부족할 때
- **문제**: "메모리 부족"에러가 나옴
- **해결**: `ps` 명령어로 어떤 프로그램이 CPU를 많이 사용하는지 확인
- **결과**: 문제가 되는 프로그램을 찾아서 종료

### 3. 프로그램이 멈췄을 때
- **문제**: 프로그램이 응답하지 않고 멈춰있음
- **해결**: `ps` 명령어로 해당 프로그램이 실행 중인지 확인
- **결과**: 멈춘 프로그램을 강제로 종료할 수 있음

### 4. 서버 문제 해결할 때
- **문제**: 웹사이트가 접속되지 않음
- **해결**: `ps` 명령어로 웹 서버(nginx, apache)가 실행 중인지 확인
- **결과**: 서버가 죽었는지 살았는지 알 수 있음

## 사용법
```bash
>> ps
37423 ttys023    0:00.67 /bin/zsh --login
39619 ttys025    0:00.04 zsh (qterm)
39627 ttys026    0:00.22 /opt/homebrew/Cellar/zsh/5.9/bin/zsh --login
```

## 주요 옵션

### `aux` : 모든 프로세스 상세 정보
- 가장 자주 사용되는 옵션입니다
- 사용법: `ps aux`

```bash
>> ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  16804  1088 ?        Ss   Jan01   0:01 /sbin/init
nginx      123  0.0  0.1  12345  2345 ?        S    Jan01   0:05 nginx: master process
nginx      124  0.0  0.1  12345  2346 ?        S    Jan01   0:00 nginx: worker process
mysql      456  0.1  2.5 123456 45678 ?        Ssl  Jan01   1:23 /usr/sbin/mysqld
```

### `-u` : 특정 사용자의 프로세스 상세 정보
- 사용법: `ps -u [사용자명]`

```bash
>> ps -u gildong
USER   PID  %CPU %MEM      VSZ    RSS   TTY  STAT STARTED      TIME COMMAND
gildong 10764   0.0  0.0 408565168    128 s015  Ss   11:39AM   0:00.57 /opt/homebrew/Cellar/zsh/5.9/bin/zsh --login
gildong 10756   0.0  0.0 409895584   5328 s014  Ss+  11:39AM   0:53.37 zsh (qterm)
gildong  9416   0.0  0.0 408825264    832 s012  Ss   11:20AM   0:00.39 /opt/homebrew/Cellar/zsh/5.9/bin/zsh --login
```

### 각 항목이 의미하는 것
- **`USER`(프로세스 소유자)**: 누가 이 프로그램을 실행했는지 나타냅니다
- **`PID`(프로세스 ID)**: 프로그램의 고유 번호입니다
    - 문제가 있는 프로그램을 종료할 때 이 번호를 지정해서 종료시킬 수 있습니다
- **`%CPU`(CPU 사용률)**: 프로그램이 CPU를 얼마나 사용하고 있는지 나타냅니다
    - `50.0`: CPU의 절반을 사용 (문제 발생 가능성 높음)
- **`%MEM`(메모리 사용률)**: 컴퓨터의 메모리를 얼마나 사용하고 있는지 나타냅니다
    - `80.0`: 메모리의 80%를 사용 (메모리 부족 가능성 높음)
- **`VSZ`(가상 메모리 크기)**: 프로그램이 요청한 메모리 크기입니다
    - 실제로 사용하지 않아도 요청한 만큼 표기됩니다
- **`RSS`(실제 메모리 사용량)**: 프로그램이 실제로 사용하고 있는 메모리 크기입니다
    - 이 값이 높으면 메모리 부족 문제가 발생할 수 있습니다
- **`TTY`(터미널)**: 프로그램이 실행된 화면을 나타냅니다
    - `?`: 화면 없이 백그라운드에서 실행된 프로그램
    - `s015`: 터미널 번호
- **`STAT`(프로세스 상태)**: 프로그램의 현재 상태를 나타냅니다
    - `S`: 잠자고 있음 (대기 중)
    - `R`: 실행 중
    - `Z`: 좀비 (죽었지만 정리되지 않음)
- **`START`(시작 시간)**: 프로그램이 시작된 시간을 나타냅니다
- **`TIME`(CPU 사용 시간)**: 프로그램이 CPU를 얼마나 오래 사용했는지 나타냅니다
- **`COMMAND`(실행 명령어)**: 어떤 프로그램이 실행되고 있는지 나타냅니다
    - `/usr/sbin/mysqld`: MySQL 데이터베이스
    - `nginx`: 웹 서버

```bash
>> ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
mysql      456  0.1  2.5 123456 45678 ?        Ssl  Jan01   1:23 /usr/sbin/mysqld
```
위 명령어의 결과로 아래와 같은 정보를 확인할 수 있습니다.

- 프로세스: MySQL 데이터베이스 서버 (PID: 456)
- 리소스 사용량: CPU 0.1%, 메모리 2.5%
- 메모리: 가상 123MB, 실제 45MB 사용
- 실행 시간: 1시간 23분
- 상태: 백그라운드에서 대기 중
- 시작: 1월 1일
- 실행 명령어: /usr/sbin/mysqld


## 실무에서 자주 사용하는 방법

### 1. 문제가 있는 프로그램 찾기
Linux
```bash
#  cpu를 많이 사용하는 프로그램 상위 5개 출력
>> ps aux --sort=-%cpu | head -5

# 메모리를 많이 사용하는 프로그램 상위 5개 출력
>> ps aux --sort=-%mem | head -5
```

MacOS에서는 명령어가 다릅니다
```bash
#  cpu를 많이 사용하는 프로그램 상위 5개 출력
>> ps aux | sort -k3 -nr | head -5

# 메모리를 많이 사용하는 프로그램 상위 5개 출력
>> ps aux | sort -k4 -nr | head -5
```

### 2. 특정 프로그램 확인
```bash
# 웹 서버가 실행 중인지 확인
>> ps aux | grep nginx
nginx      123  0.0  0.1  12345  2345 ?        S    Jan01   0:05 nginx: master process
nginx      124  0.0  0.1  12345  2346 ?        S    Jan01   0:00 nginx: worker process
user      9999  0.0  0.0   1234   567 pts/0    S+   Jan01   0:00 grep nginx  # 이건 grep 프로그램 자체를 의미하는 것이므로 제외
# nginx 프로그램이 실행 중인 것을 확인

# 데이터베이스가 실행 중인지 확인
>> ps aux | grep mysql
user      9999  0.0  0.0   1234   567 pts/0    S+   Jan01   0:00 grep mysql
# grep 프로세스만 출력되므로 mysql 프로그램이 실행되고 있지 않음

```

### 3. 문제 해결
```bash
# 좀비 프로세스 확인 (시스템에 문제가 있는 프로그램)
>> ps aux | grep 'Z'

# 특정 프로그램의 PID 확인 (종료할 때 필요)
>> ps aux | grep 'nginx'
```
