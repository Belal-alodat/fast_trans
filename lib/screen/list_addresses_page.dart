import 'package:flutter/material.dart';

import '../core/app_session.dart';
import '../rest/address_api.dart';
import '../util/widget_util.dart';
import '../widget/card_with_colored_edge.dart';

class ListAddressesPage extends StatefulWidget {
  const ListAddressesPage();
  @override
  _ListAddressesState createState() => _ListAddressesState();
}

class _ListAddressesState extends State<ListAddressesPage> {
  int _counter = 0;
  Widget build(BuildContext context) {
    List<Address> addresses = AppSession.instance.fromAddresses;
    final title = ModalRoute.of(context)!.settings.arguments as String;
    if (title == 'To') {
      print('toAddresses');
      addresses = AppSession.instance.toAddresses;
    } else {
      print('fromAddresses');
    }

    print('_ListAddressesState build ');
    double height = 150.0;
    Direction direction = AppSession.instance.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //_counter++;
          await Navigator.pushNamed(context, '/address', arguments: title);
          //Address address2 = addr2!;
          //AppSession.instance.addresses.add(address2);
          setState(() {
            print('setState ');
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
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
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
                    address.fullName,
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
                    '${address.city.name}-${address.town.name}-${address.village.name}',
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
                    address.mobile,
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
