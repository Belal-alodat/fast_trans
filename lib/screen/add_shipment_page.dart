import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_session.dart';
import '../providers/Auth.dart';
import '../widget/card_with_colored_edge.dart';
import '../widget/round_elevated_button.dart';

class AddShipmentPage extends StatefulWidget {
  @override
  _AddShipmentState createState() => _AddShipmentState();
}

class _AddShipmentState extends State<AddShipmentPage> {
  Widget text(
    String text, {
    Color color = Colors.black,
    double size = 14,
    String font = 'm',
  }) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontFamily: 'loew$font'),
      softWrap: true,
    );
  }

  Widget build(BuildContext context) {
    double height = 50.0;
    Direction direction = AppSession.instance.languageCode == 'ar'
        ? Direction.left
        : Direction.right;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: /*Stack(
          alignment: Alignment.center,
          children: [*/
            SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24),
              InkWell(
                onTap: from,
                child: CaredWithColoredEdge(
                  height,
                  Colors.blueAccent,
                  Colors.red,
                  direction,
                  // getWidget1('images/from.png', 'From'),
                  getWidget10('images/from.png', 'From', 'From From From',
                      Colors.white),
                  row3children: getRow3Widget(height),
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: To,
                child: CaredWithColoredEdge(
                  height,
                  Colors.blueAccent,
                  Colors.red,
                  direction,
                  getWidget10(
                      'images/to.png', 'To', 'To To To To', Colors.white),
                  row3children: getRow3Widget(height),
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: PackageDetails,
                child: CaredWithColoredEdge(
                  height,
                  Colors.blueAccent,
                  Colors.red,
                  direction,
                  getWidget10('images/packagedetails.png', 'Package Details',
                      'Package Details', Colors.white),
                  row3children: getRow3Widget(height),
                ),
              ),
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
                          onPressed: () {},
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
        /*],
        ),*/
      ),
    );
  }

  logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
  }

  Widget getButtonText(String text2) {
    Widget child2 = text(text2, color: Colors.white);
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

  Widget getWidget10(String imagePath, String textLabel1, String textLabel2,
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
            child: text(textLabel1, color: backgroundColor),
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

  List<Widget> getRow3Widget(double height) {
    return [
      Center(
        child: Container(
          height: height,
          //  color: Colors.amberAccent,
          child: Icon(
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

  Widget getWidget1(
    String imagePath,
    String textLabel,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
              color: Colors.red,
              child: Image.asset(imagePath, fit: BoxFit.fill),
            ),
            const SizedBox(width: 20),
            Container(
              color: Colors.red,
              child: text(textLabel, color: Colors.white),
            ),
          ]),
        ],
      ),
    );
  }

  void from() {
    Navigator.pushNamed(context, '/list-addresses');
  }

  void PackageDetails() {
    Navigator.pushNamed(context, '/text');
  }

  void To() {
    Navigator.pushNamed(context, '/list-addresses');
  }
}
