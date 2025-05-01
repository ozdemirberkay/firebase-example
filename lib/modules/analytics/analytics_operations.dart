import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/shared/model/result_model.dart';

class AnalyticsOperations {
  static const String eventName = "event";

  static Future<ResultModel> addEvent() async {
    try {
      FirebaseAnalytics analytics = FirebaseAnalytics.instance;

      await analytics.logEvent(
          name: eventName,
          parameters: {"user": FirebaseAuth.instance.currentUser?.email ?? ""});

      return ResultModel(status: true);
    } on FirebaseException catch (e) {
      return ResultModel(status: false, message: e.message);
    } catch (e) {
      return ResultModel(status: false);
    }
  }
}
