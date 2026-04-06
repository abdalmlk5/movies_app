import 'package:injectable/injectable.dart';
import 'package:movies_app/config/api/firebase/firebase_functions.dart';
import 'package:movies_app/config/base_response/base_response.dart';
import 'package:movies_app/core/models/app_user.dart';

import 'auth_data_source.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<BaseResponse<AppUser>> login(String email, String password) async {
    return FirebaseFunctions.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<BaseResponse<AppUser>> register(AppUser user) {
    return FirebaseFunctions.createUserWithEmailAndPassword(user: user);
  }

  @override
  Future<BaseResponse<String>> resetPassword(String email) {
    return FirebaseFunctions.resetPassword(
      email: email,
    );
  }
}
