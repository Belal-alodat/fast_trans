import 'package:flutter/material.dart';

import '../core/app_session.dart';
import '../models/shipment_package.dart';
import '../util/widget_util.dart';
import '../widget/card_with_colored_edge.dart';

class ListPackagesPage extends StatefulWidget {
  const ListPackagesPage();
  @override
  _ListPackagesState createState() => _ListPackagesState();
}

class _ListPackagesState extends State<ListPackagesPage> {
  int _counter = 0;
  Widget build(BuildContext context) {
    String title = 'packages';
    List<ShipmentPackage> packages = AppSession.instance.packages;

    print('_ListAddressesState build ');
    double height = 150.0;
    Direction direction = AppSession.instance.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //_counter++;
          await Navigator.pushNamed(context, '/package', arguments: title);
          setState(() {
            print('setState ');
          });
        },
        tooltip: 'Create Package',
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
            children: getChildren(packages, height, direction),
          ),
        ),
      ),
    );
  }

  List<Widget> getChildren(
      List<ShipmentPackage> packages, double height, Direction direction) {
    List<Widget> children = [];
    for (int i = 0; i < packages.length; i++) {
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
            getWidget10(packages[i], Colors.white),
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

  Widget getWidget10(ShipmentPackage shipmentPackage, Color backgroundColor) {
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
                    shipmentPackage.product.name,
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
                child: WidgetUtil.text('price\nweight\npieces',
                    color: backgroundColor),
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
                    '${shipmentPackage.price}-${shipmentPackage.weight}-${shipmentPackage.pieces}',
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
                child: WidgetUtil.text('Dimension', color: backgroundColor),
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
                    shipmentPackage.dimension.name,
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
