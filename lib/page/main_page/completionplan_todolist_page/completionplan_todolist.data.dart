import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:second_have_to_do/classes/completion_plan.dart';
import 'package:second_have_to_do/classes/plan.dart';
import 'package:second_have_to_do/global_definition.dart';
import 'package:second_have_to_do/page/login/login_page.data.dart';

class CompletionPlanPageData extends GetxController {
  //완료목표가 담기는 리스트
  final RxList<CompletionPlan> planItems = <CompletionPlan>[].obs;
  //완료목표가 클리어시 담기는 리스트
  final RxList<CompletionPlan> completedPlanItems = <CompletionPlan>[].obs;

  LoginPageData loginData = Get.put(LoginPageData());
  int memberId = -1;

  @override
  void onInit() {
    memberId = loginData.user.memberId;
    super.onInit();
    loadPlanDatas(1);
  }

  /*
  조회  
  */
  //모든 완료목표를 불러오는 로직
  Future<void> loadPlanDatas(int memberId) async {
    try {
      var dio = Dio();
      var response = await dio.get(
        "$baseUrl/api/v1/completion_plan/$memberId",
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json",
          },
        ),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data['result'];

        List<CompletionPlan> fetchedPlans =
            responseData.map((cp) => CompletionPlan.fromJson(cp)).toList();

        planItems.assignAll(fetchedPlans);

        print(fetchedPlans);
      } else {
        print("완료 계획 데이터 로드 실패, 상태 코드: ${response.statusCode}");
      }
    } catch (e) {
      print("계획 데이터 로드 중 오류 발생: $e");
    }
  }

  /*
  생성  
  */
  //완료목표안의 단일계획을 추가하는 로직
  Future<int> createPlan(int completionPlanId, Plan plan) async {
    try {
      var dio = Dio();
      var response = await dio.post(
          "$baseUrl/api/v1/completion_plan/$completionPlanId/plan",
          data: {'planContent': plan.planContent.value},
          options: Options(
              headers: {Headers.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        int planId = response.data['planId'] as int;
        return planId;
      } else {
        print("계획 생성 실패코드 : ${response.statusCode} ");
        return -1;
      }
    } on DioException catch (dioError) {
      print("Dio 에러: ${dioError.message}");
      if (dioError.response != null) {
        print("상태 코드: ${dioError.response?.statusCode}");
        print("응답 데이터: ${dioError.response?.data}");
        return -1;
      }
      return -1;
    } catch (e) {
      print("계획 데이터 로드 중 오류 발생: $e");
      return -1;
    }
  }

  // 완료목표 추가하는 로직
  Future<int> createCompletionPlan(
      int memberId, CompletionPlan completionPlan) async {
    try {
      var dio = Dio();
      DateTime nowDate = DateTime.now();
      String nowFormattedDate = DateFormat('yyyy-MM-dd').format(nowDate);
      String endFormattedDate =
          DateFormat('yyyy-MM-dd').format(completionPlan.endDateTime.value);
      var response = await dio.post(
        "$baseUrl/api/v1/completion_plan",
        data: {
          'memberId': memberId,
          'planContent': completionPlan.planContent.value,
          'importantLevel':
              completionPlan.importanceLevel.value.toString().split('.').last,
          'checked': completionPlan.checked.value,
          'startDate': nowFormattedDate,
          'endDate': endFormattedDate
        },
        options: Options(
          headers: {Headers.contentTypeHeader: "application/json"},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var newPlanId = response.data['planId'] as int;
        print("계획생성 성공, planId: $newPlanId");
        return 1;
      } else {
        print("계획생설 실패 실패코드 : ${response.statusCode}");
        return -1;
      }
    } on DioException catch (dioError) {
      print("Dio 에러: ${dioError.message}");
      if (dioError.response != null) {
        print("상태 코드: ${dioError.response?.statusCode}");
        print("응답 데이터: ${dioError.response?.data}");
        return -1;
      }
      return -1;
    } catch (e) {
      print("계획 데이터 로드 중 오류 발생: $e");
      return -1;
    }
  }

  /*
  수정,변경
  */
  //checked 속성을 변경하는 메서드드
  Future<bool> changeCpChecked(int completionPlanId) async {
    try {
      var dio = Dio();
      var response = await dio.patch(
        "$baseUrl/api/v1/completion_plan/$completionPlanId/checked-change",
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return true;
      }
    } on DioException catch (dioError) {
      print("Dio 에러 발생: ${dioError.message}");
      if (dioError.response != null) {
        print("상태 코드: ${dioError.response?.statusCode}");
        print("응답 데이터: ${dioError.response?.data}");
      }
      return false;
    }
    return false;
  }

  //완료목표 자체를 수정하는 로직
  Future<bool> changeCp(int completionPlanId, String plnaContent,
      DateTime endDate, ImportanceLevel important) async {
    String endFormattedDate = DateFormat('yyyy-MM-dd').format(endDate);
    try {
      var dio = Dio();
      var response = await dio.put(
        "$baseUrl/api/v1/completion_plan/$completionPlanId",
        data: {
          'planContent': plnaContent,
          'endDate': endFormattedDate,
          'important': important.toString().split('.').last
        },
        options: Options(
          headers: {Headers.contentTypeHeader: "application/json"},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (dioError) {
      print("Dio 에러 발생: ${dioError.message}");
      if (dioError.response != null) {
        print("상태 코드: ${dioError.response?.statusCode}");
        print("응답 데이터: ${dioError.response?.data}");
      }
      return false;
    }
  }

  /*
  삭제제 메서드 
  */
  //완료 목표안의 단일계획을 삭제하는 메서드
  Future<int> deletePlan(int planId) async {
    try {
      var dio = Dio();
      var response = await dio.delete(
        "$baseUrl/api/v1/plans/$planId",
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json",
          },
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        int responseData = response.data["planId"];
        return responseData; // 성공적으로 planId 반환
      } else {
        print("계획 데이터 삭제 실패, 상태 코드: ${response.statusCode}");
        return -1; // 실패 시 -1 반환
      }
    } on DioException catch (e) {
      // Dio 관련 예외 처리
      if (e.response != null) {
        print("Dio Error: ${e.response?.statusCode}, ${e.response?.data}");
      } else {
        print("Dio Error: ${e.message}");
      }
      return -1; // 에러 시 -1 반환
    } catch (e) {
      // 기타 예외 처리
      print("Unexpected error: $e");
      return -1; // 에러 시 -1 반환
    }
  }

  Future<int> deleteCompletionPlan(int completionPlanId) async {
    try {
      var dio = Dio();
      var response = await dio.delete(
        "$baseUrl/api/v1/completion_plan/$completionPlanId",
        options: Options(
          headers: {Headers.contentTypeHeader: "application/json"},
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        int responseData = response.data["planId"];
        return responseData;
      } else {
        print("계획 데이터 로드 실패, 상태 코드: ${response.statusCode}");
        return -1;
      }
    } on DioException catch (e) {
      // Dio에서 발생한 예외 처리
      if (e.response != null) {
        print("Dio Error: ${e.response?.statusCode}, ${e.response?.data}");
      } else {
        print("Dio Error: ${e.message}");
      }
      return -1;
    } catch (e) {
      // 기타 예외 처리
      print("Unexpected error: $e");
      return -1;
    }
  }
}
