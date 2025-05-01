import 'package:firebase_learning/modules/firestore/firestore_operations.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:firebase_learning/shared/widget/dialog/snackbar_dialog.dart';
import 'package:firebase_learning/shared/widget/input/input_field.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController ideaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
        body: Column(
      children: [
        InputField(
          label: "Idea",
          controller: ideaController,
        ),
        FutureButton(
            onPressed: () async {
              var result =
                  await FirestoreOperations.addIdea(idea: ideaController.text);

              if (!context.mounted) return;

              if (result.status) {
                Navigator.pop(context);
              } else {
                SnackbarDialog.show(context: context, message: result.message);
              }
            },
            text: "Share"),
      ],
    ));
  }
}
