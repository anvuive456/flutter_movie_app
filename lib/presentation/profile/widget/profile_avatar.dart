import 'package:flutter/material.dart';
import 'package:movie_app/core/common_widget/image_placeholder.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/color.dart';

class ProfileAvatar extends StatelessWidget {
  ///The image url
  final String url;

  ///Name will be used as placeholder when url is empty
  final String name;
  final VoidCallback? onTap;
  final double size;
  final bool showUpdateButton;

  const ProfileAvatar({
    super.key,
    required this.url,
    required this.name,
    this.onTap,
    this.size = 50,
    this.showUpdateButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(8),
        decoration: const ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(color: AppColors.lightGrey, width: .5),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          url,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const CircleImagePlaceHolder(
              icon: Icons.person_outlined,
            );
          },
        ),
      ),
    );
  }
}
