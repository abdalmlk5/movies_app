import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/config/base_response/base_response.dart';
import 'package:movies_app/core/models/app_user.dart';

class FirebaseFunctions {
  static CollectionReference<AppUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<AppUser>(
      fromFirestore: (snapshot, _) {
        return AppUser.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static Future<BaseResponse<AppUser>> createUserWithEmailAndPassword({
    required AppUser user,
  }) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      user.userID = credential.user!.uid;
      await getUsersCollection().doc(user.userID).set(user);
      return SuccessBaseResponse<AppUser>(data: user);
    } on FirebaseAuthException catch (e) {
      String message = 'Authentication error';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return ErrorBaseResponse<AppUser>(errorMessage: message);
    } catch (e) {
      return ErrorBaseResponse<AppUser>(errorMessage: e.toString());
    }
  }

  static Future<BaseResponse<AppUser>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userSnapshot =
          await getUsersCollection().doc(credential.user!.uid).get();
      if (userSnapshot.exists) {
        return SuccessBaseResponse<AppUser>(data: userSnapshot.data()!);
      } else {
        return ErrorBaseResponse<AppUser>(errorMessage: "User data not found");
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Wrong email or password';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      return ErrorBaseResponse<AppUser>(errorMessage: message);
    } catch (e) {
      return ErrorBaseResponse<AppUser>(errorMessage: e.toString());
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

  static Future<void> deleteUser(String userID) async {
    await getUsersCollection().doc(userID).delete();
    await FirebaseAuth.instance.currentUser?.delete();
  }
}
