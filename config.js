window.GFIELD_CONFIG = {
  // 교재 이름입니다. THINKING BASIC이 아닌 다른 교재도 여기만 바꾸면 됩니다.
  bookTitle: "THINKING BASIC",

  // 교재 PDF 파일 위치입니다. 기본은 assets/book.pdf 입니다.
  bookPdf: "assets/book.pdf",

  // PDF 화면 크기입니다. 너무 크거나 작으면 1.15 ~ 1.55 사이에서 조절하세요.
  pdfScale: 1.35,

  // 워터마크 앞부분입니다. 실제 표시 예: G!FIELD · 홍길동
  watermarkPrefix: "G!FIELD",

  slogan: "성공하는 공부 습관을 만드는 지필드 영재교육",
  subtitle: "더 높은 레벨을 위한 THINKING BASIC",

  // 강의 버튼 목록입니다.
  // 버튼을 추가하려면 아래 형식으로 항목을 더 추가하세요.
  // label: 버튼 이름
  // title: 영상 패널 제목
  // page: 버튼을 눌렀을 때 이동할 PDF 쪽수
  // videoUrl: 유튜브 링크
  lessons: [
    {
      id: "u1c",
      label: "1단원 개념",
      title: "문제푸는 방법 찾기(1) · 개념",
      page: 1,
      videoUrl: "https://youtu.be/20OIED2hezI?si=nooj_2XXt9oRVDcs",
      kind: "concept"
    },
    {
      id: "u1e",
      label: "1단원 필수유형",
      title: "문제푸는 방법 찾기(1) · 필수유형",
      page: 5,
      videoUrl: "https://youtu.be/20OIED2hezI?si=Eppn2W_4Joe-QZWE&t=1875",
      kind: "essential"
    },
    {
      id: "u2c",
      label: "2단원 개념",
      title: "문제푸는 방법 찾기(2) · 개념",
      page: 12,
      videoUrl: "https://youtu.be/HtSd564pCpw?si=15Inv0cVtonKn_ww",
      kind: "concept"
    },
    {
      id: "u2e",
      label: "2단원 필수유형",
      title: "문제푸는 방법 찾기(2) · 필수유형",
      page: 18,
      videoUrl: "https://youtu.be/hDPKx7cQtIw",
      kind: "essential"
    },
    {
      id: "u3c",
      label: "3단원 개념",
      title: "규칙 찾아 해결하기(1) · 개념",
      page: 15,
      videoUrl: "https://youtu.be/8Wz-g95UGVg?si=z-12_yWB0TYpaAFP",
      kind: "concept"
    },
    {
      id: "u3e",
      label: "3단원 필수유형",
      title: "규칙 찾아 해결하기(1) · 필수유형",
      page: 30,
      videoUrl: "https://youtu.be/PYHnn1x2dlM?si=1e4X7QOs-TuwEDa6&t=843",
      kind: "essential"
    }
  ],

  // 강의 외 별도 링크 버튼입니다.
  // 예: 학부모 안내, 숙제 제출, 공지 링크 등을 새 창으로 열 수 있습니다.
  links: [
    // { label: "공지사항", url: "https://example.com" }
  ]
};
