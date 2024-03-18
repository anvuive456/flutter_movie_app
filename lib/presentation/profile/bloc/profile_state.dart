part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final bool loading;
  final AppUser user;
  final Object? error;
  final bool? updated;

  @override
  List<Object?> get props => [loading, user, error, updated];

  const ProfileState({
    this.loading = true,
    this.user = const AppUser.empty(),
    this.error,
    this.updated,
  });

  ProfileState copyWith({
    bool? loading,
    AppUser? user,
    Object? error,
    bool? updated,
  }) {
    return ProfileState(
        loading: loading ?? this.loading,
        user: user ?? this.user,
        error: error,
        updated: updated);
  }
}
