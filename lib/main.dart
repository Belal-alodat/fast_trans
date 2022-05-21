import 'package:easy_localization/easy_localization.dart';
import 'package:fast_trans/home.dart';
import 'package:flutter/material.dart';

import './generated/codegen_loader.g.dart';
import 'register_home.dart';
import 'screen/Text_page.dart';
import 'screen/add_shipment_page.dart';
import 'screen/list_addresses_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en'),
      Locale('ar'),
    ],
    saveLocale: true,
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    assetLoader: CodegenLoader(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData.light().copyWith(
          //scaffoldBackgroundColor: Colors.blue,
          //  buttonColor: ColorsUtils.orange,
          // appBarTheme: AppBarTheme(color: ColorsUtils.primary),
          // primarySwatch: ColorsUtils.primarySwatch,
          ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/register': (context) => TextPage(),
        '/shipment': (context) => AddShipmentPage(),
        '/list-addresses': (context) => ListAddressesPage(),
        '/text': (context) => RegisterHomeScreen(),
      },
    );
  }
}
