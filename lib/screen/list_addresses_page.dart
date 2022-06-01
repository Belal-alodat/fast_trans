import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../models/address.dart';
import '../providers/shipment_provider.dart';
import '../util/widget_util.dart';
import '../widget/card_with_colored_edge.dart';

class ListAddressesPage extends StatefulWidget {
  const ListAddressesPage();
  @override
  _ListAddressesState createState() => _ListAddressesState();
}

class _ListAddressesState extends State<ListAddressesPage> {

  ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    Direction direction = context.locale.languageCode == 'ar'
        ? Direction.left
        : Direction.right;


    List<Address> addresses =  Provider.of<ShipmentProvider>(context, listen: false).fromAddresses;
    final title = ModalRoute.of(context)!.settings.arguments as String;
    if (title == 'To') {
      print('toAddresses');
      addresses =  Provider.of<ShipmentProvider>(context, listen: false).toAddresses;
    } else {
      print('fromAddresses');
    }

    print('_ListAddressesState build ');
    double height = 150.0;


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //_counter++;
          await Navigator.pushNamed(context, '/address', arguments: title);
          //Address address2 = addr2!;
          //AppSession.instance.addresses.add(address2);
          setState(() {
            print('setState ');
            _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease);
          });
        },
        tooltip: 'Create Address',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: WidgetUtil.text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getChildren(addresses, height, direction),
          ),
        ),
      ),
    );
  }

  List<Widget> getChildren(
      List<Address> addresses, double height, Direction direction) {
    List<Widget> children = [];
    for (int i = 0; i < addresses.length; i++) {
      children.add(const SizedBox(height: 10));
      children.add(InkWell(
          onTap: () {
            print('selected cared index $i');
            Navigator.pop(context, '$i');
          },
          child: CardWithColoredEdge(
            isRedEdge: false,
            row3children: getRow3Widget(120, i),
            120,
            Colors.blue.shade900,
            Colors.red,
            direction,
            // getWidget1('images/from.png', 'From'),
            getWidget10(addresses[i], Colors.white),
          )));
    }
    return children;
  }

  List<Widget> getRow3Widget(double height, int index) {
    return [
      Center(
        child: Column(
          children: [
            Container(
              height: height / 2,
              //   color: Colors.amberAccent,
              child: InkWell(
                onTap: () {
                  print('selected edit Icone index $index');
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white70,
                  //size: 30,
                ),
              ),
              //  color: Colors.black,
            ),
            Container(
              height: height / 2,
              //  color: Colors.amberAccent,
              child: InkWell(
                onTap: () {
                  print('selected share index $index');
                },
                child: Icon(
                  Icons.share,
                  color: Colors.white70,
                  //size: 30,
                ),
              ),
              //  color: Colors.black,
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
    ];
  }

  Widget getWidget10(Address address, Color backgroundColor) {
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
