import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/shared/model/result_model.dart';

class FirestoreOperations {
  static const String ideaCollection = "ideas";

  static Future<ResultModel> addIdea({required String idea}) async {
    try {
      Map<String, dynamic> data = {
        "idea": idea,
        "userUid": FirebaseAuth.instance.currentUser?.uid,
        "email": FirebaseAuth.instance.currentUser?.email,
        "created": Timestamp.now(),
        "last_update": FieldValue.serverTimestamp(),
        "idea_list": [idea],
      };

      await FirebaseFirestore.instance.collection(ideaCollection).add(data);

      return ResultModel(status: true);
    } on FirebaseException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Future<ResultModel> updateIdea(
      {required String idea, required String docName}) async {
    try {
      Map<String, dynamic> data = {
        "idea": idea,
        "idea_list": FieldValue.arrayUnion(["idea"]),
      };
      await FirebaseFirestore.instance
          .collection(ideaCollection)
          .doc(docName)
          .update(data);

      return ResultModel(status: true);
    } on FirebaseException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Future<ResultModel> deleteIdea({required String docName}) async {
    try {
      await FirebaseFirestore.instance
          .collection(ideaCollection)
          .doc(docName)
          .delete();

      return ResultModel(status: true);
    } on FirebaseException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Future<ResultModel> getIdeaDetail({required String docName}) async {
    try {
      final collection = await FirebaseFirestore.instance
          .collection(ideaCollection)
          .doc(docName)
          .get();

      String data = collection.data().toString();

      return ResultModel(status: true, message: data);
    } on FirebaseException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getIdeaList() {
    try {
      final collection =
          FirebaseFirestore.instance.collection(ideaCollection).snapshots();

      return collection;
    } on FirebaseException catch (e) {
      return Stream.error(e.message ?? "error");
    } catch (e) {
      return Stream.error("Error");
    }
  }
}
