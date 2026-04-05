import 'package:injectable/injectable.dart';
import 'package:movies_app/core/models/app_user.dart';
import 'package:movies_app/features/auth/domain/repo/auth_repo.dart';

@injectable
class LoginUseCase {
  AuthRepo repo;

  LoginUseCase({required this.repo});

  call(AppUser user) async {
    return await repo.login(user);
  }
}
