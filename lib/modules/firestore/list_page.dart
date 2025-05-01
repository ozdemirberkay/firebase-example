import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/modules/firestore/detail_page.dart';
import 'package:firebase_learning/modules/firestore/firestore_operations.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirestoreOperations.getIdeaList(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              return ListTile(
                title: Text(doc["idea"]),
                subtitle: Text(doc["email"]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          FirestoreOperations.updateIdea(
                              idea: doc["idea"] + " updated", docName: doc.id);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          FirestoreOperations.deleteIdea(docName: doc.id);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPage(id: doc.id)));
                },
              );
            },
          );
        }
      },
    ));
  }
}
