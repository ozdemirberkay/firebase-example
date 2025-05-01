import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/modules/storage/storage_operations.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key});

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: StreamBuilder<QuerySnapshot>(
        stream: StorageOperations.getPhotoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No Photo'));
          }

          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: snapshot.data!.docs.map((doc) {
              String imageUrl = doc['url'];
              return Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                        child: Icon(Icons.error, size: 50, color: Colors.red));
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
