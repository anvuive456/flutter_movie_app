import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:movie_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:movie_app/presentation/movie/bloc/all_movies_cubit.dart';
import 'package:movie_app/presentation/movie/widget/home_menu.dart';
import 'package:movie_app/presentation/movie/widget/movie_tile.dart';

class AllMoviesScreen extends StatefulWidget {
  static const String routeName = 'home';

  const AllMoviesScreen({super.key});

  @override
  State createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  @override
  void initState() {
    context.read<AllMoviesCubit>().fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AllMoviesCubit>().state;

    return RefreshIndicator.adaptive(
      color: AppColors.burgundy,
      onRefresh: () => context.read<AllMoviesCubit>().fetchMovies(),
      child: CustomScrollView(
        primary: true,
        slivers: [
          const SliverAppBar(
            centerTitle: false,
            pinned: true,
            actions: [HomeMenu()],
            titleTextStyle:
                TextStyle(color: AppColors.white, fontSize: 20),
            title: Text(AppStrings.labelMovies),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) =>
                  MovieTile(movie: state.movies[index]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1 / 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
