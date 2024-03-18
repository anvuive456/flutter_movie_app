import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/common_widget/app_button.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:movie_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:movie_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:movie_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:movie_app/presentation/profile/screen/profile_screen.dart';
import 'package:movie_app/presentation/profile/widget/profile_avatar.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (_, state) {
        final child = switch (state.status) {
          AuthStatus.unauthenticated => AppButton(
              label: AppStrings.labelSignIn,
              enabled: true,
              onTap: () {
                context.pushNamed(SignInScreen.routeName);
              },
              buttonColor: AppColors.white,
              filled: false,
              margin: const EdgeInsets.only(right: 10),
            ),
          AuthStatus.authenticated => BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return ProfileAvatar(
                    onTap: () {
                      context.pushNamed(ProfileScreen.routeName);
                    },
                    url: state.user.avatarUrl,
                    name: state.user.fullName);
              },
            )
        };

        return Container(
          width: 100,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: child,
          ),
        );
      },
    );
  }
}
