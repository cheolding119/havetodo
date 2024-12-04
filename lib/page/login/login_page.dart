import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/bottom_navigaton_page.dart/bottom_navigation_page.dart';
import 'package:second_have_to_do/page/login/sign_up_page/sign_up_page.dart';

import 'login_page.data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  LoginPageData data = Get.put(LoginPageData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/logo.png')),
              const SizedBox(height: 5),
              Text('Have To Do',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 15),
              _buildInputInfo(
                  const Icon(
                    LineIcons.envelope,
                    size: 25,
                    color: Colors.grey,
                  ),
                  '이메일을 입력해 주세요',
                  '이메일',
                  userEmailController,
                  false,
                  Theme.of(context).colorScheme.tertiary),
              _buildInputInfo(
                  const Icon(
                    LineIcons.key,
                    size: 25,
                    color: Colors.grey,
                  ),
                  '비밀번호를 입력해 주세요',
                  '비밀번호',
                  userPasswordController,
                  true,
                  Theme.of(context).colorScheme.tertiary),
              SizedBox(
                width: 340,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: const Color(0xFF777C89),
                                  ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('아이디/비밀번호 찾기',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: const Color(0xFF777C89),
                                  )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(5),
                width: 340,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary),
                    foregroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () async {
                    data.user.memberId = await data.loginUser(
                        userEmailController.text, userPasswordController.text);
                    if (data.user.memberId != -1) {
                      Fluttertoast.showToast(
                        msg: "로그인에 성공 하셨습니다 ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );

                      Get.off(() => const BottomNavigationPage());
                    } else {
                      Fluttertoast.showToast(
                        msg: "로그인에 실패 하셨습니다 ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    }
                  },
                  child: Text('로그인',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                width: 340,
                height: 60,
                child: Image.asset('assets/images/kakao_login.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아직 회원이 아니신가요?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignUpPage());
                    },
                    child: Text(
                      '회원가입',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 정보 입력 텍스트 필드
  Widget _buildInputInfo(Icon icon, String hintText, String nameText,
      TextEditingController controller, bool passwordType, Color textBoxColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' $nameText',
            style:
                Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 50,
          width: 340,
          decoration: BoxDecoration(
            color: textBoxColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              icon,
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: 1,
                height: 25,
                color: Colors.grey,
              ),
              Expanded(
                child: TextField(
                  obscureText: passwordType,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 12),
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
