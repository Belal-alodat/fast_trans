import 'package:easy_localization/easy_localization.dart';
import 'package:fast_trans/home.dart';
import 'package:fast_trans/screen/supplier/package_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './generated/codegen_loader.g.dart';
import 'providers/Auth.dart';
import 'providers/address_provider.dart';
import 'providers/driver_provider.dart';
import 'providers/operator_provider.dart';
import 'providers/customer_provider.dart';
import 'register_home.dart';
import 'rest/shipment_api.dart';
import 'screen/driver/confirm_shipment.dart';
import 'screen/driver/driver_list_shipment.dart';
import 'screen/driver/driver_update_shipment_page.dart';
import 'screen/examples/pages/TextFieldExample.dart';
import 'screen/examples/pages/Text_page.dart';
import 'screen/operator/operator_list_shipment.dart';
import 'screen/operator/update_operator_shipment_page.dart';
import 'screen/supplier/add_shipment_page.dart';
import 'screen/supplier/addresses_page.dart';
import 'screen/examples/pages/counter.dart';
import 'screen/examples/pages/home_page.dart';
import 'screen/supplier/list_addresses_page.dart';
import 'screen/supplier/list_packages_page.dart';
import 'screen/operator/assign_driver.dart';
import 'screen/operator/assign_shipment.dart';
import 'screen/supplier/list_shipment.dart';
import 'screen/supplier/update_shipment_page.dart';

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
        ChangeNotifierProxyProvider<Auth, CustomerProvider>(
          create: (BuildContext context) => CustomerProvider(Provider.of<Auth>(context, listen: false).token),
          update: (_, auth, __) => CustomerProvider(auth.token),
        ),

        ChangeNotifierProxyProvider<Auth, OperatorProvider>(
          create: (BuildContext context) => OperatorProvider(Provider.of<Auth>(context, listen: false).token),
          update: (_, auth, __) => OperatorProvider(auth.token),
        ),
        ChangeNotifierProxyProvider<Auth, DriverProvider>(
          create: (BuildContext context) => DriverProvider(Provider.of<Auth>(context, listen: false).token),
          update: (_, auth, __) => DriverProvider(auth.token),
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
          '/register-driver': (context) => RegisterHomeScreen ('DRIVER'),
          '/register-supplier': (context) => RegisterHomeScreen ('SUPPLIER'),
          '/shipment': (context) => AddShipmentPage(),
          '/list-addresses': (context) => ListAddressesPage(),
          '/address': (context) => AddressesPage(),
          '/text2': (context) => TextFieldExample(),
          '/text': (context) => TextPage(),
          '/counter': (context) => Counter(),
          '/package': (context) => PackageDetailsPage(),
          '/list-package': (context) => ListPackagesPage(),

          '/${ShipmentStatus.Driver_Picked.name}':(_)=>ConfirmShipment(ShipmentStatus.Driver_Picked),
          '/${ShipmentStatus.Driver_Delivered.name}':(_)=>ConfirmShipment(ShipmentStatus.Driver_Delivered),

          '/drivers/actions':(_)=>DriverListShipment([ShipmentStatus.Driver_Picked,ShipmentStatus.Driver_pick_Accepted,ShipmentStatus.Operator_Store_Rejected,ShipmentStatus.Driver_deliver_Accepted]),
          '/drivers/${ShipmentStatus.Operator_Assigned_For_Picking.name}':(_)=>DriverListShipment([ShipmentStatus.Operator_Assigned_For_Picking]),
          '/drivers/${ShipmentStatus.Operator_Assigned_For_Delivery.name}':(_)=>DriverListShipment([ShipmentStatus.Operator_Assigned_For_Delivery]),
          '/drivers/UpdateShipmentPage' :(_)=>DriverUpdateShipmentPage(),


          '/operators/${ShipmentStatus.Customer_Submitted.name}':(_)=>OperatorListShipment(ShipmentStatus.Customer_Submitted),
          '/operators/${ShipmentStatus.Driver_Stored.name}':(_)=>OperatorListShipment(ShipmentStatus.Driver_Stored),
          '/operators/UpdateShipmentPage' :(_)=>UpdateOperatorShipmentPage(),

          '/operators/${ShipmentStatus.Customer_Accepted.name}':(_)=>AssignShipment(ShipmentStatus.Customer_Accepted),
          '/operators/${ShipmentStatus.Customer_Accepted.name}/driver':(_)=>PickingDriver(ShipmentStatus.Customer_Accepted),

          '/operators/${ShipmentStatus.Operator_Store_Accepted.name}':(_)=>AssignShipment(ShipmentStatus.Operator_Store_Accepted),
          '/operators/${ShipmentStatus.Operator_Store_Accepted.name}/driver':(_)=>PickingDriver(ShipmentStatus.Operator_Store_Accepted),


          '/customer/${ShipmentStatus.Customer_Submitted.name}':(_)=>ListShipment(ShipmentStatus.Customer_Submitted),
          '/customer/${ShipmentStatus.Operator_Accepted.name}':(_)=>ListShipment(ShipmentStatus.Operator_Accepted),
          '/Customer/UpdateShipmentPage' :(_)=>UpdateShipmentPage(),





          //  '/example1':(_)=>MyHomePage(title: 'example1'),
        },
      ),
    );
  }
}
