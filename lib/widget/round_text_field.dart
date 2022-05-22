import 'package:flutter/material.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class RoundTextField extends StatelessWidget {
  final Color iconColor;

  final Color hintTextColor;

  final double radius;

  final double hintFontSize;

  final double contentPadding;
  final bool isDrop;
  final double bottomPadding;
  final String labelText;
  final TextEditingController controller;
  final List<String> items;
  const RoundTextField(
      {Key? key,
      required this.controller,
      this.enabledBorderSideColor = Colors.white,
      this.hintTextColor = Colors.white,
      this.focusedBorderSideColor = Colors.white,
      this.iconColor = Colors.white,
      this.icon = Icons.abc,
      this.items = const [],
      this.isDrop = false,
      this.hintText = '',
      this.labelText = '',
      this.hintFontSize = 14.0,
      this.contentPadding = 10.0,
      this.bottomPadding = 8.0,
      this.isPassword = false,
      this.isEmail = false,
      this.isRadius = true,
      this.onSelected,
      this.radius = 35.0})
      : super(key: key);
  final PopupMenuItemSelected<String>? onSelected;
  final IconData? icon;
  final String hintText;
  final bool isPassword;
  final bool isRadius;
  final bool isEmail;
  final Color enabledBorderSideColor;

  final Color focusedBorderSideColor;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = isRadius
        ? OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderSideColor),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          )
        : OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderSideColor),
            // borderRadius: BorderRadius.all(Radius.circular(radius)),
          );
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: TextField(
        readOnly: isDrop,
        // focusNode: AlwaysDisabledFocusNode(),
        style: TextStyle(fontSize: hintFontSize, color: hintTextColor),
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: isDrop
              ? PopupMenuButton<String>(
                  color: Colors.blue.shade900,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  onSelected: onSelected,
                  itemBuilder: (BuildContext context) {
                    return items.map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem(child: text(value), value: value);
                    }).toList();
                  },
                )
              : null,
          // fillColor: Colors.white,

          //   filled: true,
          labelText: labelText,
          labelStyle: TextStyle(fontSize: hintFontSize, color: hintTextColor),
          prefixIcon: icon == Icons.abc
              ? null
              : Icon(
                  icon,
                  color: iconColor,
                ),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          contentPadding: EdgeInsets.all(contentPadding),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: hintFontSize, color: hintTextColor),
        ),
      ),
    );
  }

  Widget text(
    String text, {
    Color color = Colors.white,
    double size = 14,
    String font = 'm',
  }) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontFamily: 'loew$font'),
      softWrap: true,
    );
  }
}
