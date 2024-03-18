import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/common_widget/image_placeholder.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/presentation/movie/screen/detail_movie_screen.dart';
import 'package:movie_app/presentation/movie/widget/movie_rating_widgets.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final EdgeInsetsGeometry? margin;

  ///This is for showing landscape or portrait movie item
  ///
  /// Default is portrait
  final Orientation orientation;

  const MovieTile({
    super.key,
    required this.movie,
    this.margin,
    this.orientation = Orientation.portrait,
  });

  @override
  Widget build(BuildContext context) {
    return switch (orientation) {
      Orientation.portrait => _Portrait(movie: movie),
      Orientation.landscape => _LandScape(
          movie: movie,
        )
    };
  }
}

class _Portrait extends StatelessWidget {
  final Movie movie;

  const _Portrait({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(DetailMovieScreen.routeName, extra: movie),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: CachedNetworkImage(
              imageUrl: movie.posterurl,
              fit: BoxFit.fitHeight,
              errorWidget: (context, error, stackTrace) =>
                  const ImagePlaceHolder(),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                movie.title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  movie.year,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.grey, fontWeight: FontWeight.w800),
                ),
                if (movie.imdbRating > 0) const Spacer(),
                if (movie.imdbRating > 0)
                  ImdbRatingWidget(
                      showLabel: false,
                      showStar: true,
                      rating: movie.imdbRating)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LandScape extends StatelessWidget {
  final Movie movie;

  const _LandScape({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(DetailMovieScreen.routeName, extra: movie);
      },
      child: Stack(children: [
        CachedNetworkImage(
          imageUrl: movie.posterurl,
          imageBuilder: (context, imageProvider) => Container(
            height: 250,
            decoration: ShapeDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: imageProvider,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                        color: AppColors.lightGrey, width: .5))),
            foregroundDecoration: ShapeDecoration(
                gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [.1, 1]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            alignment: Alignment.bottomCenter,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                AppStrings.textReleaseDate(movie.releaseDate),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const WidgetSpan(
                          child: Icon(
                            Icons.star_outlined,
                            color: AppColors.yellow,
                          ),
                          alignment: PlaceholderAlignment.middle),
                      TextSpan(text: ' ${movie.avgUsersRating}')
                    ]),
              )
            ],
          ),
        )
      ]),
    );
  }
}
