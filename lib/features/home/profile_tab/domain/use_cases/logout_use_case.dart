import 'package:injectable/injectable.dart';

import '../repo/profile_repo.dart';

@injectable
class LogoutUseCase {
  ProfileRepo repo;

  LogoutUseCase(this.repo);

  Future<void> call() async {
    repo.logout();
  }
}
