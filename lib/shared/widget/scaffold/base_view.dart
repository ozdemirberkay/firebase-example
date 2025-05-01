import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  final Widget body;
  final Widget? drawer;
  const BaseView({super.key, required this.body, this.drawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Example"),
      ),
      drawer: drawer,
      body: body,
    );
  }
}
