import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/Auth.dart';
import 'screen/register_page.dart';

class RegisterHomeScreen extends StatefulWidget {
  final String role;
  const RegisterHomeScreen(this.role, {Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterHomeScreen> {
  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
  //  print("AppSession.instance.isLogin=${AppSession.instance.isLogin}");
  //  print("AppSession.instance.token=${AppSession.instance.token}");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, auth, _) => RegisterPage(widget.role)),
    );
  }
}
