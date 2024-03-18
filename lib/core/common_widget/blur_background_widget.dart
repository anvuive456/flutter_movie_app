import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/common_widget/image_placeholder.dart';
import 'package:movie_app/core/ui/color.dart';

class BlurBackgroundWidget extends StatelessWidget {
  const BlurBackgroundWidget({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      errorWidget: (context, url, error) => Container(
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

          child: const ImagePlaceHolder()),
      imageBuilder: (context, imageProvider) => Container(
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
            image: imageProvider,
          ),
        ),
      ),
    );
  }
}
