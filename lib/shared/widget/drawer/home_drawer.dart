import 'package:firebase_learning/modules/auth/auth_view.dart';
import 'package:firebase_learning/modules/auth/auth_operations.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:firebase_learning/shared/widget/dialog/snackbar_dialog.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Center(child: Text("Firebase Example")),
          ),
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
    );
  }
}
