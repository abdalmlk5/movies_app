import 'package:firebase_auth/firebase_auth.dart';

import '../../../../config/base_response/base_response.dart';

abstract class AuthDataSource {
  Future<BaseResponse<UserCredential>> register(String email, String password);
  Future<BaseResponse<UserCredential>> login(String email, String password);
  Future<BaseResponse<String>> resetPassword(String email);
}
