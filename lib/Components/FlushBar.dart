import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/Components/Constants.dart';

class Warning {
  void errorMessage(BuildContext context,
      {@required String title,
      @required String message,
      @required IconData icons}) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(
        icons,
        size: 28,
        color: SubMainColor,
      ),
      borderColor: SubMainColor,
      borderWidth: 5,
      duration: Duration(seconds: 3),
      borderRadius: 18,
    )..show(context);
  }
}
