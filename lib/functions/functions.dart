import 'package:flutter/material.dart';
import 'package:web_admin/global/global.dart';

showReusableSnackBar(String title, BuildContext context) {
  SnackBar snackBar = SnackBar(
    backgroundColor: appDeeperPrimaryColor,
    duration: const Duration(seconds: 2),
    content: text(title, fontSize: 32, color: Colors.white),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
