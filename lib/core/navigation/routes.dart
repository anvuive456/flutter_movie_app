import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/dependency_injection/dependency_injection.dart';
import 'package:movie_app/core/navigation/fade_up_transition_page.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:movie_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:movie_app/presentation/auth/screen/sign_up_screen.dart';
import 'package:movie_app/presentation/movie/bloc/all_movies_cubit.dart';
import 'package:movie_app/presentation/movie/screen/all_movies_screen.dart';
import 'package:movie_app/presentation/movie/screen/detail_movie_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:movie_app/presentation/profile/screen/profile_screen.dart';
import 'package:movie_app/presentation/wishlist/bloc/all_wishlist_cubit.dart';
import 'package:movie_app/presentation/wishlist/bloc/check_wishlist_cubit.dart';

final router = GoRouter(
  initialLocation: '/movies',
  routes: [
    GoRoute(
        path: '/movies',
        name: AllMoviesScreen.routeName,
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: getIt.get<AllMoviesCubit>(),
                ),
                BlocProvider.value(
                  value: getIt.get<AuthCubit>(),
                ),
                BlocProvider.value(
                  value: getIt.get<ProfileCubit>(),
                )
              ],
              child: const AllMoviesScreen(),
            ),
        routes: [
          GoRoute(
            path: 'detail',
            name: DetailMovieScreen.routeName,
            pageBuilder: (context, state) {
              final movie = state.extra as Movie;
              return fadeUpTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<WishlistCubit>.value(
                        value: getIt<WishlistCubit>(param1: movie.id)),
                    BlocProvider<AuthCubit>.value(
                        value: getIt<AuthCubit>()),
                  ],
                  child: DetailMovieScreen(
                    movie: movie,
                  ),
                ),
              );
            },
          ),
        ]),
    GoRoute(
        path: '/signup',
        name: SignUpScreen.routeName,
        pageBuilder: (context, state) => fadeUpTransitionPage(
                child: BlocProvider<AuthCubit>.value(
              value: getIt<AuthCubit>(),
              child: const SignUpScreen(),
            ))),
    GoRoute(
        path: '/signin',
        name: SignInScreen.routeName,
        pageBuilder: (context, state) => fadeUpTransitionPage(
                child: BlocProvider<AuthCubit>.value(
              value: getIt<AuthCubit>(),
              child: SignInScreen(),
            ))),
    GoRoute(
      path: '/profile',
      name: ProfileScreen.routeName,
      pageBuilder: (context, state) => fadeUpTransitionPage(
          child: MultiBlocProvider(providers: [
        BlocProvider<AuthCubit>.value(value: getIt<AuthCubit>()),
        BlocProvider<AllWishlistCubit>.value(value: getIt<AllWishlistCubit>()),
        BlocProvider<ProfileCubit>.value(value: getIt<ProfileCubit>())
      ], child: const ProfileScreen())),
    )
  ],
);
