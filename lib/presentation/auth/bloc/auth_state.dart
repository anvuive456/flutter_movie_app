part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final bool loading;
  final AuthStatus status;
  final String? message;
  const AuthState({
    this.loading = true,
    this.message,
    this.status = AuthStatus.unauthenticated,
  });

  @override
  List<Object?> get props => [loading, status,message];

  AuthState copyWith({
    bool? loading,
    AuthStatus? status,
    String? message,
  }) {
    return AuthState(
      message: message,
      loading: loading ?? this.loading,
      status: status ?? this.status,
    );
  }
}
