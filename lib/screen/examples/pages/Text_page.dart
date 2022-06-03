import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/Auth.dart';

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
          child: myWidget(context),
        ),
      ),
    );
  }

  Widget myCard() {
    return Card(
      color: Colors.blue,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      elevation: 24.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () async {
//no action
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//   width: double.infinity,
//    height: 200, //75  //no wrap to set indicator at end
          child: Row(
            children: <Widget>[
//add expanded to get full view area
              Expanded(
                child: Column(
//   mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
//  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'transfer',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            letterSpacing: 1.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "\u20B9 123",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.amberAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'transfer',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            letterSpacing: 1.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "\u20B9 123",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.amberAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'transfer',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            letterSpacing: 1.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "\u20B9 123",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.amberAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

//  SizedBox(width: 20.0),

              Container(
                decoration: BoxDecoration(
//  color: edgeColor, //Colors.black,
                  border: Border.all(
                    width: 4,
// color: MyColor.TxtColorOrange,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                ),
              ),
              SizedBox(width: 1.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget myWidget(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.37),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return myCard() /*Card(
              color: Colors.amber,
              child: Center(child: Text('$index')),
            )*/
                ;
          }),
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
