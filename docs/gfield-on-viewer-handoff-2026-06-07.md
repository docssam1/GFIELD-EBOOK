# GFIELD-ON / HS THINKING BASIC 뷰어 작업 인수인계서

작성일: 2026-06-07  
목적: 같은 내용을 다시 새로 작업하지 않도록, 원장님과의 대화에서 확정된 방향과 현재까지 진행한 파일을 정리한다.

---

## 1. 최종 방향 한 줄 결론

GFIELD-ON의 핵심은 홈페이지 장식이 아니라 **START → 실제 HS THINKING BASIC 교재 뷰어 → 상단 강의 버튼 → 교재 자동 스크롤 + 오른쪽 영상 동시 보기**이다.

기존 `viewer.html`은 바로 갈아엎지 않고, `books/hs-thinking-basic/viewer-v2.html`에서 먼저 테스트한 뒤 안정화되면 START 연결을 교체한다.

---

## 2. 절대 다시 오해하지 말 것

### 잘못된 방향

- 스마트 E-BOOK만 덩그러니 보이는 독립 홈페이지를 새로 만드는 것
- 왼쪽 세로 강의 메뉴 중심으로 새 뷰어를 만드는 것
- PDF iframe을 계속 주력으로 쓰는 것
- 강의 버튼 클릭 때마다 뷰어를 새로 열거나 iframe을 다시 로딩하는 것
- 책과 영상을 분리해서 보이게 하는 것
- 기존 `viewer.html`을 바로 전체 리라이트하는 것
- admin을 먼저 크게 고치는 것

### 맞는 방향

- 기존 플랫폼 흐름 안에 자연스럽게 붙인다.
- `gfield-on-archive-preview.html`은 입구/허브다.
- 실제 학습은 `viewer-v2.html`에서 진행한다.
- 상단에 강의 버튼이 있어야 한다.
- 본문에서 책과 영상을 동시에 봐야 한다.
- 강의 버튼 클릭 시 같은 뷰어 안에서 교재만 자동 스크롤된다.
- 오른쪽 영상 패널은 해당 강의 영상으로 바뀐다.
- admin은 당장은 기존 `lectureButtons` 구조를 유지한다.

---

## 3. 최종 뷰어 UI 구조

```text
┌──────────────────────────────────────────────────────────────┐
│ GFIELD E-BOOK | HS THINKING BASIC | 학생명 | 질문 | 책만 보기 │
├──────────────────────────────────────────────────────────────┤
│ [1단원 개념] [1단원 필수] [2단원 개념] [2단원 필수] ...       │
├──────────────────────────────────────┬───────────────────────┤
│                                      │ 연결 영상              │
│      HS THINKING BASIC 교재           │ YouTube iframe         │
│      page node 기반 자동 스크롤        │ AI-DOC 질문            │
│                                      │ 추가 자료 / 답안 자료   │
└──────────────────────────────────────┴───────────────────────┘
```

핵심 원칙:

```text
상단 = 강의/학습 버튼
가운데 = 책
오른쪽 = 현재 선택된 영상과 질문 도구
```

---

## 4. 현재 저장소

Repository:

```text
docssam1/GFIELD-EBOOK
```

GitHub Pages 기본 주소:

```text
https://docssam1.github.io/GFIELD-EBOOK/
```

---

## 5. 현재까지 생성/변경한 주요 파일

### 5.1 실제 뷰어 핵심 파일

```text
books/hs-thinking-basic/viewer-v2.html
```

현재 확인 URL:

```text
https://docssam1.github.io/GFIELD-EBOOK/books/hs-thinking-basic/viewer-v2.html
```

학생명 테스트:

```text
https://docssam1.github.io/GFIELD-EBOOK/books/hs-thinking-basic/viewer-v2.html?student=관호
```

현재 구현 내용:

- 기존 `viewer.html`은 건드리지 않음.
- `viewer-v2.html`을 새로 생성.
- 상단 강의 버튼 바 구현.
- 가운데에 `thinking-basic.html`을 iframe으로 로드.
- iframe 내부의 `.page` 요소를 읽어서 page id를 자동 부여하려고 함.
- 오른쪽에 YouTube 영상 패널 구현.
- 상단 버튼 클릭 시:
  - 오른쪽 영상 변경
  - 교재의 해당 page node로 `scrollIntoView` 시도
- AI-DOC 질문 버튼은 현재 alert 초안 형태.
- 추가 자료 / 답안 자료는 아직 placeholder.

주의:

현재 `viewer-v2.html`은 테스트 버전이다. 실제로 iframe 내부 HTML 제어가 GitHub Pages 동일 출처에서 정상 작동하는지 브라우저 확인이 필요하다.

---

### 5.2 강의 매핑 샘플

```text
data/hs-thinking-basic-lecture-map-sample-v1.json
```

확인 URL:

```text
https://github.com/docssam1/GFIELD-EBOOK/blob/main/data/hs-thinking-basic-lecture-map-sample-v1.json
```

역할:

- 예전 뷰어의 영상 버튼 정보를 가져와 현재 교재 기준으로 쪽수 보정한 샘플.
- 아직 admin과 자동 연결되지는 않음.
- 나중에 `viewer-v2.html`이 이 JSON 또는 admin config를 읽도록 바꾸면 된다.

---

### 5.3 실험용 플랫폼 홈 파일들

아래 파일들은 실험용이다. 최종 주력으로 오해하지 말 것.

```text
gfield-on-platform-home-v1.html
gfield-on-platform-home-v2-integrated.html
gfield-on-basic-viewer-test.html
```

역할:

- 홈페이지/플랫폼 홈 아이디어 확인용.
- 원장님 요구와 최종 방향은 여기보다 `viewer-v2.html` 쪽이 우선이다.
- 단, 나중에 홈 화면에 뉴스/유튜브/인사이트/AI-DOC 홍보 요소를 흡수할 때 참고 가능.

---

## 6. 현재 BASIC 교재 자료

자료실/Drive에서 확인된 파일:

```text
HS 대비 응용 개념서 - THINKING BASIC.html
HS 대비 응용 개념서 - THINKING BASIC.pdf
thinking-basic.pdf
```

GitHub viewer 기준 기존 링크:

```text
https://docssam1.github.io/GFIELD-EBOOK/books/hs-thinking-basic/viewer.html
https://docssam1.github.io/GFIELD-EBOOK/books/hs-thinking-basic/viewer.html?source=./thinking-basic.html
https://docssam1.github.io/GFIELD-EBOOK/books/hs-thinking-basic/viewer.html?source=./thinking-basic.pdf
```

새 v2 기준:

```text
https://docssam1.github.io/GFIELD-EBOOK/books/hs-thinking-basic/viewer-v2.html
```

---

## 7. 예전 뷰어에서 가져온 영상/버튼 데이터

현재 확정 샘플:

| 그룹 | 버튼명 | 보정 쪽 | 영상 |
|---|---:|---:|---|
| 문제푸는 방법 찾기(1) | 1단원 개념 | 2쪽 | https://youtu.be/20OIED2hezI?si=nooj_2XXt9oRVDcs |
| 문제푸는 방법 찾기(1) | 1단원 필수유형 | 5쪽 | https://youtu.be/20OIED2hezI?si=Eppn2W_4Joe-QZWE&t=1875 |
| 문제푸는 방법 찾기(2) | 2단원 개념 | 13쪽 | https://youtu.be/HtSd564pCpw?si=15Inv0cVtonKn_ww |
| 문제푸는 방법 찾기(2) | 2단원 필수유형 | 18쪽 | https://youtu.be/hDPKx7cQtIw |
| 규칙 찾아 해결하기(1) | 3단원 개념 | 26쪽 | https://youtu.be/8Wz-g95UGVg?si=z-12_yWB0TYpaAFP |
| 규칙 찾아 해결하기(1) | 3단원 필수유형 | 30쪽 | https://youtu.be/PYHnn1x2dlM?si=1e4X7QOs-TuwEDa6&t=843 |

보정 이유:

- 1단원 개념: 예전 1쪽 → 현재 실제 개념 유형 시작 2쪽
- 2단원 개념: 예전 12쪽 → 현재 실제 개념 유형 시작 13쪽
- 3단원 개념: 예전 15쪽 → 현재 실제 개념 유형 시작 26쪽
- 필수유형 쪽수는 현재 샘플 기준 그대로 사용

---

## 8. 기술 판단

### 8.1 PDF iframe은 주력으로 쓰지 않는다

PDF iframe은 다음 한계가 있다.

- 특정 페이지/중간 위치 자동 스크롤이 불안정함.
- 브라우저마다 PDF 렌더러 동작이 다름.
- 책과 영상 동시 보기 상태 관리가 약함.
- 강의 버튼 → 교재 위치 이동 → 영상 교체 흐름에 적합하지 않음.

따라서 PDF iframe은 원본 보기/인쇄용 보조로 두고, 실제 학습 뷰어는 page node 기반으로 간다.

### 8.2 우선 HTML page node

우선순위:

1. HTML page node
2. image page node
3. PDF iframe

HTML page node 장점:

- `scrollIntoView`가 자연스럽다.
- page id 부여가 쉽다.
- 영상/AI-DOC/자료 연결이 쉽다.
- 텍스트 구조 유지 가능.

image page node는 HTML 레이아웃이 계속 깨질 때 전환한다.

---

## 9. HTML/PDF/이미지 파이프라인 방향

장기 구조:

```text
A4 HTML 원본
↓
인쇄용 PDF 생성
↓
필요 시 페이지별 이미지 생성
↓
book-manifest.json 생성
↓
viewer가 page node 또는 image node를 읽음
```

중요 판단:

- 브라우저 `window.print()` 중심이 아니라, HTML → PDF 생성 파이프라인으로 가야 함.
- PDF 저장/다운로드 시 워터마크를 생성 시점에 박는 구조가 맞음.
- 학생별 워터마크가 실제 PDF 파일에 박혀야 의미가 있음.
- 화면 위 오버레이 워터마크는 UX/캡처 억제 정도의 의미만 있음.

---

## 10. 워터마크 / 승인 / API 관련 결정

### 승인

학생이 들어올 때마다 원장님이 승인하면 안 된다.

정답 구조:

```text
1회 승인 목록 등록
→ 학생 이름 확인
→ 이후 자동 입장
```

### API

API는 필수가 아니다.

현재 단계:

```text
로컬 Python 변환기 + GitHub/Drive 업로드 + 정적 viewer
```

나중에 버튼 하나로 자동 생성하려면:

```text
웹 버튼
→ API
→ Cloud Run/Firebase/Python 변환 엔진
```

### Python 역할

- PDF → 이미지 분해
- HTML → PDF 생성
- PDF 워터마크 삽입
- manifest 생성
- 썸네일 생성

API는 그 Python을 호출하는 입구일 뿐이다.

---

## 11. admin 구조 판단

당장 admin을 크게 고치지 않는다.

기존 `lectureButtons` 구조를 유지한다.

현재/권장 필드:

```text
group
label
url 또는 videoUrl
viewerPage
scrollTarget
viewerOffset
downloadUrl
```

나중에 추가 가능:

```text
answerUrl
materialType
order
```

현재는 `url`을 영상 URL로 써도 된다. 리네이밍은 안정화 후.

---

## 12. 다음 작업 순서

### 1단계: viewer-v2 동작 확인

확인 URL:

```text
https://docssam1.github.io/GFIELD-EBOOK/books/hs-thinking-basic/viewer-v2.html
```

체크:

- HTML 교재가 가운데에 정상 표시되는가?
- 상단 버튼이 보이는가?
- 버튼 클릭 시 오른쪽 영상이 바뀌는가?
- 버튼 클릭 시 교재가 해당 쪽으로 이동하는가?
- 책과 영상이 동시에 보이는가?
- 책만 보기 버튼이 작동하는가?

### 2단계: page id 안정화

`thinking-basic.html` 안의 `.page`마다 명시적 id를 넣는 것이 더 안전하다.

예:

```html
<div class="page content-page" id="gfield-page-013" data-book-page="13">
```

현재 viewer-v2는 iframe 로드 후 footer 번호를 읽어 id를 자동 부여하려고 한다. 이 방식이 불안하면 원본 HTML에 직접 id를 박는 방식으로 바꾼다.

### 3단계: START 연결 교체

안정화 후 `gfield-on-archive-preview.html`의 START를 다음으로 연결한다.

```text
books/hs-thinking-basic/viewer-v2.html?book=hs-thinking-basic
```

또는 학생명 포함:

```text
books/hs-thinking-basic/viewer-v2.html?book=hs-thinking-basic&student=학생명
```

### 4단계: admin config 연결

하드코딩된 `LESSONS`를 제거하고, 다음 중 하나로 공급한다.

- `data/hs-thinking-basic-lecture-map-sample-v1.json`
- `data/archive-config.json`
- localStorage의 `gfield_archive_admin_config`

---

## 13. Codex/Claude/Gemini에게 줄 핵심 구현 지시

```text
Do not create another homepage-only page.
The priority is the actual HS THINKING BASIC viewer.

Work on:
books/hs-thinking-basic/viewer-v2.html

Do not rewrite existing viewer.html yet.
Do not modify admin heavily yet.
Do not use PDF iframe as the main learning viewer.

Required viewer structure:
- top lesson button bar
- main book area using HTML page nodes
- right fixed YouTube video panel
- book and video must be visible at the same time
- clicking a top lesson button must scroll the book area to the target page using scrollIntoView
- clicking the button must also update the right video iframe
- keep AI-DOC, material, answer buttons as placeholders for now

Use current lesson map:
1단원 개념 → page 2 → video 20OIED2hezI
1단원 필수유형 → page 5 → video 20OIED2hezI&t=1875
2단원 개념 → page 13 → video HtSd564pCpw
2단원 필수유형 → page 18 → video hDPKx7cQtIw
3단원 개념 → page 26 → video 8Wz-g95UGVg
3단원 필수유형 → page 30 → video PYHnn1x2dlM&t=843

First verify viewer-v2 works.
Only after verification, connect START in gfield-on-archive-preview.html to viewer-v2.html.
```

---

## 14. 현재 원장님 최종 의도 요약

원장님의 핵심 의도는 다음이다.

```text
홈페이지 예쁘게 만드는 것보다,
실제 교재가 뜨고,
상단 강의 버튼을 누르면,
교재가 해당 쪽으로 자동 이동하고,
오른쪽에서 영상이 같이 나오는
실제 학습 뷰어를 만드는 것.
```

이 의도에서 벗어나 새 홈페이지나 별도 카드형 페이지를 또 만들지 말 것.
