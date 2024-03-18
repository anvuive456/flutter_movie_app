import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/common_widget/app_button.dart';
import 'package:movie_app/core/common_widget/blur_background_widget.dart';
import 'package:movie_app/core/common_widget/image_placeholder.dart';
import 'package:movie_app/core/toast_service.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:movie_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:movie_app/presentation/movie/screen/all_movies_screen.dart';
import 'package:movie_app/presentation/movie/widget/movie_tile.dart';
import 'package:movie_app/presentation/movie/widget/section_label.dart';
import 'package:movie_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:movie_app/presentation/profile/widget/profile_avatar.dart';
import 'package:movie_app/presentation/wishlist/bloc/all_wishlist_cubit.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit _cubit;
  late AuthCubit _authCubit;

  @override
  void initState() {
    _cubit = context.read<ProfileCubit>();
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (_, state) {
       if(state.status == AuthStatus.unauthenticated) {
         context.goNamed(AllMoviesScreen.routeName);
       }
      },
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.updated == true) {
            ToastService.showSuccess('Your information is updated');
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(floating: true),
              SliverToBoxAdapter(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (BuildContext context, ProfileState state) {
                    return ProfileAvatar(
                      size: 80,
                      url: state.user.avatarUrl,
                      name: state.user.email,
                      onTap: () {
                        _cubit.updateRandomAvatar();
                      },
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SectionLabel(
                  AppStrings.labelMyInformation,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) => SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  sliver: SliverList.list(children: [
                    Text(
                      'Email: ${state.user.email}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Name: ${state.user.fullName}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    AppButton(
                      label: AppStrings.labelSignOut,
                      buttonColor: AppColors.red,
                      filled: false,
                      onTap: () {
                        _authCubit.signOut();
                      },
                    )
                  ]),
                ),
              ),
              SliverToBoxAdapter(
                  child: BlocBuilder<AllWishlistCubit, AllWishlistState>(
                builder: (context, state) {
                  return SectionLabel(
                    AppStrings.labelMyWishlistWithCount(state.wishlist.length),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  );
                },
              )),
              BlocBuilder<AllWishlistCubit, AllWishlistState>(
                builder: (context, state) => SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  sliver: SliverList.separated(
                    itemCount: state.wishlist.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return MovieTile(
                        movie: state.wishlist[index],
                        orientation: Orientation.landscape,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
