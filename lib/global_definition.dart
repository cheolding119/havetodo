//원하는 url을 넣어주세요
String baseUrl = "http://192.168.35.195:8080";

//계획의 중요도 (제일중요,보통중요,조금중요,없음)
enum ImportanceLevel { highImportance, middleImportance, lowImportance, none }

//일기에 들어가는 감정
enum FeelLevel {
  // 긍정적인 감정
  love, // 사랑
  happiness, // 행복
  calmness, // 평온
  anger, // 화남
  confusion, // 혼란
  sadness, // 슬픔
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
