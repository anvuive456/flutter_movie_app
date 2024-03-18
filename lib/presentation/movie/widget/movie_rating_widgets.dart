import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/color.dart';

class MovieRatingChartWidget extends StatelessWidget {
  final List<num> ratings;

  const MovieRatingChartWidget({super.key, required this.ratings});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: buildColumns(context),
      ),
    );
  }

  ///Re arrange all ratings to 1,2,3,..,10
  ///
  /// The key is the name will be column
  Map<int, int> get scaffoldedRatings {
    var map = <int, int>{};
    for (final rating in ratings) {
      if (map[rating.toInt()] != null) {
        map[rating.toInt()] = map[rating.toInt()]! + 1;
      } else {
        map[rating.toInt()] = 1;
      }
    }
    return map.sortByKeys((a, b) => a - b);
  }

  ///The max total rating in [scaffoldedRatings]
  int get maxTotalRating {
    int maxRating = 0;
    scaffoldedRatings.forEach((key, value) {
      maxRating = max(maxRating, value);
    });
    return maxRating;
  }

  ///Build list of columns
  List<Widget> buildColumns(BuildContext context) {
    List<Widget> widgets = [];
    scaffoldedRatings.forEach((key, value) {
      widgets.add(Expanded(child: buildRatingColumn(context, key, value)));
    });
    return widgets;
  }

  ///Build single column
  Widget buildRatingColumn(
      BuildContext context,

      ///The name of the column
      ///
      /// Eg: 1, 2 ,3
      int name,

      ///The total rating by the name
      int totalRating) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: FractionallySizedBox(
            heightFactor: totalRating / maxTotalRating,
            widthFactor: .5,
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                  color: AppColors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
            ),
          ),
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: name.toString()),
            const WidgetSpan(
                child: Icon(
                  Icons.star_outlined,
                  color: AppColors.yellow,
                  size: 10,
                ),
                alignment: PlaceholderAlignment.middle)
          ]),
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: AppColors.yellow),
        )
      ],
    );
  }
}



class ImdbRatingWidget extends StatelessWidget {
  final num rating;

  ///Show the label "IMDB"
  ///
  /// Default to false
  final bool showLabel;

  ///Show the start
  ///
  /// Default to true
  final bool showStar;

  final EdgeInsetsGeometry? margin;

  const ImdbRatingWidget(
      {super.key,
      required this.rating,
      this.showLabel = false,
      this.showStar = true,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(3),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: AppColors.yellow, width: .5))),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${showLabel ? 'IMDB ' : ''}$rating',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.yellow),
          ),
          if (showStar)
            const Icon(
              Icons.star,
              color: AppColors.yellow,
              size: 15,
            )
        ],
      ),
    );
  }
}
