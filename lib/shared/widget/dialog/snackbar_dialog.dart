import 'package:flutter/material.dart';

class SnackbarDialog {
  static void show({required BuildContext context, required String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? "Something went wrong"),
    ));
  }
}
