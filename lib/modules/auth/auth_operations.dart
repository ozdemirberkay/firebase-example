import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/shared/model/result_model.dart';

class AuthOperations {
  static Future<ResultModel> createUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return ResultModel(status: true);
    } on FirebaseAuthException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Future<ResultModel> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ResultModel(status: true);
    } on FirebaseAuthException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Future<ResultModel> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return ResultModel(status: true);
    } on FirebaseAuthException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Future<User?> getReloadedUser() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      return null;
    }
  }

  static Future<ResultModel> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return ResultModel(status: false);
      }
      await user.delete();
      return ResultModel(status: true);
    } on FirebaseAuthException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }

  static Future<ResultModel> sendEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return ResultModel(status: false);
      }
      await user.sendEmailVerification();
      return ResultModel(status: true);
    } on FirebaseAuthException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }
}
