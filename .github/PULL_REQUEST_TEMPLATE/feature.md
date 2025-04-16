name: ✨ 기능 추가 PR
description: 새로운 기능을 개발한 경우 사용하세요.
title: "feat: "
labels: ["feat"]
body:
  - type: textarea
    id: summary
    attributes:
      label: ✅ 변경 요약
      description: 어떤 기능을 추가했는지 간단히 작성해주세요.
    validations:
      required: true
  - type: checkboxes
    id: checklist
    attributes:
      label: 🌿 작업 목록
      options:
        - label: UI 구현
        - label: ViewModel 로직 추가
        - label: API 연동
        - label: 테스트 작성
        - label: 문서화
  - type: textarea
    id: screenshots
    attributes:
      label: 📷 스크린샷 (선택)
      description: UI 변경이 있다면 첨부해주세요.
  - type: textarea
    id: notes
    attributes:
      label: 💬 기타 참고 사항
      description: 리뷰어가 참고해야 할 내용이 있다면 작성해주세요.
