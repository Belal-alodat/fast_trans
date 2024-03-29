import 'package:fast_trans/rest/address_api.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../models/address.dart';
import '../../providers/customer_provider.dart';
import '../../models/address.dart';
import '../../models/package.dart';
import '../../providers/Auth.dart';

import '../../rest/address_api.dart';
import '../../rest/package_api.dart';
import '../../rest/shipment_api.dart';
import '../../util/widget_util.dart';
import '../../widget/card_with_colored_edge.dart';
import '../../widget/round_elevated_button.dart';

class AddShipmentPage extends StatefulWidget {
  @override
  _AddShipmentState createState() => _AddShipmentState();
}


class _AddShipmentState extends State<AddShipmentPage> {

  Address? toAddress;
  Address? fromAddress;
  Package? shipmentPackage;
  var _dueDate = DateTime.now();
  Widget getCard(
      String image, String label, String ObjectString, Direction direction) {
    double height = 50.0;

    return CardWithColoredEdge(
      height,
      Colors.blue.shade900,
      Colors.red,
      direction,
      getCardWidgets(image, label, ObjectString == null  ? '': ObjectString, Colors.white),
      row3children: getCardRow3Widget(height),
    );
  }



  Widget build(BuildContext context) {
   // var lang =  context.locale.languageCode == 'ar' ? 'ar' : '';
  print('context.locale.languageCode = ${context.locale.languageCode }');
    Direction direction = context.locale.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    return Scaffold(
      appBar: AppBar(title:Text( 'Create Shipments'),),
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
                      fromAddress == null ? '':'${fromAddress?.fullName}', direction),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: to,
                  child: getCard(
                      'images/to.png', 'To', toAddress == null ? '':'${toAddress?.fullName}', direction),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: PackageDetails,
                  child: getCard('images/packagedetails.png', 'Package Details',
                      shipmentPackage == null ? '':'${shipmentPackage?.product?.name}' , direction),
                ),

                const SizedBox(height: 24),
                InkWell(
                  onTap: _pickDate,
                  child: getCard('images/transit.png', 'Pickup Date',
                      _dueDate == null ? '':'${DateFormat('yyyy-MM-dd').format(_dueDate)}' , direction),
                ),
              //  buildDateField( context),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RoundElevatedButton(
                            child: getButtonText('submit'),
                            color: Colors.blueAccent,
                            onPressed: _submit,
                            radius: 30,
                            minimumSizeFromHeight: 0,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: RoundElevatedButton(
                            child: getButtonText('reset'),
                            color: Colors.blueAccent,
                            onPressed: () {},
                            radius: 30,
                            minimumSizeFromHeight: 0,
                          ),
                        ),
                      ]),
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

  List<Widget> getCardRow3Widget(double height) {
    return [
      Center(
        child: Container(
          height: height,
          //  color: Colors.amberAccent,
          child: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.white,
            //size: 30,
          ),
          //  color: Colors.black,
        ),
      ),
      const SizedBox(width: 5),
    ];
  }

  logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
  }

  void from() async {

  //  AddressResponse addressResponse = await addressApi.getFromAddress();
   // AppSession.instance.fromAddresses = addressResponse.addresses;
    await Provider.of<CustomerProvider>(context, listen: false).getFromAddress();

    final result = await Navigator.pushNamed(context, '/list-addresses',
        arguments: 'From');
    print('From list index =${result.toString()}');

    try {
      int index = int.parse(result!.toString());

      setState(() {
        fromAddress =  Provider.of<CustomerProvider>(context, listen: false).fromAddresses[index];
      });
      print('fromAddress ${fromAddress?.fullName}');
    } catch (e) {
      print('null result');
    }
  }
  //AddressApi  addressApi = AddressApi(AppSession.instance.token);
 // PackageAPI packageAPI = PackageAPI(AppSession.instance.token);
  void to() async {

    await Provider.of<CustomerProvider>(context, listen: false).getToAddress();

    //AddressResponse addressResponse = await addressApi.getToAddress();

    //AppSession.instance.toAddresses = addressResponse.addresses;
    final result =
        await Navigator.pushNamed(context, '/list-addresses', arguments: 'To');
    print('To list index =${result.toString()}');
    try {
      int index = int.parse(result!.toString());
      setState(() {
        toAddress = Provider.of<CustomerProvider>(context, listen: false).toAddresses[index];
      });

      print('toAddress ${toAddress?.fullName}');
    } catch (e) {
      print('null result');
    }
  }

  Future<void> PackageDetails() async {

    //PackageResponse packageResponse = await packageAPI.getPackages();
    //AppSession.instance.packages = packageResponse.packages;
    await Provider.of<CustomerProvider>(context, listen: false).getPackages();
    final result =
        await Navigator.pushNamed(context, '/list-package');

    print('To list index =${result.toString()}');

    try {
      int index = int.parse(result!.toString());
      setState(() {
        shipmentPackage = Provider.of<CustomerProvider>(context, listen: false).packages[index];
      });

      print('shipmentPackage ${shipmentPackage?.product?.name}');
    } catch (e) {
      print('null result');
    }


  }

  void _submit() async{
    Shipment shipmentRequest = Shipment(
      status: ShipmentStatus.Customer_Submitted.index,
      pickupDate: DateFormat('yyyy-MM-dd').format(_dueDate),
        shipmentPackage: shipmentPackage!,
        toAddress: toAddress!,
        fromAddress: fromAddress!);
    await Provider.of<CustomerProvider>(context, listen: false).saveShipment(shipmentRequest);
    Navigator.pop(context);
  }

  void _pickDate()async {
    final currentDate = _dueDate ;
// 7
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 5),
    );
// 8
    setState(() {
      if (selectedDate != null) {
        _dueDate = selectedDate;
      }
    });
  }
}
