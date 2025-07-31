# 프로세스 우선순위

프로세스는 어떤 기준으로 실행될까요?  
각 프로세스는 우선순위를 가지고 있으며,  
운영체제는 이 우선순위를 바탕으로 높은 프로세스에 먼저 CPU를 할당합니다.
---

**프로세스는 사용하는 자원에 따라 크게 두 가지로 나눌 수 있습니다.**

- **CPU 집중 프로세스**: 대부분의 시간을 복잡한 연산 작업에 사용하며, CPU를 많이 필요로 합니다.
  - 예시: 영상 인코딩, 암호화, 과학 계산 등
  - CPU 집중 프로세스도 실행과 대기 상태를 반복합니다. 예를 들어, 영상 인코딩을 할 때:
    1. CPU가 영상 데이터를 계산해서 처리합니다 (실행 상태)
    2. 처리된 데이터를 하드디스크에 저장합니다 (대기 상태)
    3. 저장이 끝나면 다시 다음 영상 데이터를 처리합니다 (실행 상태)
  - 이렇게 CPU가 열심히 일하는 시간이 대기하는 시간보다 훨씬 깁니다.

- **입출력 집중 프로세스**: 대부분의 시간을 입출력 작업(예: 파일 읽기/쓰기, 네트워크 통신 등)에 사용합니다.
  - 예시: 파일 복사, 데이터베이스에서 데이터 읽기, 웹 서버 등
  - 파일 쓰기 작업을 예로 들면, 컴퓨터는 파일을 쓸 때마다 하드디스크에 데이터를 저장하고, 다시 읽어오는 작업을 반복합니다. 마치 우리가 노트에 글을 쓰고, 다시 읽어보는 것처럼요! 이 과정에서 CPU는 잠시 쉬고, 하드디스크가 열심히 일하게 됩니다.
  - 입출력 집중 프로세스도 실행과 대기 상태를 반복합니다. 예를 들어, 메모장에 글을 쓸 때:
    1. CPU가 키보드 입력을 받아서 처리합니다 (실행 상태)
    2. 입력한 내용을 화면에 보여줍니다 (실행 상태)
    3. 저장 버튼을 누르면 하드디스크에 데이터를 저장합니다 (대기 상태)
    4. 저장이 끝나면 다시 CPU가 일을 할 준비를 합니다 (실행 상태)
  - 이렇게 하드디스크가 일하는 시간이 CPU가 일하는 시간보다 훨씬 깁니다.

| 구분           | CPU 집중 프로세스           | 입출력 집중 프로세스         |
|----------------|----------------------------|-----------------------------|
| 주요 작업      | 연산, 계산                 | 파일 읽기/쓰기, 네트워크 등  |
| CPU 사용 시간  | 길다                        | 짧다                        |
| I/O 대기 시간  | 짧다                        | 길다                        |
| 예시           | 암호화, 영상 인코딩         | 파일 복사, 데이터베이스 쿼리 |

## 퀴즈: 프로세스 우선순위

### 1. 다음 중 CPU 집중 프로세스의 특징이 아닌 것은?

<div class="quiz-container" data-quiz-id="1" data-correct-answer="b">
  <label><input type="radio" name="quiz1" value="a"> 대부분의 시간을 복잡한 연산 작업에 사용한다</label><br>
  <label><input type="radio" name="quiz1" value="b"> 입출력 대기 시간이 길다</label><br>
  <label><input type="radio" name="quiz1" value="c"> 영상 인코딩, 암호화 등이 예시이다</label><br>
  <label><input type="radio" name="quiz1" value="d"> CPU 사용 시간이 길다</label><br>
  <button onclick="checkQuizAnswer(this)">답 확인</button>
  <div class="quiz-result"></div>
</div>

### 2. 입출력 집중 프로세스에 대한 설명으로 올바른 것은?

<div class="quiz-container" data-quiz-id="2" data-correct-answer="b">
  <label><input type="radio" name="quiz2" value="a"> CPU 사용 시간이 길다</label><br>
  <label><input type="radio" name="quiz2" value="b"> 파일 읽기/쓰기, 네트워크 통신 등에 많은 시간을 사용한다</label><br>
  <label><input type="radio" name="quiz2" value="c"> 입출력 대기 시간이 짧다</label><br>
  <label><input type="radio" name="quiz2" value="d"> 암호화 작업이 대표적인 예시이다</label><br>
  <button onclick="checkQuizAnswer(this)">답 확인</button>
  <div class="quiz-result"></div>
</div>

### 3. 프로세스 우선순위에 대한 설명으로 올바른 것은?

<div class="quiz-container" data-quiz-id="3" data-correct-answer="c">
  <label><input type="radio" name="quiz3" value="a"> 모든 프로세스는 동일한 우선순위를 가진다</label><br>
  <label><input type="radio" name="quiz3" value="b"> 우선순위는 변경할 수 없다</label><br>
  <label><input type="radio" name="quiz3" value="c"> 높은 우선순위 프로세스가 먼저 CPU를 할당받는다</label><br>
  <label><input type="radio" name="quiz3" value="d"> 우선순위는 메모리 사용량에만 영향을 받는다</label><br>
  <button onclick="checkQuizAnswer(this)">답 확인</button>
  <div class="quiz-result"></div>
</div>
