import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/color.dart';

class MovieGenreWidget extends StatelessWidget {
  final List<String> genres;

  const MovieGenreWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        for (final genre in genres)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: AppColors.white))),
            child: Text(
              genre,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                 ,
            ),
          )
      ],
    );
  }
}
