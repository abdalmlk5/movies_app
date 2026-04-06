import 'package:movies_app/core/models/app_user.dart';

abstract class ProfileRepo {
  Future<AppUser?> getCurrentUser();
  Future<void> updateUser(AppUser user);
  Future<void> logout();
  Future<void> deleteUser(String userID);
}
