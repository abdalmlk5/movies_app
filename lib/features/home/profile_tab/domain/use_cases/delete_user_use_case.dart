import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home/profile_tab/domain/repo/profile_repo.dart';

@injectable
class DeleteUserUseCase {
  final ProfileRepo repo;

  DeleteUserUseCase(this.repo);

  Future<void> call(String userID) async {
    await repo.deleteUser(userID);
  }
}
