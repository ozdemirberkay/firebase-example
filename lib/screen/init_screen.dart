import 'package:firebase_learning/modules/auth/auth_view.dart';
import 'package:firebase_learning/modules/auth/auth_operations.dart';
import 'package:firebase_learning/modules/auth/user_verify.dart';
import 'package:firebase_learning/screen/dashboard_screen.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthOperations.getReloadedUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BaseView(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return snapshot.data != null
              ? snapshot.data!.emailVerified
                  ? const DashboardScreen()
                  : const UserVerifyPage()
              : const AuthPage();
        });
  }
}
