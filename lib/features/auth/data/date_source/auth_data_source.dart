import 'package:movies_app/core/models/app_user.dart';
import '../../../../config/base_response/base_response.dart';

abstract class AuthDataSource {
  Future<BaseResponse<AppUser>> register(AppUser user);
  Future<BaseResponse<AppUser>> login(String email, String password);
  Future<BaseResponse<String>> resetPassword(String email);
}
