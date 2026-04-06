import 'package:injectable/injectable.dart';
import 'package:movies_app/core/models/app_user.dart';
import 'package:movies_app/features/home/profile_tab/domain/repo/profile_repo.dart';

@injectable
class UpdateProfileUseCase {
  final ProfileRepo repo;

  UpdateProfileUseCase(this.repo);

  Future<void> call(AppUser user) async {
    await repo.updateUser(user);
  }
}
