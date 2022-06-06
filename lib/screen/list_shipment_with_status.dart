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
import '../providers/Auth.dart';
import '../providers/shipments_provider.dart';

class ListShipmentWithStatus extends StatefulWidget {
  final List<ShipmentStatus> _shipmentStatus;
  final String _title ;
  final String _basepath;
  final String _childScreen;
  final String? floatingActionButtonPath;
  ListShipmentWithStatus(this._shipmentStatus,this._title,this._basepath,this._childScreen,{this.floatingActionButtonPath});
  @override
  _ListShipmentWithStatusState createState() => _ListShipmentWithStatusState();
}

class _ListShipmentWithStatusState extends State<ListShipmentWithStatus> {
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

   // String title = 'List shipment ${widget._shipmentStatus.name}';
    //  print('_ListAddressesState build ');
    double height = 150.0;
    return Scaffold(
        floatingActionButton: widget.floatingActionButtonPath != null ?
        FloatingActionButton(
          onPressed: () async {
            //_counter++;
            await Navigator.pushNamed(context, widget.floatingActionButtonPath!);
            setState(() {
              print('setState ');
            });
          },
          tooltip: 'Create Package',
          child: const Icon(Icons.add),
        ):null,
      appBar: AppBar(
        title: WidgetUtil.text(widget._title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child:FutureBuilder<List<Shipment>>(
            future: Provider.of<ShipmentsProvider>(context, listen: false).getShipmentsWithStatus(widget._shipmentStatus,basepath: widget._basepath),
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
            Navigator.pushNamed(context,widget._childScreen,arguments:list[i] ).then((value) => setState(() {
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
    var address = shipment.toAddress;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Column(
        children: [
          getRowWidget(backgroundColor,'id', '${shipment.id}'),
          SizedBox(height: 10),
          getRowWidget(backgroundColor,'Customer name', address.fullName ?? ''),
          SizedBox(height: 10),
          getRowWidget(backgroundColor,'Address', '${address.city?.name}-${address.town?.name}-${address.village?.name}'),
          SizedBox(height: 10),
          getRowWidget(backgroundColor,'Mobile\nNumber','${address.mobile}'),
          SizedBox(height: 10),
          getRowWidget(backgroundColor,'Status', Provider.of<Auth>(context, listen: false).getShipmentStatusLabel(shipment.status))
        ],
      ),
    );
  }

  Widget getRowWidget(Color backgroundColor,String label ,String value){
   return Row(
     children: [
       Container(
         //  color: Colors.red,
         child:
         WidgetUtil.text(label, color: backgroundColor),
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
             value,
             overflow: TextOverflow.ellipsis,
             style:
             TextStyle(color: backgroundColor, fontFamily: 'loewm'),
           ),
         ),
       ),
     ],
   );
  }

}