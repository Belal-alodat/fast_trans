import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../models/package.dart';
import '../../providers/customer_provider.dart';
import '../../models/package.dart';
import '../../util/widget_util.dart';
import '../../widget/card_with_colored_edge.dart';

class ListPackagesPage extends StatefulWidget {
  const ListPackagesPage();
  @override
  _ListPackagesState createState() => _ListPackagesState();
}

class _ListPackagesState extends State<ListPackagesPage> {



  ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    Direction direction = context.locale.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    String title = 'packages';
    List<Package> packages = Provider.of<CustomerProvider>(context, listen: false).packages;

    print('_ListAddressesState build ');
    double height = 150.0;


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //_counter++;
          await Navigator.pushNamed(context, '/package', arguments: title);
          setState(() {
            print('setState ');
            _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease);
          });
        },
        tooltip: 'Create Package',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: WidgetUtil.text(title),
      ),
      body: SafeArea(
        child: getList1(packages,height,  direction),
       // child: getList2(height,  direction),
      ),
    );
  }

  Widget getList1(List<Package> packages,double height, Direction direction) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getChildren(packages, height, direction),
      ),
    );
  }
  Widget getList2(double height, Direction direction){
   return  SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child:FutureBuilder<List<Package>>(
          future: Provider.of<CustomerProvider>(context, listen: false).getPackages2(),
          builder:(BuildContext context, AsyncSnapshot<List<Package>> snapshot){
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
    );
  }

  List<Widget> getChildren(
      List<Package>? packages, double height, Direction direction) {
    List<Widget> children = [];
    if(packages != null)
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

  Widget getWidget10(Package shipmentPackage, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
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
                  color: shipmentPackage.favourite ? Colors.red :Colors.white70,
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
                child: WidgetUtil.text('product', color: backgroundColor),
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
                    shipmentPackage.product?.name ?? '',
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
                    shipmentPackage.dimension?.name ?? '',
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
