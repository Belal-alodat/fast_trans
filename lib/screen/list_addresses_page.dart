import 'package:flutter/material.dart';

import '../core/app_session.dart';
import '../widget/card_with_colored_edge.dart';

class ListAddressesPage extends StatefulWidget {
  @override
  _ListAddressesState createState() => _ListAddressesState();
}

class _ListAddressesState extends State<ListAddressesPage> {
  Widget build(BuildContext context) {
    double height = 150.0;
    Direction direction = AppSession.instance.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getChildren(height, direction),
          ),
        ),
      ),
    );
  }

  List<Widget> getChildren(double height, Direction direction) {
    List<Widget> children = [];
    for (int i = 0; i < 2; i++) {
      children.add(const SizedBox(height: 10));
      children.add(InkWell(
          onTap: () {
            print('selected cared index $i');
          },
          child: CaredWithColoredEdge(
            row3children: getRow3Widget(120, i),
            120,
            Colors.blueAccent,
            Colors.red,
            direction,
            // getWidget1('images/from.png', 'From'),
            getWidget10('images/from.png', 'Name', 'Mohammad AlodatMohammad ',
                Colors.white),
          )));
    }
    return children;
  }

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

  List<Widget> getRow3Widget(double height, int index) {
    return [
      Center(
        child: Column(
          children: [
            Container(
              height: height / 2,
              color: Colors.amberAccent,
              child: InkWell(
                onTap: () {
                  print('selected Icone index $index');
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
                  print('selected Icone index $index');
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

  Widget getWidget10(String imagePath, String textLabel1, String textLabel2,
      Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                //  color: Colors.red,
                child: text(textLabel1, color: backgroundColor),
              ),
              SizedBox(width: 27),
              Container(
                //   color: Colors.red,
                child: text(":", color: backgroundColor),
              ),
              Expanded(
                child: Container(
                  //  color: Colors.red,
                  child: Text(
                    textAlign: TextAlign.center,
                    textLabel2,
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
                child: text('Address', color: backgroundColor),
              ),
              SizedBox(width: 15),
              Container(
                //  color: Colors.red,
                child: text(":", color: backgroundColor),
              ),
              Expanded(
                child: Container(
                  //  color: Colors.red,
                  child: Text(
                    textAlign: TextAlign.center,
                    textLabel2,
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
                child: text('Mobile\nNumber', color: backgroundColor),
              ),
              SizedBox(width: 15),
              Container(
                //color: Colors.red,
                child: text(":", color: backgroundColor),
              ),
              Expanded(
                child: Container(
                  //  color: Colors.red,
                  child: Text(
                    textAlign: TextAlign.center,
                    textLabel2,
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
