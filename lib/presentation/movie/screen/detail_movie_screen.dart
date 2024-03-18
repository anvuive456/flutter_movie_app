import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/common_widget/blur_background_widget.dart';
import 'package:movie_app/core/toast_service.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:movie_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:movie_app/presentation/movie/widget/detail_movie_information_widget.dart';
import 'package:movie_app/presentation/movie/widget/movie_genre_widget.dart';
import 'package:movie_app/presentation/movie/widget/movie_rating_widgets.dart';
import 'package:movie_app/presentation/movie/widget/section_label.dart';
import 'package:movie_app/presentation/wishlist/bloc/check_wishlist_cubit.dart';

import '../../../domain/model/movie.dart';
import 'package:expandable_text/expandable_text.dart';

class DetailMovieScreen extends StatefulWidget {
  static const String routeName = 'detail_movie';
  final Movie movie;

  const DetailMovieScreen({super.key, required this.movie});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  Movie get _movie => widget.movie;

  //this notifier is for showing title on app bar when app bar is collapsed
  final _showAppBarTitleNotifier = ValueNotifier(false);

  ///the scroll controller for main scroll view
  final ScrollController _scroller = ScrollController();

  ///Listen to scroller and show title when appbar collapsed
  void _showTitleAppBarOnListen() {
    _showAppBarTitleNotifier.value = _isSliverAppBarCollapsed;
  }

  ///appbar is collapsed when the offset is above 400 from tool bar height
  bool get _isSliverAppBarCollapsed {
    return _scroller.hasClients && _scroller.offset > (350 - kToolbarHeight);
  }

  late WishlistCubit _wishlistCubit;

  @override
  void initState() {
    _wishlistCubit = context.read<WishlistCubit>();
    _scroller.addListener(_showTitleAppBarOnListen);
    super.initState();
  }

  @override
  void dispose() {
    _scroller.removeListener(_showTitleAppBarOnListen);
    _scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scroller,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.black,
            expandedHeight: 400,
            stretch: true,
            pinned: true,
            titleSpacing: 0,
            actions: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  ///Not allow users to save movie to wish list when they haven't logged in
                  if(state.status == AuthStatus.unauthenticated) return const SizedBox.shrink();

                  return BlocConsumer<WishlistCubit, WishlistState>(
                    listener: (context, state) {
                      switch (state.isSaved) {
                        case true:
                          ToastService.showSuccess(
                              AppStrings.messageSavedToWishlist);
                          break;
                        case false:
                          ToastService.showSuccess(
                              AppStrings.messageRemovedToWishlist);
                          break;
                      }
                    },
                    listenWhen: (previous, current) => !current.init,
                    builder: (ctx, state) {
                      return IconButton(
                          onPressed: () => _handleSaveMovie(state),
                          icon: Icon(
                            state.isSaved
                                ? Icons.bookmark_added
                                : Icons.bookmark_add_outlined,
                            color: AppColors.white,
                          ));
                    },
                  );
                },
              )
            ],
            title: ValueListenableBuilder<bool>(
              valueListenable: _showAppBarTitleNotifier,
              builder: (context, showed, child) {
                return AnimatedOpacity(
                  opacity: showed ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: AnimatedSlide(
                      offset: Offset(0, showed ? 0 : 1),
                      duration: const Duration(milliseconds: 200),
                      child: child!),
                );
              },
              child: Text(
                _movie.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              collapseMode: CollapseMode.parallax,
              stretchModes: const [
                StretchMode.fadeTitle,
                StretchMode.zoomBackground
              ],
              background: BlurBackgroundWidget(imageUrl: _movie.posterurl),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.list(children: [
              DetailMovieInformationWidget(
                movie: _movie,
                showAppBarTitleNotifier: _showAppBarTitleNotifier,
              ),
              const SectionLabel(AppStrings.labelMovieGenre),
              MovieGenreWidget(genres: _movie.genres),
              const SectionLabel(AppStrings.labelMovieActors),
              MovieGenreWidget(genres: _movie.actors),
              const SectionLabel(AppStrings.labelMovieDescription),
              ExpandableText(
                _movie.storyline,
                expandText: AppStrings.labelExpandText,
                collapseOnTextTap: true,
                maxLines: 3,
                animation: true,
                expandOnTextTap: true,
                animationDuration: const Duration(milliseconds: 300),
                animationCurve: Curves.decelerate,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SectionLabel(AppStrings.labelMovieRatings),
              MovieRatingChartWidget(ratings: _movie.ratings),
            ]),
          ),
          const SliverPadding(padding: EdgeInsets.symmetric(vertical: 80))
        ],
      ),
    );
  }

  void _handleSaveMovie(WishlistState state) {
    if (state.isSaved) {
      _wishlistCubit.removeFromWishList();
    } else {
      _wishlistCubit.saveToWishList(_movie);
    }
  }
}
