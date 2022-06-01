import 'package:easy_localization/easy_localization.dart';
import 'package:fast_trans/home.dart';
import 'package:fast_trans/screen/package_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './generated/codegen_loader.g.dart';
import 'providers/Auth.dart';
import 'providers/address_provider.dart';
import 'providers/shipment_provider.dart';
import 'register_home.dart';
import 'screen/TextFieldExample.dart';
import 'screen/Text_page.dart';
import 'screen/add_shipment_page.dart';
import 'screen/addresses_page.dart';
import 'screen/counter.dart';
import 'screen/list_addresses_page.dart';
import 'screen/list_packages_page.dart';

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
    return MultiProvider(
      providers: [
    ChangeNotifierProvider<Auth>(create: (_) =>Auth()  ),

        ChangeNotifierProvider.value(
          value: AddressProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, ShipmentProvider>(
          create: (BuildContext context) => ShipmentProvider(Provider.of<Auth>(context, listen: false).token),
          update: (_, auth, __) => ShipmentProvider(auth.token),
        ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            color: Colors.blue.shade900,
          ),
          scaffoldBackgroundColor: Colors.white,
          buttonColor: Colors.orange,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey),
          // appBarTheme: AppBarTheme(color: ColorsUtils.primary),
          // primarySwatch: ColorsUtils.primarySwatch,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => HomeScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/register': (context) => RegisterHomeScreen (),
          '/shipment': (context) => AddShipmentPage(),
          '/list-addresses': (context) => ListAddressesPage(),
          '/address': (context) => AddressesPage(),
          '/text2': (context) => TextFieldExample(),
          '/text': (context) => TextPage(),
          '/counter': (context) => Counter(),
          '/package': (context) => PackageDetailsPage(),
          '/list-package': (context) => ListPackagesPage(),
        },
      ),
    );
  }
}
