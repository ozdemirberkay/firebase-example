import 'dart:async';

import 'package:firebase_learning/modules/auth/auth_operations.dart';
import 'package:firebase_learning/modules/auth/auth_view.dart';
import 'package:firebase_learning/screen/dashboard_screen.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:firebase_learning/shared/widget/dialog/snackbar_dialog.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class UserVerifyPage extends StatefulWidget {
  const UserVerifyPage({super.key});

  @override
  State<UserVerifyPage> createState() => _UserVerifyPageState();
}

class _UserVerifyPageState extends State<UserVerifyPage> {
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      var user = await AuthOperations.getReloadedUser();

      if (user?.emailVerified == true) {
        _timer!.cancel();
        if (!mounted) return;

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Account not verified"),
          FutureButton(
              onPressed: () async {
                await AuthOperations.sendEmailVerification();
              },
              text: "Send verification email"),
          FutureButton(
              onPressed: () async {
                var result = await AuthOperations.signOut();

                if (!context.mounted) return;

                if (result.status) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AuthPage()));
                } else {
                  SnackbarDialog.show(
                      context: context, message: result.message);
                }
              },
              text: "Sign Out"),
        ],
      ),
    ));
  }
}
