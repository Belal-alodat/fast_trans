import 'package:flutter/material.dart';

class RoundElevatedButton extends StatelessWidget {
  const RoundElevatedButton({
    Key? key,
    this.onPressed,
    this.radius = 35.0,
    this.minimumSizeFromHeight = 50.0,
    this.buttonText = 'login',
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.textStyleFontFamily = 'loewm',
    this.textFontSize = 14,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String buttonText;
  final double radius;
  final double minimumSizeFromHeight;
  final Color color;
  final Color textColor;
  final double textFontSize;
  final String textStyleFontFamily;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
              Size.fromHeight(minimumSizeFromHeight)),
          foregroundColor: MaterialStateProperty.all<Color>(color),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: color),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              color: textColor,
              fontSize: textFontSize,
              fontFamily: textStyleFontFamily),
        ));
  }
}
