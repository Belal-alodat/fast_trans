import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../models/address.dart';
import '../../providers/operator_provider.dart';
import '../../providers/customer_provider.dart';
import '../../models/package.dart';
import '../../rest/shipment_api.dart';
import '../../util/widget_util.dart';
import '../../widget/card_with_colored_edge.dart';



class OperatorListShipment extends StatefulWidget {
  ShipmentStatus _shipmentStatus;
    OperatorListShipment(this._shipmentStatus);
  @override
  _OperatorListShipmentState createState() => _OperatorListShipmentState();
}

class _OperatorListShipmentState extends State<OperatorListShipment> {
  List<Shipment> list = [];
  @override
  ScrollController _scrollController = ScrollController();
 void didChangeDependencies() async {
    super.didChangeDependencies();
     //list = await ;
  }
  Widget build(BuildContext context) {
    Direction direction = context.locale.languageCode == 'ar'
        ? Direction.left
        : Direction.right;



    String title = 'List shipment ${widget._shipmentStatus.name}';
    //  print('_ListAddressesState build ');
    double height = 150.0;


    return Scaffold(


      appBar: AppBar(
        title: WidgetUtil.text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child:FutureBuilder<List<Shipment>>(
            future: Provider.of<OperatorProvider>(context, listen: false).getShipmentsWithStatus([widget._shipmentStatus]),
            builder:(BuildContext context, AsyncSnapshot<List<Shipment>> snapshot){
              return snapshot.hasData ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getChildren( snapshot.data, height, direction),
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

  List<Widget> getChildren(
      List<Shipment>? list, double height, Direction direction) {
    List<Widget> children = [];
    for (int i = 0; i < list!.length; i++) {
      children.add(const SizedBox(height: 10));
      children.add(InkWell(
          onTap: ()async {
            print('selected cared index $i');
            Navigator.pushNamed(context, '/operators/UpdateShipmentPage',arguments:list[i] ).then((value) => setState(() {
            }))   ;

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

  Widget getWidget10( Shipment shipment,Color backgroundColor,) {
    var address = shipment.fromAddress;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                height: 30,
                width: 30,
                alignment: Alignment.center,
                // padding: const EdgeInsets.fromLTRB(0, 0, 15, 25),
                //    color: Colors.black,

                child: Icon(
                  Icons.favorite,
                  color: address.favourite ? Colors.red :Colors.white70,
                  //size: 30,

                ),
                //  color: Colors.black,
              ),

            ],
          ),
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
                    address.fullName ?? '',
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
                child: WidgetUtil.text('Address', color: backgroundColor),
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
                    '${address.city?.name}-${address.town?.name}-${address.village?.name}',
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
                    address.mobile??'',
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