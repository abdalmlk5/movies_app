import 'package:movies_app/config/base_state/base_state.dart';
import 'package:movies_app/core/models/app_user.dart';

class AuthState {
  final BaseState<AppUser> loginState;
  final BaseState<AppUser> registerState;
  final BaseState<String> resetPasswordState;

  AuthState({
    required this.loginState,
    required this.registerState,
    required this.resetPasswordState,
  });

  // الحالة الابتدائية
  factory AuthState.initial() => AuthState(
        loginState: BaseState(),
        registerState: BaseState(),
        resetPasswordState: BaseState(),
      );

  AuthState copyWith({
    BaseState<AppUser>? loginState,
    BaseState<AppUser>? registerState,
    BaseState<String>? resetPasswordState,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }
}
