import 'package:movies_app/config/base_response/base_response.dart';

import '../../../../core/models/app_user.dart';

abstract class AuthRepo {
  Future<BaseResponse<AppUser>> register(AppUser user);
  Future<BaseResponse<AppUser>> login(AppUser user);
  Future<BaseResponse<String>> resetPassword(String email);
}
