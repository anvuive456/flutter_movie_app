import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/color.dart';

abstract final class CustomDecorations {
  static InputDecoration fieldDecoration({
    final Widget? prefix,
    final Widget? suffix,
  }) {
    return InputDecoration(
        focusColor: AppColors.lightBlue,
        contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
        suffixIconColor: AppColors.white,
        prefixIconColor: AppColors.white);
  }

  static ShapeDecoration circleDecoration({
    final Color? color,
    final double width = 1,
    final Color borderColor = AppColors.lightGrey,
  }) {
    return ShapeDecoration(
      color: color,
      shape: CircleBorder(side: BorderSide(width: width, color: borderColor)),
    );
  }

  static ShapeDecoration roundedDecoration({
    final Color? color,
    final double width = 1,
    final Color borderColor = AppColors.lightGrey,
  }) {
    return ShapeDecoration(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor, width: width),
      ),
    );
  }
}
