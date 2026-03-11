// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/date_source/auth_data_source.dart' as _i976;
import '../../features/auth/data/date_source/auth_data_source_impl.dart'
    as _i550;
import '../../features/auth/data/date_source/auth_local_data_source.dart'
    as _i998;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i984;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/domain/use_cases/reset_password_use_case.dart'
    as _i169;
import '../../features/auth/presentation/view_model/auth_bloc.dart' as _i30;
import '../api/api_manager.dart' as _i1047;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i976.AuthDataSource>(() => _i550.AuthDataSourceImpl());
    gh.factory<_i998.AuthLocalDataSource>(
        () => _i998.AuthLocalDataSourceImpl());
    gh.factory<_i170.AuthRepo>(
        () => _i984.AuthRepoImpl(dataSource: gh<_i976.AuthDataSource>()));
    gh.factory<_i1038.LoginUseCase>(
        () => _i1038.LoginUseCase(repo: gh<_i170.AuthRepo>()));
    gh.factory<_i169.ResetPasswordUseCase>(
        () => _i169.ResetPasswordUseCase(repo: gh<_i170.AuthRepo>()));
    gh.factory<_i1010.RegisterUseCase>(
        () => _i1010.RegisterUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i30.AuthBloc>(() => _i30.AuthBloc(
          gh<_i1038.LoginUseCase>(),
          gh<_i1010.RegisterUseCase>(),
          gh<_i169.ResetPasswordUseCase>(),
        ));
    return this;
  }
}
