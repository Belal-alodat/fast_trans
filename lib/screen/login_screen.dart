import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_session.dart';
import '../providers/Auth.dart';
import '../util/dialogue.dart';
import '../util/exception_handler.dart';
import '../widget/round_elevated_button.dart';
import '../widget/round_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget text(
    String text, {
    Color color = Colors.black,
    double size = 14,
    String font = 'm',
  }) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontFamily: 'loew$font'),
    );
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = 't@com';
    passwordController.text = '123123';
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(tr('FastTrans'), size: 25, color: Colors.blue),
                    InkWell(
                      child: text(tr('language')),
                      onTap: () {
                        AppSession.instance.languageCode == 'en'
                            ? context.setLocale(Locale('ar'))
                            : context.setLocale(Locale('en'));
                        AppSession.instance.languageCode =
                            AppSession.instance.languageCode == 'ar'
                                ? 'en'
                                : 'ar';
                      },
                    ),
                  ]),
              const SizedBox(height: 24),
              text(tr('Sign in'), size: 40, color: Colors.black),
              const SizedBox(height: 64),
              RoundTextField(
                hintText: "info@demouri.com",
                hintTextColor: const Color(0xFFB6C7D1),
                hintFontSize: 14.0,
                icon: Icons.mail_outline,
                iconColor: const Color(0xFFB6C7D1),
                bottomPadding: 10,
                controller: nameController,
                enabledBorderSideColor: Colors.blue,
                focusedBorderSideColor: Colors.blue,
                isEmail: true,
              ),
              const SizedBox(height: 14),
              RoundTextField(
                  isPassword: true,
                  hintText: "**********",
                  hintTextColor: const Color(0xFFB6C7D1),
                  hintFontSize: 14.0,
                  icon: Icons.lock,
                  iconColor: const Color(0xFFB6C7D1),
                  controller: passwordController,
                  enabledBorderSideColor: Colors.blue,
                  focusedBorderSideColor: Colors.blue),
              const SizedBox(height: 14),
              RoundElevatedButton(
                buttonText: tr('login'),
                color: Colors.blueAccent,
                onPressed: submit,
                radius: 30,
                minimumSizeFromHeight: 55,
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: text(
                          tr('join now'),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      InkWell(
                        child: text(tr('forgetPassword2')),
                        onTap: () {
                          //  dProvider.changeScreen(RegisterPage());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  Future<void> submit() async {
    String username = nameController.value.text;
    String password = passwordController.value.text;
    try {
      print('username:$username');
      print('password:$password');
      // Provider.of<Auth>(context, listen: false).
      await Provider.of<Auth>(context, listen: false).login(username, password);
    } catch (error) {
      var errorMessage = ExceptionHandler.handleException(error);
      if (errorMessage == ExceptionHandler.KUnAuthorized) {
        errorMessage = ExceptionHandler.kInvalidCredentials;
      }
      Dialogs.showErrorDialog(errorMessage, context);
    }
  }
}
