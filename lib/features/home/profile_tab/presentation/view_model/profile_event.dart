import 'package:movies_app/core/models/app_user.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class ChangeProfileSectionEvent extends ProfileEvent {
  final int sectionIndex;
  ChangeProfileSectionEvent(this.sectionIndex);
}

class UpdateProfileEvent extends ProfileEvent {
  final AppUser user;
  UpdateProfileEvent(this.user);
}

class LogoutProfileEvent extends ProfileEvent {}

class DeleteProfileEvent extends ProfileEvent {
  final String userID;
  DeleteProfileEvent(this.userID);
}
