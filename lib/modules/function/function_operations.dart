import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/shared/model/result_model.dart';

class FunctionOperations {
  static Future<ResultModel> sendCallMessage() async {
    try {
      final result =
          await FirebaseFunctions.instance.httpsCallable('echoMessage').call({
        'message': FirebaseAuth.instance.currentUser?.email,
      });

      return ResultModel(status: true, message: result.data['received']);
    } on FirebaseException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }
}
