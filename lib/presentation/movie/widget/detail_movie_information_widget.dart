import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:movie_app/domain/model/movie.dart';

import 'movie_rating_widgets.dart';

class DetailMovieInformationWidget extends StatelessWidget {
  final Movie movie;

  const DetailMovieInformationWidget({
    super.key,
    required this.movie,
    required this.showAppBarTitleNotifier,
  });

  final ValueNotifier<bool> showAppBarTitleNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 100,
          height: 150,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(top: 10),
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: AppColors.grey)),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(movie.posterurl))),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: showAppBarTitleNotifier,
                  builder: (context, showed, child) {
                    return AnimatedOpacity(
                      opacity: showed ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: AnimatedSlide(
                          offset: Offset(0, showed ? -1 : 0),
                          duration: const Duration(milliseconds: 200),
                          child: child!),
                    );
                  },
                  child: Text(
                    movie.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                if (movie.imdbRating > 0)
                  ImdbRatingWidget(
                      showLabel: true,
                      showStar: false,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      rating: movie.imdbRating),
                if (movie.releaseDate.isNotEmpty)
                  Text(
                    AppStrings.textReleaseDate(movie.releaseDate),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.grey),
                  ),
                if (movie.duration.isNotEmpty)
                  Text(
                    'Duration: ${movie.formattedDuration}',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.grey),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
