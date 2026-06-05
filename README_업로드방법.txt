G-FIELD PDF 교재 뷰어 업로드형

이 폴더는 GitHub/Netlify/GitHub Pages에 올릴 수 있는 교재 뷰어입니다.
교재명, 강의 버튼, 링크 버튼, 승인명단, PDF 파일을 쉽게 바꿀 수 있게 분리했습니다.


1. 교재 PDF 교체

- 새 교재 PDF를 assets/book.pdf 로 넣습니다.
- 다른 파일명을 쓰려면 config.js의 bookPdf 값을 바꿉니다.
- GitHub 일반 저장소 기준으로 PDF는 100MiB 미만이어야 합니다.
- 50MiB를 넘으면 GitHub에서 큰 파일 경고가 나올 수 있으니 가능하면 50MiB 이하를 권장합니다.
- PDF 파일을 바꿔서 다시 업로드하면 새 버전이 추가 기록으로 올라갑니다. 이전 PDF 기록도 Git 히스토리에 남기 때문에 큰 PDF를 자주 바꾸면 저장소 용량이 계속 커질 수 있습니다.


2. 교재명 변경

config.js에서 bookTitle을 바꿉니다.

예:
bookTitle: "THINKING BASIC"
bookTitle: "THINKING ADVANCED"


3. 강의 버튼 이름, 영상 링크, 연결 페이지 변경

config.js의 lessons 배열을 수정합니다.

- label: 버튼 이름
- title: 영상 패널 제목
- page: 버튼을 눌렀을 때 이동할 PDF 쪽수
- videoUrl: 유튜브 링크
- kind: 버튼 색상 구분용 값입니다. concept, essential 등을 쓸 수 있습니다.

버튼을 추가하려면 lessons 배열에 항목을 하나 더 추가합니다.
버튼을 줄이려면 해당 항목을 삭제합니다.


4. 별도 링크 버튼 추가

config.js의 links 배열을 수정합니다.

예:
links: [
  { label: "공지사항", url: "https://example.com" },
  { label: "숙제 제출", url: "https://forms.gle/example" }
]

이 버튼들은 새 창으로 열립니다.


5. 승인명단 변경

students.js를 수정합니다.

- 가장 쉬운 방식: approvedNames에 학생 이름을 그대로 넣습니다.
- 이름을 GitHub 소스에 노출하고 싶지 않으면 approvedHashes 방식을 사용합니다.
- 해시는 tools/hash-students.html을 열어서 만들 수 있습니다.
- 기존 해시 승인명단은 students.js에 그대로 유지되어 있습니다.


6. 워터마크 조건

- 화면에서는 각 PDF 페이지 중앙에 학생 이름 워터마크가 표시됩니다.
- 인쇄할 때는 기존 프로그램처럼 페이지 안에 3줄 반복 워터마크가 표시됩니다.
- 워터마크 앞 문구는 config.js의 watermarkPrefix에서 바꿀 수 있습니다.


7. 자동 업로드

업로드_실행.cmd를 더블클릭합니다.

첫 실행 때 입력하는 값:

- GitHub 저장소 주소: 예) https://github.com/아이디/저장소.git
- 업로드 브랜치: 보통 main
- 저장소 안 하위 폴더명: 루트에 올릴 거면 비워둡니다. 특정 폴더에 올릴 거면 예) library/thinking-basic
- GitHub Pages/Netlify 공개 주소: 알고 있으면 입력합니다. 모르면 비워둡니다.

한 번 입력하면 .upload-settings.json에 저장되어 다음부터는 자동으로 같은 위치에 업로드됩니다.

업로드가 끝나면 upload-links.txt 파일이 만들어집니다.
이 파일 안에 GitHub 저장소, GitHub 폴더, index.html, config.js, students.js, PDF, 학생 접속 주소가 정리됩니다.


8. 미리보기

미리보기_실행.cmd를 더블클릭한 뒤 브라우저에서 아래 주소를 엽니다.

http://127.0.0.1:8787/


필수 파일

- index.html
- config.js
- students.js
- gfield-logo.svg
- assets/book.pdf
- tools/hash-students.html
- upload-github.ps1
- 업로드_실행.cmd
- 미리보기_실행.cmd
- netlify.toml
- _headers


주의

- PDF 파일이 없으면 학생 화면에 PDF 안내 문구가 표시됩니다.
- GitHub Pages에서 직접 보여줄 PDF는 일반 Git 파일로 올라가야 하므로 100MiB 미만을 지켜 주세요.
- Git LFS는 큰 파일용 기능이지만 GitHub Pages 사이트 파일로 쓰기에는 적합하지 않습니다.
- 유튜브 임베드가 특정 네트워크에서 막히면 '새 창' 버튼으로 직접 열어 확인하세요.
