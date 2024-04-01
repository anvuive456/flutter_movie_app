import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/data/repository/base/i_auth_repository.dart';

part 'auth_state.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repository) : super(const AuthState());
  final IAuthRepository repository;

  @PostConstruct()
  void init() async {
    final user = await repository.getUser();
    if (user != null) {
      emit(state.copyWith(
        loading: false,
        status: AuthStatus.authenticated,
      ));
    } else {
      emit(state.copyWith(loading: false));
    }
  }

  void signUpWithEmailPassword(
      {required String email, required String password}) async {
    emit(state.copyWith(loading: true));
    try {
      final appUser = await repository.signUpWithEmailPassword(
          email: email, password: password);
      if (appUser != null) {
        emit(state.copyWith(
          loading: false,
          status: AuthStatus.authenticated,
        ));
      } else {
        emit(state.copyWith(
          loading: false,
          status: AuthStatus.unauthenticated,
        ));
      }
    } catch (e) {
      emit(state.copyWith(message: e.toString(), loading: false));
    }
  }

  void signOut() async {
    final signedOut = await repository.signOut();
    if (signedOut) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  void signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await repository.signInWithEmailPassword(email, password);
      if (user == null) {
        emit(state.copyWith(
            loading: false,
            status: AuthStatus.unauthenticated,
            message: AppStrings.errUserNotFoundOrHaveNotSignedUp));
      } else {
        emit(state.copyWith(loading: false, status: AuthStatus.authenticated));
      }
    } catch (e) {
      emit(state.copyWith(message: e.toString(), loading: false));

    }

  }
}
