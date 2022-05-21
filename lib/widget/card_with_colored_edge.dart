import 'package:flutter/material.dart';

enum Direction { right, left }

class CaredWithColoredEdge extends StatelessWidget {
  final double height;
  final Color backGroundColor;
  final Color edgeColor;
  final Direction direction;
  final Widget child;
  List<Widget>? row3children;
  CaredWithColoredEdge(
    this.height,
    this.backGroundColor,
    this.edgeColor,
    this.direction,
    this.child, {
    List<Widget>? row3children,
    Key? key,
  }) : super(key: key) {
    this.row3children = row3children;
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
