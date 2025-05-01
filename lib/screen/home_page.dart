import 'package:firebase_learning/modules/analytics/event_page.dart';
import 'package:firebase_learning/modules/firestore/list_page.dart';
import 'package:firebase_learning/modules/function/call_page.dart';
import 'package:firebase_learning/modules/storage/photo_add_page.dart';
import 'package:firebase_learning/modules/firestore/add_page.dart';
import 'package:firebase_learning/modules/storage/photo_list_page.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ListPage()),
                );
              },
              text: "List Ideas"),
          FutureButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddPage()),
                );
              },
              text: "Add Idea"),
          FutureButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PhotoAddPage()),
                );
              },
              text: "Add Photo"),
          FutureButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PhotoListPage()),
                );
              },
              text: "List Photo"),
          FutureButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CallPage()),
                );
              },
              text: "Call Function"),
          FutureButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EventPage()),
                );
              },
              text: "Add Event"),
        ],
      ),
    );
  }
}
