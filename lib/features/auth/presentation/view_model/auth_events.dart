import 'package:movies_app/features/auth/domain/models/app_user.dart';

abstract class AuthEvents {}

class LoginEvent extends AuthEvents {
  final AppUser user;

  LoginEvent(this.user);
}

class RegisterEvent extends AuthEvents {
  final AppUser user;
  RegisterEvent(this.user);
}

class ResetPasswordEvent extends AuthEvents {
  final String email;
  ResetPasswordEvent(this.email);
}
