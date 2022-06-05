import 'package:fast_trans/rest/address_api.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../models/address.dart';
import '../../providers/customer_provider.dart';
import '../../models/address.dart';
import '../../models/package.dart';
import '../../providers/Auth.dart';

import '../../providers/driver_provider.dart';
import '../../providers/operator_provider.dart';
import '../../rest/address_api.dart';
import '../../rest/package_api.dart';
import '../../rest/shipment_api.dart';
import '../../rest/shipment_api.dart';
import '../../util/widget_util.dart';
import '../../widget/card_with_colored_edge.dart';
import '../../widget/round_elevated_button.dart';

class DriverUpdateShipmentPage extends StatefulWidget {
  @override
  _DriverUpdateShipmentState createState() => _DriverUpdateShipmentState();
}


class _DriverUpdateShipmentState extends State<DriverUpdateShipmentPage> {




  Widget getCard(
      String image, String label, String ObjectString, Direction direction) {
    double height = 50.0;

    return CardWithColoredEdge(
      height,
      Colors.blue.shade900,
      Colors.red,
      direction,
      getCardWidgets(image, label, ObjectString == null  ? '': ObjectString, Colors.white),
     // row3children: getCardRow3Widget(height),
    );
  }


    Shipment? shipment ;
      Widget build(BuildContext context) {
   // var lang =  context.locale.languageCode == 'ar' ? 'ar' : '';
      shipment = ModalRoute.of(context)!.settings.arguments as Shipment;
  print('DriverUpdateShipmentPage shipment = ${shipment?.id }');
    Direction direction = context.locale.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: /*Consumer<ShipmentProvider>(
          builder: (ctx, shipmentProvider, _) =>*/ SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                InkWell(
                  onTap: from,
                  child: getCard('images/from.png', 'From',
                      shipment?.fromAddress == null ? '':'${shipment?.fromAddress.fullName}', direction),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: to,
                  child: getCard(
                      'images/to.png', 'To', shipment?.toAddress == null ? '':'${shipment?.toAddress.fullName}', direction),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: PackageDetails,
                  child: getCard('images/packagedetails.png', 'Package Details',
                      shipment?.shipmentPackage == null ? '':'${shipment?.shipmentPackage.product?.name}' , direction),
                ),

                const SizedBox(height: 24),

              //  buildDateField( context),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: getActionButtons(shipment) ),
                ),
              ],
            ),
          ),
     //   ),
      ),
    );
  }

  Widget getButtonText(String text2) {
    Widget child2 = WidgetUtil.text(text2, color: Colors.white);
    Widget c2 = Container(
      alignment: Alignment.center,
      //color: Colors.red,
      //   width: 90,
      height: 50,
      // padding: const EdgeInsets.all(10.0),
      child: child2,
    );
    return c2;
  }

  Widget getCardWidgets(String imagePath, String textLabel1, String textLabel2,
      Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Container(
            child: Image.asset(imagePath,
                fit: BoxFit.fill, color: backgroundColor),
          ),
          const SizedBox(width: 20),
          Container(
            child: WidgetUtil.text(textLabel1, color: backgroundColor),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              //  color: Colors.red,
              child: Text(
                textAlign: TextAlign.center,
                textLabel2,
                overflow: TextOverflow.visible,
                style: TextStyle(color: backgroundColor, fontFamily: 'loewm'),
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }



  void from() async {


  }
  //AddressApi  addressApi = AddressApi(AppSession.instance.token);
 // PackageAPI packageAPI = PackageAPI(AppSession.instance.token);
  void to() async {


  }

  Future<void> PackageDetails() async {




  }

void _back(){ Navigator.pop(context);}
  void _accept() {
     if(ShipmentStatus.Operator_Assigned_For_Picking.index == shipment!.status)
    Provider.of<DriverProvider>(context, listen: false).updateDriverShipmentsStatus(shipment!.id,shipment!.status,ShipmentStatus.Driver_pick_Accepted).then((value) =>
        Navigator.pop(context)
    );
     else
       Provider.of<DriverProvider>(context, listen: false).updateDriverShipmentsStatus(shipment!.id,shipment!.status,ShipmentStatus.Driver_deliver_Accepted).then((value) =>
           Navigator.pop(context)
       );
  }

  void _reject() {

        print('reeject shipment!.status =${shipment!.status}');
    if(ShipmentStatus.Operator_Assigned_For_Picking.index == shipment!.status) {
      Provider.of<DriverProvider>(context, listen: false)
          .updateDriverShipmentsStatus(
          shipment!.id,shipment!.status ,ShipmentStatus.Driver_pick_Rejected)
          .then((value) =>
          Navigator.pop(context)
      );
      print('reeject Driver_pick_Rejected =${ShipmentStatus.Driver_pick_Rejected}');
    }else
    Provider.of<DriverProvider>(context, listen: false).updateDriverShipmentsStatus(shipment!.id,shipment!.status,ShipmentStatus.Driver_deliver_Rejected).then((value) =>
        Navigator.pop(context)
    );
  }
  void _picked() {

    Provider.of<DriverProvider>(context, listen: false)
        .updateDriverShipmentsStatus(
        shipment!.id, shipment!.status, ShipmentStatus.Driver_Picked)
        .then((value) =>
        Navigator.pop(context)
    );
  }

  void _stord() {

    Provider.of<DriverProvider>(context, listen: false)
        .updateDriverShipmentsStatus(
        shipment!.id, shipment!.status, ShipmentStatus.Driver_Stored)
        .then((value) =>
        Navigator.pop(context)
    );
  }

  void _Delivered() {

    Provider.of<DriverProvider>(context, listen: false)
        .updateDriverShipmentsStatus(
        shipment!.id, shipment!.status, ShipmentStatus.Driver_Delivered)
        .then((value) =>
        Navigator.pop(context)
    );
  }

  getActionButtons(Shipment? shipment) {
print('getActionButtons');
    //[ShipmentStatus.Driver_pick_Accepted
// ,ShipmentStatus.Driver_Picked,
// ShipmentStatus.Driver_deliver_Accepted]),

String label1 = 'Accept';
String label2 ='Rejected';
  VoidCallback? f1 = _accept;
  VoidCallback? f2 = _reject;

  if  (shipment!.status == ShipmentStatus.Driver_pick_Accepted.index )

    {
      label1 = 'Picked';
      label2= 'back';
      f1=_picked;
      f2=_back;
    }else if  (shipment!.status == ShipmentStatus.Driver_Picked.index ){
    label1 = 'Stored';
    label2= 'back';
    f1=_stord;
    f2=_back;
  }else if  (shipment!.status == ShipmentStatus.Operator_Store_Rejected.index ){
      label1 = 'Stored';
      label2= 'back';
      f1=_stord;
      f2=_back;
    }else if  (shipment!.status == ShipmentStatus.Driver_deliver_Accepted.index ){
    label1 = 'Delivered';
    label2= 'back';
    f1=_Delivered;
    f2=_back;
  }
  return
    [
      Expanded(
        child: RoundElevatedButton(
          child: getButtonText(label1),
          color: Colors.blueAccent,
          onPressed: f1,
          radius: 30,
          minimumSizeFromHeight: 0,
        ),
      ),
      const SizedBox(width: 24),
      Expanded(
        child: RoundElevatedButton(
          child: getButtonText(label2),
          color: Colors.blueAccent,
          onPressed: f2,
          radius: 30,
          minimumSizeFromHeight: 0,
        ),
      )
    ];


  }
}
