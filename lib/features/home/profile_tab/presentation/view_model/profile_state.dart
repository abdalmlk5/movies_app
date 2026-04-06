import 'package:movies_app/core/models/app_user.dart';

class ProfileState {
  final bool isLoading;
  final bool isUpdating;
  final bool isLoggingOut;
  final AppUser? user;
  final int selectedSectionIndex;
  final String? errorMessage;
  final bool updateSuccess;
  final bool logoutSuccess;

  ProfileState({
    this.isLoading = false,
    this.isUpdating = false,
    this.isLoggingOut = false,
    this.user,
    this.selectedSectionIndex = 0,
    this.errorMessage,
    this.updateSuccess = false,
    this.logoutSuccess = false,
  });

  factory ProfileState.initial() => ProfileState();

  ProfileState copyWith({
    bool? isLoading,
    bool? isUpdating,
    bool? isLoggingOut,
    AppUser? user,
    int? selectedSectionIndex,
    String? errorMessage,
    bool? updateSuccess,
    bool? logoutSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      user: user ?? this.user,
      selectedSectionIndex: selectedSectionIndex ?? this.selectedSectionIndex,
      errorMessage: errorMessage,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
    );
  }
}
