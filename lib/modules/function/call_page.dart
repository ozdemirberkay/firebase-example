import 'package:firebase_learning/modules/function/function_operations.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:firebase_learning/shared/widget/dialog/snackbar_dialog.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Center(
        child: FutureButton(
            onPressed: () async {
              var result = await FunctionOperations.sendCallMessage();

              if (!context.mounted) return;

              if (result.status) {
                Navigator.pop(context);
              } else {
                SnackbarDialog.show(context: context, message: result.message);
              }
            },
            text: "Call Cloud Function"),
      ),
    );
  }
}
