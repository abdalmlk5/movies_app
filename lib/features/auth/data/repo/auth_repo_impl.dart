import 'package:injectable/injectable.dart';
import 'package:movies_app/config/base_response/base_response.dart';
import 'package:movies_app/config/cache/cache_helper.dart';
import 'package:movies_app/core/models/app_user.dart';
import 'package:movies_app/features/auth/data/date_source/auth_data_source.dart';

import '../../domain/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource dataSource;

  AuthRepoImpl({required this.dataSource});

  @override
  Future<BaseResponse<AppUser>> login(AppUser user) async {
    BaseResponse<AppUser> response =
        await dataSource.login(user.email, user.password);
    switch (response) {
      case SuccessBaseResponse<AppUser>():
        //SAVE UID IN CACHE
        CacheHelper.saveData(key: "uId", value: response.data.userID);
        CacheHelper.saveJson(key: "currentUser", value: response.data.toJson());
        return SuccessBaseResponse<AppUser>(data: response.data);
      case ErrorBaseResponse<AppUser>():
        return ErrorBaseResponse<AppUser>(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<AppUser>> register(AppUser user) async {
    BaseResponse<AppUser> response = await dataSource.register(user);
    switch (response) {
      case SuccessBaseResponse<AppUser>():
        CacheHelper.saveData(key: "uId", value: response.data.userID);
        await CacheHelper.saveJson(
            key: "currentUser", value: response.data.toJson());
        return SuccessBaseResponse<AppUser>(data: response.data);
      case ErrorBaseResponse<AppUser>():
        return ErrorBaseResponse<AppUser>(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<String>> resetPassword(String email) async {
    return await dataSource.resetPassword(email);
  }
}
