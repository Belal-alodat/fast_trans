import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const Color primary = Colors.white;




class loginScreen extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool fingerPrintLogin = false;

  @override
  Widget build(BuildContext context) {
    var x = Theme.of(context).backgroundColor;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            text(tr('welcome'), size: 24),
            SizedBox(height: 24),
            text(tr('welcome2')),
            SizedBox(height: 24),

            // wUtils.textInput(userNameController, hint: tr('email')),
            // wUtils.textInput(passwordController, hint: tr('password')),

            buildTextField(Icons.mail_outline, "info@demouri.com", false, true),
            buildTextField(Icons.lock, "**********", true, false),
            SizedBox(height: 14),
            buildButton(context, color: Theme.of(context).buttonColor),

            SizedBox(height: 24),
            //wUtils.register(tr('login'),tr('login'), color: primary),
            Container(
              height: 30,
              width: double.infinity,
              color: primary,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: text(
                        tr('registerTitle'),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    InkWell(
                      child: text(tr('forgetPassword')),
                      onTap: () {
                        //  dProvider.changeScreen(RegisterPage());
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),
            InkWell(
              child: text(tr('language')),
              onTap: () {
                language == 'en'
                    ? context.setLocale(Locale('ar'))
                    : context.setLocale(Locale('en'));
                language = language == 'ar' ? 'en' : 'ar';
              },
            ),
          ],
        ),
      ),
    );
  }

  static String language = 'en';
  Widget buildButton(
    BuildContext context, {
    Color color = Colors.black,
  }) {
    return ElevatedButton(
        child: text(
          tr('login'),
        ),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
          foregroundColor: MaterialStateProperty.all<Color>(color),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(color: color),
            ),
          ),
        ),
        onPressed: () => {print(tr('login'))});
  }

  static const Color iconColor = Color(0xFFB6C7D1);
  static const Color activeColor = Color(0xFF09126C);
  static const Color textColor1 = Color(0XFFA7BCC7);
  static const Color textColor2 = Color(0XFF9BB3C0);
  static const Color facebookColor = Color(0xFF3B5999);
  static const Color googleColor = Color(0xFFDE4B39);

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: textColor1),
        ),
      ),
    );
  }

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
}
