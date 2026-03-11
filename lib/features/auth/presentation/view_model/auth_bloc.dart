import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/config/base_response/base_response.dart';
import 'package:movies_app/config/base_state/base_state.dart';
import 'package:movies_app/features/auth/domain/models/app_user.dart';
import 'package:movies_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:movies_app/features/auth/presentation/view_model/auth_state.dart';

import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import 'auth_events.dart';

@injectable
class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthBloc(this.loginUseCase, this.registerUseCase, this.resetPasswordUseCase)
      : super(AuthState.initial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      loginState: state.loginState.copyWith(isLoadingParam: true),
    ));

    BaseResponse<AppUser> result = await loginUseCase(
      event.user,
    );

    switch (result) {
      case SuccessBaseResponse<AppUser>():
        emit(state.copyWith(
          loginState: BaseState(data: result.data as dynamic, isLoading: false),
        ));
      case ErrorBaseResponse<AppUser>():
        emit(state.copyWith(
          loginState: BaseState(
            errorMessage: result.errorMessage,
            isLoading: false,
          ),
        ));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    print("event.user.email: ${event.user.email}");
    emit(state.copyWith(
      registerState: state.registerState.copyWith(isLoadingParam: true),
    ));

    BaseResponse<AppUser> result = await registerUseCase(event.user);

    switch (result) {
      case SuccessBaseResponse<AppUser>():
        emit(state.copyWith(
          registerState:
              BaseState(data: result.data as dynamic, isLoading: false),
        ));
      case ErrorBaseResponse<AppUser>():
        emit(state.copyWith(
          registerState: BaseState(
            errorMessage: result.errorMessage,
            isLoading: false,
          ),
        ));
    }
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      resetPasswordState:
          state.resetPasswordState.copyWith(isLoadingParam: true),
    ));
    BaseResponse<String> result = await resetPasswordUseCase(event.email);

    switch (result) {
      case SuccessBaseResponse<String>():
        emit(state.copyWith(
          resetPasswordState: BaseState(data: result.data, isLoading: false),
        ));
      case ErrorBaseResponse<String>():
        emit(state.copyWith(
          resetPasswordState: BaseState(
            errorMessage: result.errorMessage,
            isLoading: false,
          ),
        ));
    }
  }
}
