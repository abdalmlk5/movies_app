import 'package:injectable/injectable.dart';
import 'package:movies_app/config/cache/cache_helper.dart';
import 'package:movies_app/core/models/app_user.dart';

abstract class ProfileLocalDataSource {
  Future<void> saveUser(AppUser user);
  Future<AppUser?> getUser();
  Future<void> deleteUser();
}

@Injectable(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _userKey = 'currentUser';

  @override
  Future<void> saveUser(AppUser user) async {
    await CacheHelper.saveJson(key: _userKey, value: user.toJson());
  }

  @override
  Future<AppUser?> getUser() async {
    final json = await CacheHelper.getJson(key: _userKey);
    if (json != null) {
      return AppUser.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> deleteUser() async {
    await CacheHelper.deleteData(key: _userKey);
  }
}
