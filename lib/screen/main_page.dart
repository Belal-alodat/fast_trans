import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_session.dart';
import '../providers/Auth.dart';
import '../widget/ItemsMenueCards.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int selectedPos = 0;

  String imageTitle = "images/city.png";

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

  Widget build(BuildContext context) {
    var lang = AppSession.instance.languageCode == 'ar' ? 'ar' : '';
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // nameController.text = 'modat123';
    // passwordController.text = 'Az123456789';
    List<ItemMenuType> itemTypeList = [
      ItemMenuType('test1', false, "images/cust$lang.png", '/shipment'),
      ItemMenuType('test2', false, "images/Gps$lang.png", '/shipment'),
      ItemMenuType('test3', false, "images/myShipments$lang.png", '/shipment'),
      ItemMenuType('test4', false, "images/pickupfill$lang.png", '/shipment'),
      ItemMenuType('test5', false, "images/Track$lang.png", '/shipment'),
    ];

    return Scaffold(
      body: SafeArea(
        child: /*Stack(
          alignment: Alignment.center,
          children: [*/
            Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                    InkWell(
                      child: text(tr('logout')),
                      onTap: logout,
                    ),
                  ]),
              const SizedBox(height: 24),
              text(tr('Main Page'), size: 40, color: Colors.black),
              const SizedBox(height: 64),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  // padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: GridView.builder(
                    itemCount: itemTypeList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.37),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print('index=$index');
                          Navigator.pushNamed(
                              context, itemTypeList[index].pageDetailsName);
                          /* setState(() {
                            if (selectedPos != index) {
                              itemTypeList[selectedPos].isSelected = false;
                              itemTypeList[index].isSelected = true;
                              selectedPos = index;
                            }
                          });*/
                        },
                        child: ItemsMenueCards(itemTypeList, index),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        /*],
        ),*/
      ),
    );
  }

  logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
  }
}
