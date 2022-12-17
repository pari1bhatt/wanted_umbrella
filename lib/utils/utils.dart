import 'package:flutter/material.dart';

class Utils {
  static showSnackBar(BuildContext context, String msg,
      {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      // backgroundColor: isSuccess ? Colors.green : Colors.red,
    ));
  }

}