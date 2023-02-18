// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

bool dev = true;
double defaulButtonVerticalPadding = 20;
double defaulButtonHorizontalPadding = 140;

//default Element colors
Color defaultBackgroundColor = Colors.black;
Color appPrimaryColor = Colors.purple;
Color appAccentPrimaryColor = Colors.purpleAccent;
Color appDeeperPrimaryColor = Colors.deepPurple;

printo(String text) {
  // ignore: avoid_print
  return print(text);
}

SizedBox sizedBox({double? width, double? height, Widget? child}) {
  return SizedBox(
    width: width,
    height: height,
    child: child,
  );
}

ElevatedButton elevatedButton({
  required Function() onPressed,
  required String title,
  EdgeInsetsGeometry? padding,
  Color? backgroundColor,
  Color? textColor,
  double? letterSpacing,
  double? fontSize,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        padding: padding ??
            EdgeInsets.symmetric(
                horizontal: defaulButtonHorizontalPadding,
                vertical: defaulButtonVerticalPadding),
        backgroundColor: backgroundColor ?? Colors.deepPurpleAccent),
    child: Text(
      title,
      style: TextStyle(
        color: textColor ?? Colors.white,
        letterSpacing: letterSpacing ?? 1,
        fontSize: fontSize ?? 16,
      ),
    ),
  );
}

TextField textField(
    {required Function(dynamic value) onChanged,
    double? textSize,
    Color? color,
    required String hintText,
    Color? hintTextColor,
    required IconData icon,
    Color? iconColor,
    Color? focusBorderColor,
    Color? borderColor,
    bool? obscureText}) {
  return TextField(
    onChanged: onChanged,
    obscureText: obscureText ?? false,
    style: TextStyle(
      fontSize: textSize ?? 16,
      color: color ?? Colors.white,
    ),
    decoration: InputDecoration(
      hintText: hintText,
      icon: Icon(
        icon,
        color: iconColor ?? Colors.deepPurpleAccent,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor ?? Colors.deepPurpleAccent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusBorderColor ?? Colors.white54,
        ),
      ),
      hintStyle: TextStyle(
        color: hintTextColor ?? Colors.grey,
      ),
    ),
  );
}

Widget text(String data,
    {Color? color,
    double? letterSpacing,
    double? fontSize,
    FontWeight? fontWeight}) {
  return Text(
    data,
    style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.white,
        letterSpacing: letterSpacing ?? 2,
        fontSize: fontSize ?? 16),
  );
}
