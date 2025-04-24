# 💱 YWS Currency Calculator
Ch 4. 앱 개발 숙련 주차 과제

**YWS Currency Calculator**는 실시간 환율 정보를 제공하고, 선택한 통화에 대해 손쉽게 계산할 수 있는 **환율 계산기 앱**입니다.  
즐겨찾기, 검색, 다크모드, 상태 저장 등 다양한 기능이 포함되어 있으며, **UIKit + MVVM + CoreData** 아키텍처로 구성되었습니다.

## 🗓 프로젝트 기간

2025년 4월 14일 ~ 2025년 4월 24일 (총 11일간 진행)

## 🎯 프로젝트 목표

- 실시간 환율 API 연동을 통한 통화 정보 제공
- 통화 검색, 즐겨찾기, 계산기 등 실사용 기능 구현
- UIKit 기반 TableView + SnapKit을 활용한 UI 구성
- 앱 상태 저장 및 복원 기능 (CoreData 사용)

## 📱 주요 기능

| 기능 구분 | 설명 |
|----------|------|
| 환율 리스트 | API로부터 받아온 환율 정보 표시 |
| 통화 검색 | 통화 코드/국가명 기준으로 실시간 필터링 |
| 즐겨찾기 | 자주 쓰는 통화 즐겨찾기 등록 및 상단 고정 |
| 환율 계산기 | 선택한 통화의 환율로 계산기 기능 제공 |
| 변화 아이콘 표시 | 환율이 상승🔼/하락🔽/동일 - 를 표시 |
| 앱 상태 저장 | 마지막으로 본 화면 기억하여 앱 재실행 시 복원 |
| 다크모드 대응 | Asset Catalog 색상 활용, 시스템 테마 자동 반영 |

## ✅ 구현 기능 체크리스트

- [x] **환율 리스트 화면**
  - [x] API 연동 (open.er-api.com)
  - [x] CoreData 캐싱 처리 및 상태 복원
  - [x] 환율 상승/하락/동일 아이콘 표시

- [x] **검색 기능**
  - [x] 통화 코드 및 국가명 기준 필터링

- [x] **즐겨찾기 기능**
  - [x] CoreData 저장
  - [x] 즐겨찾기 상단 고정
  - [x] UI 반영 (별 아이콘)

- [x] **환율 계산기**
  - [x] 금액 입력 → 변환값 출력
  - [x] 계산 결과 및 오류 Alert 표시

- [x] **앱 상태 저장/복원**
  - [x] 앱 종료 시 마지막 화면 정보 저장
  - [x] 앱 재실행 시 자동 복원 (SceneDelegate)

- [x] **다크모드 대응**
  - [x] Asset 색상 분리 (Any/Dark)
  - [x] UILabel, UITableView 등에 적용

## 🧩 기술 스택

- **언어:** Swift
- **프레임워크:** UIKit
- **레이아웃:** SnapKit
- **아키텍처:** MVVM, Delegate Pattern
- **저장소:** CoreData
- **비동기 처리:** URLSession

## 📸 주요 화면

- 환율 리스트 화면  
  ![Simulator Screenshot - iPhone 16 - 2025-04-24 at 11 37 26](https://github.com/user-attachments/assets/e96fa49f-9be8-4adc-a67e-8ca09fb58e64)

- 즐겨찾기 추가된 화면  
  ![Simulator Screenshot - iPhone 16 - 2025-04-24 at 11 55 18](https://github.com/user-attachments/assets/4358d512-df48-4844-b235-ea30a1dc4d80)


- 환율 계산기 화면  
  ![Simulator Screenshot - iPhone 16 - 2025-04-24 at 11 55 56](https://github.com/user-attachments/assets/e4f5b1f8-fe51-438d-9b96-f8ae448200bf)


- 환율 변화 아이콘 표시  
  ![Simulator Screenshot - iPhone 16 - 2025-04-24 at 11 37 26](https://github.com/user-attachments/assets/e96fa49f-9be8-4adc-a67e-8ca09fb58e64)

## 📋 요구사항 기반

- API 기반 환율 데이터 제공
- 계산기 기능 및 결과 표시
- 즐겨찾기, 검색, 다크모드 등 사용자 편의 기능 포함
- 마지막 본 화면 복원 기능

## 🔎 협업 규칙

- Git Flow 전략에 맞춘 브랜치 관리
- PR 리뷰 전 approve 필수
- 커밋 및 PR 컨벤션에 맞춘 커뮤니케이션
- 코드 주석 및 함수명으로 역할 명확히 하기

## ✏️ 코딩 컨벤션

- [Swift 스타일 가이드](https://github.com/StyleShare/swift-style-guide) 준수

## 📍 커밋 컨벤션

- `feat`: 기능 추가
- `fix`: 버그 수정
- `refactor`: 리팩토링
- `docs`: 문서 수정
- `test`: 테스트 코드
- `style`: 코드 포맷 변경
- `build`: 빌드 관련 작업
- `chore`: 기타 변경사항

## 💡 브랜치 전략

- `main` : 배포용
- `dev` : 개발 통합
- `feat/*` : 기능별 개발 브랜치
- `fix/*` : 버그 수정 브랜치

## 🚀 실행 방법

1. 프로젝트 클론
```bash
git clone https://github.com/your-team/yws-currency-calculator.git
```
2. Xcode에서 열기 및 실행  
3. 시뮬레이터에서 동작 확인
