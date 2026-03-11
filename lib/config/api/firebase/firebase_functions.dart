import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/config/base_response/base_response.dart';

class FirebaseFunctions {
  static Future<BaseResponse<UserCredential>> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SuccessBaseResponse<UserCredential>(data: credential);
    } on FirebaseAuthException catch (e) {
      String message = 'Authentication error';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return ErrorBaseResponse<UserCredential>(errorMessage: message);
    } catch (e) {
      return ErrorBaseResponse<UserCredential>(errorMessage: e.toString());
    }
  }

  static Future<BaseResponse<UserCredential>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SuccessBaseResponse<UserCredential>(data: credential);
    } on FirebaseAuthException catch (e) {
      String message = 'Wrong email or password';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      return ErrorBaseResponse<UserCredential>(errorMessage: message);
    } catch (e) {
      return ErrorBaseResponse<UserCredential>(errorMessage: e.toString());
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<BaseResponse<String>> resetPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return SuccessBaseResponse<String>(
          data: 'Password reset email sent successfully');
    } on FirebaseAuthException catch (e) {
      String message = 'Authentication error';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      }
      return ErrorBaseResponse<String>(errorMessage: message);
    } catch (e) {
      return ErrorBaseResponse<String>(errorMessage: e.toString());
    }
  }
}
