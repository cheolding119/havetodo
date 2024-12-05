import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:second_have_to_do/classes/plan.dart';
import 'package:second_have_to_do/global_definition.dart';
import 'package:second_have_to_do/page/login/login_page.data.dart';

class TodayTodoListPageData extends GetxController {
  final RxList<Plan> planItems = <Plan>[].obs;
  final RxList<Plan> completedPlanItems = <Plan>[].obs;

  LoginPageData data = Get.put(LoginPageData());
  int memberId = -1;

  @override
  void onInit() {
    memberId = data.user.memberId;
    super.onInit();
    loadPlanDatas(1);
  }

  /*
  조회 메서드 
  */

// 특정 회원의 계획 데이터를 가져오는 함수
  Future<void> loadPlanDatas(int memberId) async {
    try {
      var dio = Dio();
      var response = await dio.get(
        "$baseUrl/api/v1/plans/$memberId",
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json",
          },
        ),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        // 서버로부터 받은 데이터 처리
        List<dynamic> responseData =
            response.data['result']; // 'data'는 스프링의 `Result` 객체의 필드로 가정

        List<Plan> fetchedPlans =
            responseData.map((p) => Plan.fromJson(p)).toList();

        print(fetchedPlans);

        //완료한 플랜과 완료못한 계획을 분리
        List<Plan> completedPlan =
            fetchedPlans.where((plan) => plan.checked.value == true).toList();
        List<Plan> uncompletedPlans =
            fetchedPlans.where((plan) => plan.checked.value == false).toList();

        planItems.assignAll(uncompletedPlans);
        completedPlanItems.assignAll(completedPlan);

        print("계획 데이터 로드 성공: ${fetchedPlans.length}개의 계획");
      } else {
        print("계획 데이터 로드 실패, 상태 코드: ${response.statusCode}");
      }
    } catch (e) {
      print("계획 데이터 로드 중 오류 발생: $e");
    }
  }

  /*
  생성 메서드
  */
  //계획 생성 메서드
  Future<int> createPlan(int memberId, Plan addPlan) async {
    try {
      var dio = Dio();
      DateTime nowDate = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(nowDate);
      var response = await dio.post(
        "$baseUrl/api/v1/plans",
        data: {
          'memberId': memberId,
          'planContent': addPlan.planContent.value,
          'important': addPlan.important.value,
          'checked': addPlan.checked.value,
          'startDate': formattedDate,
          'endDate': formattedDate
        },
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var newPlanId = response.data['planId'] as int;
        print("계획생성 성공, planId: $newPlanId");
        return newPlanId;
      } else {
        print("계획 생성 실패, 상태 코드: ${response.statusCode}");
        return -1;
      }
    } on DioException catch (dioError) {
      print("Dio 에러: ${dioError.message}");
      if (dioError.response != null) {
        print("상태 코드: ${dioError.response?.statusCode}");
        print("응답 데이터: ${dioError.response?.data}");
      }
      return -1;
    } catch (e) {
      print("예상치 못한 에러: $e");
      return -1;
    }
  }

  /*
  수정 메서드 
  */
  //계획 전체를 수정하는 메서드
  Future<Plan> changePlan(
      Plan plan, String newContent, bool newImportant) async {
    try {
      var dio = Dio();
      var response = await dio.put("$baseUrl/api/v1/plans/${plan.planId}",
          data: {'planContent': newContent, 'important': newImportant},
          options: Options(
              headers: {Headers.contentTypeHeader: "application/json"}));

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        plan.planContent.value = newContent;
        plan.important.value = newImportant;
        print("반환성공");
        return plan;
      }
    } on DioException catch (dioError) {
      print("Dio 에러 발생: ${dioError.message}");
      if (dioError.response != null) {
        print("상태 코드: ${dioError.response?.statusCode}");
        print("응답 데이터: ${dioError.response?.data}");
      }
      return plan;
    }
    return plan;
  }

  //계획의 checked를 수정하는 로직
  Future<bool> changeChecked(int planId) async {
    try {
      var dio = Dio();
      var response = await dio.patch(
          "$baseUrl/api/v1/plans/$planId/checked-change",
          options: Options(
              headers: {Headers.contentTypeHeader: "application/json"}));

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        bool reponseData = response.data["checked"];
        return reponseData;
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

  //계획의 important 수정하는 로직
  Future<bool> changeImportant(int planId) async {
    try {
      var dio = Dio();
      var response = await dio.patch(
          "$baseUrl/api/v1/plans/$planId/important-change",
          options: Options(
              headers: {Headers.contentTypeHeader: "application/json"}));

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        bool responseData = response.data["important"];
        return responseData;
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

  //계획의 endDate를 수정하는 로직
  Future<bool> changeEndDate(int planId) async {
    try {
      var dio = Dio();
      var response = await dio.patch(
          "$baseUrl/api/v1/plans/$planId/endDate-change",
          options: Options(
              headers: {Headers.contentTypeHeader: "application/json"}));

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        //받은 데이터
        // var endDate = response.data["endDate"];

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

  /*
  삭제 메서드 
  */
  Future<int> deletePlan(int planId) async {
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
      return responseData;

      // 서버로부터 받은 데이터 처리
    } else {
      print("계획 데이터 로드 실패, 상태 코드: ${response.statusCode}");
      return -1;
    }
  }
}
