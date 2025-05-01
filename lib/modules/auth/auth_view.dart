import 'package:firebase_learning/modules/auth/auth_operations.dart';
import 'package:firebase_learning/modules/auth/user_verify.dart';
import 'package:firebase_learning/screen/dashboard_screen.dart';
import 'package:firebase_learning/shared/model/result_model.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:firebase_learning/shared/widget/dialog/snackbar_dialog.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:firebase_learning/shared/widget/input/input_field.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleResult(ResultModel result) async {
    if (result.status) {
      var user = await AuthOperations.getReloadedUser();
      if (!mounted) return;
      if (user == null) {
        SnackbarDialog.show(context: context, message: result.message);
        return;
      } else if (user.emailVerified) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UserVerifyPage()));
      }
    } else {
      SnackbarDialog.show(context: context, message: result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InputField(
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            InputField(
              label: "Password",
              obscureText: true,
              controller: passwordController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureButton(
                    onPressed: () async {
                      ResultModel result = await AuthOperations.signIn(
                          email: emailController.text,
                          password: passwordController.text);
                      await handleResult(result);
                    },
                    text: "Sign In"),
                FutureButton(
                    onPressed: () async {
                      ResultModel result = await AuthOperations.createUser(
                          email: emailController.text,
                          password: passwordController.text);
                      await handleResult(result);
                    },
                    text: "Sign Up"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
