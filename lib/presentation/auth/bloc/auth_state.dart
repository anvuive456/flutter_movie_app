part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final bool loading;
  final AuthStatus status;
  const AuthState({
    this.loading = true,
    this.status = AuthStatus.unauthenticated,
  });

  @override
  List<Object?> get props => [loading, status];

  AuthState copyWith({
    bool? loading,
    AuthStatus? status,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      status: status ?? this.status,
    );
  }
}
