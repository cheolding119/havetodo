//원하는 url을 넣어주세요
String baseUrl = "http://192.168.35.195:8080";

//계획의 중요도 (제일중요,보통중요,조금중요,없음)
enum ImportanceLevel { highImportance, middleImportance, lowImportance, none }

//일기에 들어가는 감정
enum FeelLevel {
  // 긍정적인 감정
  happiness, // 행복
  excitement, // 신남
  love, // 사랑
  satisfaction, // 만족
  gratitude, // 감사

  // 부정적인 감정
  sadness, // 슬픔
  anger, // 분노
  fear, // 두려움
  disappointment, // 실망
  jealousy, // 질투

  // 중립적인 감정
  neutral, // 중립
  curiosity, // 호기심
  boredom, // 지루함
  calmness, // 평온

  // 복합 감정
  confusion, // 혼란
  surprise, // 놀람
  empathy, // 공감
}

//상황별 선택권
enum OperationType {
  completion, //목표 달성
  add, // 추가하기
  edit, // 수정하기
  delete // 삭제하기}
}

//버튼의 radius
double buttonRadius = 16;
