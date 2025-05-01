import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/shared/model/result_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageOperations {
  static const String storageCollection = "medias";

  static Future<ResultModel> addImage({required File file}) async {
    try {
      final storageRef = FirebaseStorage.instance.ref(storageCollection);

      var uuid = Uuid();
      String uniqueId = uuid.v4();
      final fileRef = storageRef.child(uniqueId);
      await fileRef.putFile(file);

      String downloadUrl = await fileRef.getDownloadURL();

      Map<String, dynamic> data = {
        "userUid": FirebaseAuth.instance.currentUser?.uid,
        "email": FirebaseAuth.instance.currentUser?.email,
        "url": downloadUrl,
        "created": Timestamp.now(),
      };

      await FirebaseFirestore.instance.collection(storageCollection).add(data);

      return ResultModel(status: true);
    } on FirebaseException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getPhotoList() {
    try {
      final collection =
          FirebaseFirestore.instance.collection(storageCollection).snapshots();

      return collection;
    } on FirebaseException catch (e) {
      return Stream.error(e.message ?? "error");
    } catch (e) {
      return Stream.error("Error");
    }
  }
}
