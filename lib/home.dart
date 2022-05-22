import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_session.dart';
import 'providers/Auth.dart';
import 'screen/login_screen.dart';
import 'screen/main_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print("AppSession.instance.isLogin=${AppSession.instance.isLogin}");
    print("AppSession.instance.token=${AppSession.instance.token}");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) =>
              !AppSession.instance.isLogin ? MainPage() : const LoginPage()),
    );
  }
}
