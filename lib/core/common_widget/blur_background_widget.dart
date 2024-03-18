import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/color.dart';

class BlurBackgroundWidget extends StatelessWidget {
  const BlurBackgroundWidget({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.transparent,
          AppColors.black,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 1],
      )),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                imageUrl,
              ))),
    );
  }
}
