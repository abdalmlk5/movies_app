import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/config/api/firebase/firebase_functions.dart';
import 'package:movies_app/config/base_response/base_response.dart';

import 'auth_data_source.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<BaseResponse<UserCredential>> login(
      String email, String password) async {
    return FirebaseFunctions.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<BaseResponse<UserCredential>> register(String email, String password) {
    return FirebaseFunctions.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<BaseResponse<String>> resetPassword(String email) {
    return FirebaseFunctions.resetPassword(
      email: email,
    );
  }
}
