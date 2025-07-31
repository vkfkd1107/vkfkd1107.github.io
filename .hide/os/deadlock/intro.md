# Deadlock(교착상태) 소개

> 이 퀴즈를 풀 수 있다면, 이 페이지는 건너뛰어도 됩니다.

#### 📝 사전 지식 확인 퀴즈

**1. 객관식: 교착상태란?**

<div class="quiz-container" data-quiz-id="1" data-correct-answer="c">
  <label><input type="radio" name="quiz1" value="a" onchange="resetQuizButton(this)"> 프로세스가 CPU를 너무 오래 사용하는 상태</label>
  <label><input type="radio" name="quiz1" value="b" onchange="resetQuizButton(this)"> 메모리 부족으로 프로그램이 멈춘 상태</label>
  <label><input type="radio" name="quiz1" value="c" onchange="resetQuizButton(this)"> 프로세스들이 서로 다른 자원을 점유하면서 무한정 대기하는 상태</label>
  <label><input type="radio" name="quiz1" value="d" onchange="resetQuizButton(this)"> CPU 성능을 너무 많이 써서 멈춘 상태</label>
  <button onclick="checkQuizAnswer(this)">답 확인</button>
  <div class="quiz-result"></div>
</div>z


---

## 교착상태란?

### 실생활 예시로 이해하기

**4방향 교차로에서의 교착상태**를 생각해보세요. 모든 방향에서 차량이 동시에 교차로에 진입하려고 할 때:

**결과**: 모든 차량이 서로의 차선을 놓지 않으면서 대기 → **교착상태 발생**

### 컴퓨터 시스템에서의 교착상태

실생활의 교차로처럼, **프로세스들이 서로 다른 자원을 점유하면서 무한정 대기하는 상태**를 **교착상태(Deadlock)**라고 합니다.

