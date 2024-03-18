import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/app_strings.dart';

import '../../../core/ui/color.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Text(
        AppStrings.titleAppName,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlue,
            ),
      ),
    );
  }
}
