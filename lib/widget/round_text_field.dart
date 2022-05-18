import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  final Color iconColor;

  final Color hintTextColor;

  final double radius;

  final double hintFontSize;

  final double contentPadding;

  final double bottomPadding;

  final TextEditingController controller;

  const RoundTextField(
      {Key? key,
      required this.controller,
      this.enabledBorderSideColor = Colors.white,
      this.hintTextColor = Colors.white,
      this.focusedBorderSideColor = Colors.white,
      this.iconColor = Colors.white,
      this.icon = Icons.abc,
      this.hintText = '',
      this.hintFontSize = 14.0,
      this.contentPadding = 10.0,
      this.bottomPadding = 8.0,
      this.isPassword = false,
      this.isEmail = false,
      this.radius = 35.0})
      : super(key: key);
  final IconData? icon;
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final Color enabledBorderSideColor;

  final Color focusedBorderSideColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: icon == Icons.abc
              ? null
              : Icon(
                  icon,
                  color: iconColor,
                ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderSideColor),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderSideColor),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          contentPadding: EdgeInsets.all(contentPadding),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: hintFontSize, color: hintTextColor),
        ),
      ),
    );
  }
}
