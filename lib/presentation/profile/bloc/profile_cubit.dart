import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/repository/base/i_profile_repository.dart';
import 'package:movie_app/domain/model/app_user.dart';

part 'profile_state.dart';

@singleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(ProfileState());

  final IProfileRepository repository;

  @PostConstruct()
  void init() async {
    final user = await repository.getProfile();
    emit(state.copyWith(user: user, loading: false));
  }

  void updateUser(Map<String, dynamic> json) async {
    emit(state.copyWith(loading: true));
    final user = await repository.updateProfile(state.user.copyWith(
      fullName: json['fullName'],
      email: json['email'],
    ));

    emit(state.copyWith(user: user, loading: false,updated: true));
  }

  void updateRandomAvatar() async {
    emit(state.copyWith(loading: true));
    final user = await repository.updateProfile(
      state.user.copyWith(avatarUrl: 'https://picsum.photos/200'),
    );

    emit(state.copyWith(user: user, loading: false,updated: true));
  }
}
