import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/repository/base/i_auth_repository.dart';
import 'package:movie_app/domain/model/app_user.dart';

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
  }

  void signOut() async {
    final signedOut = await repository.signOut();
    if (signedOut) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  void signInWithEmailPassword(
      {required String email, required String password}) async {
    final user = await repository.signInWithEmailPassword(email, password);
    if (user == null) {
      emit(state.copyWith(loading: false, status: AuthStatus.unauthenticated));
    } else {
      emit(state.copyWith(loading: false, status: AuthStatus.authenticated));
    }
  }
}
