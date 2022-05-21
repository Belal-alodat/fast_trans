import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Auth.dart';

class TextPage extends StatefulWidget {
  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int selectedPos = 0;

  String imageTitle = "images/city.png";

  Widget text(
    String text, {
    Color color = Colors.black,
    double size = 14,
    String font = 'm',
  }) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontFamily: 'loew$font'),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CaredWithColoredEdge(
            100,
            Colors.blueAccent,
            Colors.red,
            Direction.right,
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  Container(
                    child: Image.asset('images/packagedetails.png',
                        fit: BoxFit.fill),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    child: text('test', color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      //  color: Colors.red,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Add long dddddddssssdddddddddddddddfsssssssssssffffffffffsssssssssssssssdddddddddddddddtext ',
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget build2(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'Add long text hereddd dddddddddddddddddd Add long text dddsss  sss sddddddd Add long text',
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    width: 20,
                    height: 30,
                    child: text('textLabel', color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black,
                    height: 50,
                    width: 300,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
  }
}

enum Direction { right, left }

class CaredWithColoredEdge extends StatelessWidget {
  final double height;
  final Color backGroundColor;
  final Color edgeColor;
  final Direction direction;
  final Widget child;
  //bool row3 = false;
  List<Widget>? row3children;

  CaredWithColoredEdge(
    this.height,
    this.backGroundColor,
    this.edgeColor,
    this.direction,
    this.child, {
    // bool? row3,
    List<Widget>? row3children,
    Key? key,
  }) : super(key: key) {
    this.row3children = row3children;
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

  @override
  Widget build(BuildContext context) {
    var aligDirection = direction == Direction.right
        ? MainAxisAlignment.end
        : MainAxisAlignment.end;
    var borderDirection = direction == Direction.right
        ? BorderRadius.only(
            topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
        : BorderRadius.only(
            topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0));
    return Stack /*Column*/ (
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: backGroundColor,
                  border: Border.all(
                    width: 4,
                    // color: MyColor.TxtColorOrange,
                    color: backGroundColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: child,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: aligDirection,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height,
              //  width: 5,
              decoration: BoxDecoration(
                //  color: edgeColor, //Colors.black,
                border: Border.all(
                  width: 4,
                  // color: MyColor.TxtColorOrange,
                  color: edgeColor,
                ),
                borderRadius: borderDirection,
              ),
            ),
          ],
        ),
        if (row3children != null)
          Row(
            mainAxisAlignment: aligDirection,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: row3children ?? const <Widget>[],
          ),
      ],
    );
  }
}
