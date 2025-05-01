import 'package:firebase_learning/modules/auth/auth_view.dart';
import 'package:firebase_learning/modules/auth/auth_operations.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:firebase_learning/shared/widget/dialog/snackbar_dialog.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
        body: Column(
      children: [
        FutureButton(
            onPressed: () async {
              var result = await AuthOperations.signOut();

              if (!context.mounted) return;

              if (result.status) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AuthPage()));
              } else {
                SnackbarDialog.show(context: context, message: result.message);
              }
            },
            text: "Sign Out"),
      ],
    ));
  }
}
