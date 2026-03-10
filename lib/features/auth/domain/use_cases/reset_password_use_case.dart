import 'package:injectable/injectable.dart';
import 'package:movies_app/features/auth/domain/repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  AuthRepo repo;

  ResetPasswordUseCase({required this.repo});

  call(String email) async {
    return await repo.resetPassword(email);
  }
}
