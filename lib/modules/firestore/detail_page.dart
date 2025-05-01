import 'package:firebase_learning/modules/firestore/firestore_operations.dart';
import 'package:firebase_learning/shared/model/result_model.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: FutureBuilder<ResultModel>(
        future: FirestoreOperations.getIdeaDetail(docName: widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.data?.message != null) {
            return Text(snapshot.data!.message!);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
