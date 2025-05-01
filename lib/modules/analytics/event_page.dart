import 'package:firebase_learning/modules/analytics/analytics_operations.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:firebase_learning/shared/widget/dialog/snackbar_dialog.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Center(
        child: FutureButton(
            onPressed: () async {
              var result = await AnalyticsOperations.addEvent();

              if (!context.mounted) return;

              if (result.status) {
                Navigator.pop(context);
              } else {
                SnackbarDialog.show(context: context, message: result.message);
              }
            },
            text: "Event with Current User"),
      ),
    );
  }
}
