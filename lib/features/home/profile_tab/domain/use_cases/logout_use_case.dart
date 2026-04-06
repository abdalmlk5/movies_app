import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home/profile_tab/domain/repo/profile_repo.dart';

@injectable
class LogoutUseCase {
  final ProfileRepo repo;

  LogoutUseCase(this.repo);

  Future<void> call() async {
    await repo.logout();
  }
}
