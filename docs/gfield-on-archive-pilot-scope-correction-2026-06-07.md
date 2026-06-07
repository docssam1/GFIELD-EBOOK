# GFIELD-ON Archive 파일럿 범위 정정 메모

작성일: 2026-06-07  
중요도: 최상  
목적: GFIELD-ON 전체 프로그램, GFIELD-ON 본서비스, 콘텐츠 OS, 리포트 시스템, 관제 시스템과 섞이지 않도록 현재 채팅/작업의 정확한 범위를 고정한다.

---

## 1. 정확한 프로젝트명

이 채팅과 현재 작업의 정확한 범위는 다음이다.

```text
GFIELD-ON Archive 파일럿
```

이 작업은 GFIELD-ON 전체 플랫폼 완성본이 아니다.  
GFIELD-ON Archive 기능을 실험하기 위한 파일럿 작업이다.

---

## 2. 절대 섞으면 안 되는 것

아래 프로젝트/시스템과 이 작업을 같은 것으로 취급하지 말 것.

```text
GFIELD-ON 전체 플랫폼 본서비스
GFIELD Content OS 전체 설계
gfield-report / gfield report 3
gfield-hq 관제센터
Telegram Bot 운영 시스템
Cloud Run / Firebase 장기 운영 구조
전체 학원 홈페이지 리뉴얼
전체 자료실/콘텐츠 플랫폼
```

현재 작업은 위 시스템들의 일부 아이디어를 참고할 수는 있지만, 그 자체를 구현하는 작업이 아니다.

---

## 3. 현재 작업의 실제 목적

현재 목적은 다음이다.

```text
GFIELD-ON Archive 파일럿 안에서
HS THINKING BASIC 교재를 실제로 열고,
상단 강의 버튼을 누르면,
교재가 해당 쪽으로 자동 스크롤되고,
오른쪽에서 영상이 동시에 보이는
실제 학습 뷰어 흐름을 검증한다.
```

즉 핵심은 다음이다.

```text
Archive 입구
→ START
→ HS THINKING BASIC 실제 뷰어
→ 상단 강의 버튼
→ 교재 자동 스크롤
→ 오른쪽 영상 동시 보기
```

---

## 4. 현재 주력 파일

현재 주력 테스트 파일은 다음이다.

```text
books/hs-thinking-basic/viewer-v2.html
```

확인 URL:

```text
https://docssam1.github.io/GFIELD-EBOOK/books/hs-thinking-basic/viewer-v2.html
```

이 파일은 기존 `viewer.html`을 대체하기 전 검증용이다.

---

## 5. 기존 인수인계서 해석 주의

기존 문서:

```text
docs/gfield-on-viewer-handoff-2026-06-07.md
```

위 문서에서 `GFIELD-ON`, `플랫폼`, `홈`, `뷰어`라고 표현된 부분은 모두 다음 의미로 제한해서 읽는다.

```text
GFIELD-ON Archive 파일럿 범위 안의 홈/뷰어/테스트 구조
```

즉, 위 문서를 GFIELD-ON 전체 본서비스 설계서로 해석하면 안 된다.

---

## 6. 실제 우선순위

1순위:

```text
viewer-v2.html 실제 동작 확인
```

2순위:

```text
상단 강의 버튼 → 교재 page node 자동 스크롤
```

3순위:

```text
오른쪽 영상 패널 동시 보기
```

4순위:

```text
Archive 입구의 START 버튼을 viewer-v2로 연결
```

5순위:

```text
admin lectureButtons / JSON 매핑 연결
```

---

## 7. 당장 하지 말 것

```text
전체 GFIELD-ON 본서비스 설계로 확장하지 말 것
새 홈페이지를 또 만들지 말 것
스마트 E-BOOK 독립 랜딩 페이지를 또 만들지 말 것
기존 viewer.html을 바로 갈아엎지 말 것
admin 전체 리팩터링하지 말 것
Cloud Run/Firebase/API 구조로 먼저 넘어가지 말 것
```

---

## 8. 최종 고정 문장

앞으로 이 작업을 설명할 때는 반드시 다음처럼 표현한다.

```text
GFIELD-ON Archive 파일럿의 HS THINKING BASIC 실제 뷰어 테스트
```

줄여서 말할 때도 다음처럼 말한다.

```text
Archive 파일럿 뷰어
```

`GFIELD-ON 전체 플랫폼`, `본서비스`, `전체 홈페이지`라고 부르지 않는다.
