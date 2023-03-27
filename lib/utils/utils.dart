import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static void toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void flushBarErrorMessages(
      String message, String titile, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          borderRadius: BorderRadius.circular(8),
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          padding: const EdgeInsets.all(15),
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 25,
            color: Colors.white,
          ),
          flushbarPosition: FlushbarPosition.TOP,
          message: message,
          title: titile,
          duration: const Duration(seconds: 2),
        )..show(context));
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 16, 51, 69),
        content: Text(message)));
  }
}
