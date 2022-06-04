import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/Auth.dart';
import 'rest/shipment_api.dart';
import 'screen/login_screen.dart';
import 'screen/main_page.dart';
import 'screen/supplier/list_shipment.dart';

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

    return  Consumer<Auth>(
          builder: (ctx, auth, _) {
            print("AppSession.instance.isLogin=${auth.isAuth }");
            print("AppSession.instance.token=${auth.token}");
            //return auth.isAuth ? auth.role.contains('ROLE_SUPPLIER') ? ListShipment(ShipmentStatus.Customer_Submitted) : MainPage() : const LoginPage();
            return auth.isAuth  ?  MainPage(auth.role) : const LoginPage();
          }
    );


  }
}
