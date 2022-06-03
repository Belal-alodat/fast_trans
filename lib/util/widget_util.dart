import 'package:flutter/material.dart';

import '../widget/round_text_field.dart';

class WidgetUtil {
  static Widget text(
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

  static List<Widget> getRow3Widget(double height, int index) {
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
  static Widget buildTextField(
      String labelText,
      controller, {
        bool isDrop = false,
        List<String> items = const [],
        PopupMenuItemSelected<String>? onSelected,
        Color borderSideColor =   Colors.white,
        Color iconColor = const Color(0xFFB6C7D1),
        Color hintTextColor =const Color(0xFFB6C7D1),

      }) {
    return RoundTextField(
      labelText: labelText,
      isRadius: false,
      isDrop: isDrop,
      items: items,
      onSelected: onSelected,
      // hintText: "info@demouri.com",
      hintTextColor: hintTextColor,
      hintFontSize: 14.0,
      //     icon: Icons.mail_outline,
      iconColor: iconColor,
      bottomPadding: 10,
      controller: controller,
      enabledBorderSideColor: borderSideColor,
      focusedBorderSideColor: borderSideColor,
      //   isEmail: true,
    );
  }

  static Widget getButtonText(String text2,double height) {
    Widget child2 = WidgetUtil.text(text2, color: Colors.white);
    Widget c2 = Container(
      alignment: Alignment.center,
      //color: Colors.red,
      //   width: 90,
      height:height ,
      // padding: const EdgeInsets.all(10.0),
      child: child2,
    );
    return c2;
  }
}
