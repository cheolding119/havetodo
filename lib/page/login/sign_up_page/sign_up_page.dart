import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_have_to_do/classes/user.dart';

import '../login_page.data.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

Color greyColor = const Color(0xFFE9E9E9);

class SignUpPageState extends State<SignUpPage> {
  LoginPageData data = Get.put(LoginPageData());
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController useremailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('회원가입',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _buildInputInfo(const Icon(LineIcons.user), '이름을 입력해 주세요', '이름',
                  usernameController, false),
              _buildInputInfo(const Icon(LineIcons.envelope), '이메일을 입력해 주세요',
                  '이메일', useremailController, false),
              _buildInputInfo(const Icon(LineIcons.key), '비밀번호를 입력해 주세요',
                  '비밀번호', passwordController, false),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(5),
                width: 340,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary),
                  ),
                  //회원가입 로직
                  onPressed: () async {
                    RxBool singUpState = false.obs;

                    User user = User(
                      memberId: -1,
                      name: usernameController.text,
                      email: useremailController.text,
                      password: passwordController.text,
                    );

                    print("전송된 데이터: ${user.toJson()}");

                    singUpState.value = await data.signUpUser(user);
                    print(singUpState.value);
                    if (user.name.isNotEmpty &&
                        user.email.isNotEmpty &&
                        user.password.isNotEmpty) {
                      if (singUpState.value == true) {
                        Fluttertoast.showToast(
                          msg: "회원가입 되셨습니다",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          textColor: Colors.white,
                          fontSize: 14.0,
                        );
                        Get.back();
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: "회원 가입에 실패 하셨습니다",
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

                  child: Text('회원가입',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 정보 입력 텍스트 필드
  Widget _buildInputInfo(Icon icon, String hintText, String nameText,
      TextEditingController controller, bool passwordType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' $nameText',
            style:
                Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 7),
          height: 45,
          width: 340,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
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
                  color: Colors.grey),
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
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey),
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
