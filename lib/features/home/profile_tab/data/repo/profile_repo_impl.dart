import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/config/api/firebase/firebase_functions.dart';
import 'package:movies_app/config/cache/cache_helper.dart';
import 'package:movies_app/core/models/app_user.dart';
import 'package:movies_app/features/home/profile_tab/data/datasource/profile_local_data_source.dart';
import 'package:movies_app/features/home/profile_tab/domain/repo/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileLocalDataSource localDataSource;

  ProfileRepoImpl(this.localDataSource);

  @override
  Future<AppUser?> getCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        final userSnapshot = await FirebaseFunctions.getUsersCollection()
            .doc(currentUser.uid)
            .get();
        if (userSnapshot.exists) {
          final user = userSnapshot.data();
          if (user != null) {
            await localDataSource.saveUser(user);
            return user;
          }
        }
      } catch (_) {
        // Ignore remote failure and fallback to local data.
      }
    }

    return await localDataSource.getUser();
  }

  @override
  Future<void> updateUser(AppUser user) async {
    final authUser = FirebaseAuth.instance.currentUser;
    if ((user.userID).isEmpty && authUser != null) {
      user.userID = authUser.uid;
    }

    await localDataSource.saveUser(user);
    if (user.userID.isNotEmpty) {
      await FirebaseFunctions.getUsersCollection().doc(user.userID).set(user);
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseFunctions.logout();
    await localDataSource.deleteUser();
    await CacheHelper.deleteData(key: 'uId');
  }

  @override
  Future<void> deleteUser(String userID) async {
    await FirebaseFunctions.deleteUser(userID);
    await localDataSource.deleteUser();
    await CacheHelper.deleteData(key: 'uId');
  }
}
