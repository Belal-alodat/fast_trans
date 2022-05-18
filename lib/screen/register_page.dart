import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../util/exception_handler.dart';
import '../widget/round_elevated_button.dart';
import '../widget/round_text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
    // nameController.text = 'modat123';
    // passwordController.text = 'Az123456789';
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                  onTap: () => Navigator.pop(context),
                  child: text(tr('sign in'), size: 20, color: Colors.blue),
                )
              ],
            ),
            const SizedBox(height: 24),
            text(tr('Register '), size: 40, color: Colors.black),
            const SizedBox(height: 64),
            RoundTextField(
              hintText: "full name",
              hintTextColor: const Color(0xFFB6C7D1),
              hintFontSize: 14.0,
              icon: Icons.account_box_outlined,
              iconColor: const Color(0xFFB6C7D1),
              bottomPadding: 10,
              controller: nameController,
              enabledBorderSideColor: Colors.blue,
              focusedBorderSideColor: Colors.blue,
              isEmail: true,
            ),
            const SizedBox(height: 14),
            RoundTextField(
              hintText: "050000000",
              hintTextColor: const Color(0xFFB6C7D1),
              hintFontSize: 14.0,
              icon: Icons.send_to_mobile_sharp,
              iconColor: const Color(0xFFB6C7D1),
              bottomPadding: 10,
              controller: mobileController,
              enabledBorderSideColor: Colors.blue,
              focusedBorderSideColor: Colors.blue,
              isEmail: true,
            ),
            const SizedBox(height: 14),
            RoundTextField(
              hintText: "info@demouri.com",
              hintTextColor: const Color(0xFFB6C7D1),
              hintFontSize: 14.0,
              icon: Icons.mail_outline,
              iconColor: const Color(0xFFB6C7D1),
              bottomPadding: 10,
              controller: emailController,
              enabledBorderSideColor: Colors.blue,
              focusedBorderSideColor: Colors.blue,
              isEmail: true,
            ),
            const SizedBox(height: 14),
            RoundTextField(
                isPassword: true,
                hintText: "**********",
                hintTextColor: Color(0xFFB6C7D1),
                hintFontSize: 14.0,
                icon: Icons.lock,
                iconColor: Color(0xFFB6C7D1),
                controller: passwordController,
                enabledBorderSideColor: Colors.blue,
                focusedBorderSideColor: Colors.blue),
            const SizedBox(height: 14),
            RoundElevatedButton(
              buttonText: tr('register'),
              color: Colors.blueAccent,
              onPressed: submit,
              radius: 30,
              minimumSizeFromHeight: 55,
            ),
          ],
        ),
      ),
    );
  }

  void goToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  Future<void> submit() async {
    String username = emailController.value.text;
    String password = passwordController.value.text;
    try {
      print('username:$username');
      print('password:$password');
      // Provider.of<Auth>(context, listen: false).
      //  await Provider.of<Auth>(context, listen: false).login(username, password);
    } catch (error) {
      var errorMessage = ExceptionHandler.handleException(error);
      _showErrorDialog(errorMessage);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
