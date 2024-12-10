String baseUrl = "http://192.168.35.195:8080";

//계획의 중요도 (제일중요,보통중요,조금중요,없음)
enum ImportanceLevel { highImportance, middleImportance, lowImportance, none }

//상황별 선택권
enum OperationType {
  completion, //목표 달성
  add, // 추가하기
  edit, // 수정하기
  delete // 삭제하기}
}

double buttonRadius = 16;
