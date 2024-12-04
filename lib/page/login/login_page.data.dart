import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:second_have_to_do/classes/user.dart';
import 'package:second_have_to_do/global_definition.dart';

//로그인에 필요한 데이터
class LoginPageData extends GetxController {
  User user = User(
    memberId: -1,
    name: '',
    email: '',
    password: '',
  );

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() {}

  //회원가입 메서드
  Future<bool> signUpUser(User user) async {
    print("signUpUser 메서드가 호출되었습니다.");
    try {
      // `toJson()` 메서드를 이용해 `id`가 제외된 JSON 전송
      Map<String, dynamic> jsonData = user.toJson();
      print("전송 데이터: $jsonData"); // 전송할 JSON 데이터 확인용

      var dio = Dio();
      var response = await dio.post(
        "$baseUrl/api/v1/members",
        data: jsonData,
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("회원가입 정상적으로 성공: ${response.data}");
        return true;
      } else {
        print("회원가입 실패 실패코드: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("에러 발생 에러원인: $e");
      return false;
    }
  }

  //로그인 하는 로직
  Future<int> loginUser(String email, String password) async {
    try {
      var dio = Dio();
      var response = await dio.post(
        "$baseUrl/api/v1/members/login",
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        // 성공적으로 로그인하면 memberId를 반환받을 수 있습니다.
        var memberId = response.data['memberId']; // 서버에서 반환한 memberId
        print("로그인 성공, memberId: $memberId");
        return memberId;
      } else {
        print("로그인 실패, 상태코드: ${response.statusCode}");
        return -1;
      }
    } catch (e) {
      print("로그인 에러: $e");
      return -1;
    }
  }
}
