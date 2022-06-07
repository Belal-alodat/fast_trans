import 'package:easy_localization/easy_localization.dart';
import 'package:fast_trans/Constants.dart';
import 'package:fast_trans/util/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Auth.dart';
import '../rest/shipment_api.dart';
import '../widget/ItemsMenueCards.dart';

class MainPage extends StatefulWidget {
  final String role ;
  const MainPage(this.role);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int selectedPos = 0;

  String imageTitle = "images/city.png";



  Widget build(BuildContext context) {
    //var lang = AppSession.instance.languageCode == 'ar' ? 'ar' : '';
    var lang =  context.locale.languageCode == 'ar' ? 'ar' : '';
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // nameController.text = 'modat123';
    // passwordController.text = 'Az123456789';
    List<ItemMenuType> itemTypeList =
    widget.role.contains(Constants.CUSTOMER_ROLE) ?  [
      ItemMenuType('create Shipment', false, 'images/myShipments$lang.png', '/customer/${ShipmentStatus.Customer_Submitted.name}'),
      ItemMenuType('Accept the shipment Cost', false, 'images/Track$lang.png', '/customer/${ShipmentStatus.Operator_Accepted.name}'),
      ItemMenuType('see shipments', false, 'images/Track$lang.png', '/customers/shipments'),


    ]:widget.role.contains(Constants.DRIVER_ROLE) ?
    [

    ItemMenuType('Shipments Actions', false, "images/Gps$lang.png", '/drivers/actions'),
      ItemMenuType('Accept Shipments picking', false, "images/myShipments$lang.png", '/drivers/${ShipmentStatus.Operator_Assigned_For_Picking.name}'),
      ItemMenuType('Accept Shipments Delivery', false, "images/Track$lang.png", '/drivers/${ShipmentStatus.Operator_Assigned_For_Delivery.name}'),
    ]:[
      ItemMenuType('Assign Driver to deliver shipment', false, "images/cust$lang.png", '/operators/${ShipmentStatus.Operator_Store_Accepted.name}'),
      ItemMenuType('Assign Driver to pick shipment', false, "images/Gps$lang.png", '/operators/${ShipmentStatus.Customer_Accepted.name}'),
      ItemMenuType('Add shipments to Store', false, "images/myShipments$lang.png", '/operators/${ShipmentStatus.Driver_Stored.name}'),
      ItemMenuType('Evaluate shipments cost', false, "images/Track$lang.png", '/operators/${ShipmentStatus.Customer_Submitted.name}'),
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
                   WidgetUtil.text(tr('FastTrans'), size: 25, color: Colors.blue),
                    InkWell(
                      child:  WidgetUtil.text(tr('language'),color: Colors.black),
                      onTap: () {
                      // print( context.locale.languageCode);
                       context.locale.languageCode == 'en'
                            ? context.setLocale(Locale('ar'))
                            : context.setLocale(Locale('en'));

                      },
                    ),
                    InkWell(
                      child: WidgetUtil.text(tr('logout'),color: Colors.black),
                      onTap: logout,
                    ),
                  ]),
              const SizedBox(height: 24),
              WidgetUtil.text(tr('Main Page of ${widget.role}'), size: 40, color: Colors.black),
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
    print('main page logout');
  }
}
