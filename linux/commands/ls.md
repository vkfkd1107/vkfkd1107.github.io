# ls

목록을 출력하는 명령어입니다.

## 사용법
`ls` 명령어는 현재 디렉토리의 파일과 디렉토리 목록을 출력합니다.

```bash
# 모든 디렉토리 내용 출력
>> ls
 _sidebar.md   aws   index.html   linux   README.md

# 특정 디렉토리 내용만 출력
>> ls aws
 eb

# 디렉토리만 출력
>> ls -d */ 
 aws/   linux/

# 특정 확장자 파일만 출력
>> ls *.md
 _sidebar.md   README.md

```

## 옵션
- ls 명령어 뒤에 옵션을 붙여서 여러 형태로 출력할 수 있습니다.
- 사용법: `ls [파일명] [옵션]` or `ls [옵션] [파일명]`

### `-l` : 자세한 정보 출력
```bash
# 모든 디렉토리 내용 출력
>> ls -l
drwxr-xr-x gildong staff  96 B Thu Jul 24 19:36:25 2025  aws
drwxr-xr-x gildong staff 320 B Sat Apr 19 11:49:14 2025  chat
drwxr-xr-x gildong staff  96 B Thu Jul 24 18:46:56 2025  git-blog

```
`drwxr-xr-x`: 접근 권한
`gildong`: 소유자
`staff`: 그룹
`96 B`: 파일 크기
`Thu Jul 24 19:36:25 2025`: 수정 시간
`aws`: 파일명

### `-a` : 숨김 파일 포함
```bash
>> ls -a
.
..
 aws
 chat
 git-blog
```
`.` : 현재 디렉토리
`..` : 상위 디렉토리


### 모든 옵션은 조합해서 사용할 수 있습니다.
```bash
# 숨김 파일 포함 자세한 정보 출력
>> ls -al
drwxr-xr-x gildong staff  96 B Thu Jul 24 19:36:25 2025  .
drwxr-xr-x gildong staff 320 B Sat Apr 19 11:49:14 2025  ..
drwxr-xr-x gildong staff  96 B Thu Jul 24 19:36:25 2025  aws
drwxr-xr-x gildong staff 320 B Sat Apr 19 11:49:14 2025  chat
drwxr-xr-x gildong staff  96 B Thu Jul 24 18:46:56 2025  git-blog

>> ls -ald */                                     
drwxr-xr-x gildong staff  96 B Thu Jul 24 19:36:25 2025  aws/
drwxr-xr-x gildong staff 320 B Sat Apr 19 11:49:14 2025  chat/
drwxr-xr-x gildong staff  96 B Thu Jul 24 18:46:56 2025  git-blog/
```
