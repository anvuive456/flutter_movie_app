import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/color.dart';

class ImagePlaceHolder extends StatelessWidget {
  final double radius;
  final double? width;
  final double? height;

  const ImagePlaceHolder({super.key, this.radius = 0.0, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width?? double.maxFinite,
      height:height?? double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(radius)),
      child: const Icon(
        Icons.image_outlined,
        size: 50,
      ),
    );
  }
}

class CircleImagePlaceHolder extends StatelessWidget {
  final double size;
  final IconData icon;

  const CircleImagePlaceHolder(
      {super.key, this.size = 50, this.icon = Icons.image_outlined});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.all(5),
      decoration: const ShapeDecoration(
          color: AppColors.lightGrey,
          shape: CircleBorder(
              side: BorderSide(color: AppColors.lightGrey, width: 1))),
      child: Icon(
        icon,
      ),
    );
  }
}
