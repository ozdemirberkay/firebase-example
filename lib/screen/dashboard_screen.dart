import 'package:firebase_learning/screen/home_page.dart';
import 'package:firebase_learning/shared/widget/drawer/home_drawer.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseView(
      body: HomePage(),
      drawer: HomeDrawer(),
    );
  }
}
