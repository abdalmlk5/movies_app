import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home/profile_tab/domain/use_cases/delete_user_use_case.dart';
import 'package:movies_app/features/home/profile_tab/domain/use_cases/get_profile_use_case.dart';
import 'package:movies_app/features/home/profile_tab/domain/use_cases/logout_use_case.dart';
import 'package:movies_app/features/home/profile_tab/domain/use_cases/update_profile_use_case.dart';
import 'package:movies_app/features/home/profile_tab/presentation/view_model/profile_event.dart';
import 'package:movies_app/features/home/profile_tab/presentation/view_model/profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  ProfileBloc(
    this.getProfileUseCase,
    this.updateProfileUseCase,
    this.logoutUseCase,
    this.deleteUserUseCase,
  ) : super(ProfileState.initial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<ChangeProfileSectionEvent>(_onChangeSection);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<LogoutProfileEvent>(_onLogoutProfile);
    on<DeleteProfileEvent>(_onDeleteProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      updateSuccess: false,
      logoutSuccess: false,
    ));

    try {
      final user = await getProfileUseCase();

      if (user == null) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to load profile data.',
        ));
        return;
      }

      emit(state.copyWith(
        isLoading: false,
        user: user,
        errorMessage: null,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }

  void _onChangeSection(
    ChangeProfileSectionEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(
      selectedSectionIndex: event.sectionIndex,
      errorMessage: null,
    ));
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      isUpdating: true,
      errorMessage: null,
      updateSuccess: false,
    ));

    try {
      await updateProfileUseCase(event.user);
      emit(state.copyWith(
        isUpdating: false,
        user: event.user,
        updateSuccess: true,
        errorMessage: null,
      ));
    } catch (error) {
      emit(state.copyWith(
        isUpdating: false,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onLogoutProfile(
    LogoutProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      isLoggingOut: true,
      errorMessage: null,
      logoutSuccess: false,
    ));

    try {
      await logoutUseCase();
      emit(state.copyWith(
        isLoggingOut: false,
        logoutSuccess: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoggingOut: false,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onDeleteProfile(
    DeleteProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      isUpdating: true,
      errorMessage: null,
    ));

    try {
      await deleteUserUseCase(event.userID);
      emit(state.copyWith(
        isUpdating: false,
        logoutSuccess: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        isUpdating: false,
        errorMessage: error.toString(),
      ));
    }
  }
}
