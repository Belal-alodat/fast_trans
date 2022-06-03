import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../models/address.dart';
import '../../providers/operator_provider.dart';
import '../../providers/shipment_provider.dart';
import '../../models/package.dart';
import '../../rest/driver_api.dart';
import '../../rest/shipment_api.dart';
import '../../util/dialogue.dart';
import '../../util/exception_handler.dart';
import '../../util/widget_util.dart';
import '../../widget/card_with_colored_edge.dart';

class PickingDriver extends StatefulWidget {
  ShipmentStatus _shipmentStatus;
    PickingDriver(this._shipmentStatus);
  @override
  _PickingDriverState createState() => _PickingDriverState();
}

class _PickingDriverState extends State<PickingDriver> {

  @override
  ScrollController _scrollController = ScrollController();
 void didChangeDependencies() async {
    super.didChangeDependencies();
     //list = await ;
  }
  Widget build(BuildContext context) {

    final shipmentId = ModalRoute.of(context)!.settings.arguments as int;

    print('PickingDriver: shipmentId=$shipmentId');
    Direction direction = context.locale.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    String title = 'Assign Driver';
  //  List<Package> packages = Provider.of<ShipmentProvider>(context, listen: false).packages;

    print('_ListAddressesState build ');
    double height = 150.0;


    return Scaffold(

      appBar: AppBar(
        title: WidgetUtil.text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child:FutureBuilder<List<Driver>>(
            future: Provider.of<OperatorProvider>(context, listen: false).getDrivers(),
            builder:(BuildContext context, AsyncSnapshot<List<Driver>> snapshot){
              return snapshot.hasData ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getChildren(shipmentId, snapshot.data, height, direction),
              ):
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading data from API...'),
                    )
                  ],
                ),
              ) ;

            } ,
          )
        ),
      ),
    );
  }

  List<Widget> getChildren(int shipmentId,
      List<Driver>? list, double height, Direction direction) {
    List<Widget> children = [];
    for (int i = 0; i < list!.length; i++) {
      children.add(const SizedBox(height: 10));
      children.add(InkWell(
          onTap: () {
            final driverId = list[i].id;
            print('selected cared index $i');
            //Navigator.pushNamed(context, '/s',arguments:list[i].id );
            Dialogs.SaveDialog('Are sure?', context, () async {
              print('hi');
              Navigator.of(context).pop();
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) {


                    Provider.of<OperatorProvider>(context, listen: false).addPickupshipmentToDriver(shipmentId,driverId,widget._shipmentStatus).then(
                            (value) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.popAndPushNamed(context, '/${widget._shipmentStatus.name}');
                            }
                    ).catchError(  (error) {

                      var errorMessage = ExceptionHandler.handleException(error);
                      print("errorMessage= $errorMessage error=$error");
                      if (errorMessage == ExceptionHandler.KUnAuthorized) {
                        errorMessage = ExceptionHandler.kInvalidCredentials;
                      }
                      Dialogs.showErrorDialog(errorMessage, context,() {Navigator.of(context).pop();Navigator.of(context).pop();},);

                    }
                    );

                    return  WillPopScope(

                      onWillPop: () async => false,
                      child: AlertDialog(
                        title: Text('saving ..'),
                        content: Text('saving ..'),
                        actions: <Widget>[
                        ],
                      ),
                    );


                  }
              );

              },);
          },
          child: CardWithColoredEdge(
            isRedEdge: false,
            120,
            Colors.blue.shade900,
            Colors.red,
            direction,
           // getWidget10( Colors.white,address: ),
          //  Container(height: 10,color: Colors.amberAccent),
            getWidget10(list[i], Colors.white),
          )));
    }
    return children;
  }

  Widget getWidget10( Driver driver,Color backgroundColor,) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Column(
        children: [

          Row(
            children: [
              Container(
                //  color: Colors.red,
                child: WidgetUtil.text('name', color: backgroundColor),
              ),
              SizedBox(width: 27),
              Container(
                //   color: Colors.red,
                child: WidgetUtil.text(":", color: backgroundColor),
              ),
              Expanded(
                child: Container(
                  //  color: Colors.red,
                  child: Text(
                    textAlign: TextAlign.center,
                    driver.account.fullName  ,
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(color: backgroundColor, fontFamily: 'loewm'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                //   color: Colors.red,
                child: WidgetUtil.text('Email', color: backgroundColor),
              ),
              SizedBox(width: 15),
              Container(
                //  color: Colors.red,
                child: WidgetUtil.text(":", color: backgroundColor),
              ),
              Expanded(
                child: Container(
                  //  color: Colors.red,
                  child: Text(
                    textAlign: TextAlign.center,
                    driver.account.email ,
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(color: backgroundColor, fontFamily: 'loewm'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                //  color: Colors.red,
                child:
                WidgetUtil.text('Mobile\nNumber', color: backgroundColor),
              ),
              SizedBox(width: 15),
              Container(
                //color: Colors.red,
                child: WidgetUtil.text(":", color: backgroundColor),
              ),
              Expanded(
                child: Container(
                  //  color: Colors.red,
                  child: Text(
                    textAlign: TextAlign.center,
                    driver.account.mobile ,
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(color: backgroundColor, fontFamily: 'loewm'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}