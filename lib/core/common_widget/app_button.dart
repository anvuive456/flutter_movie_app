
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:movie_app/core/ui/custom_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppButton extends StatelessWidget {
  final bool loading;
  final String label;
  final VoidCallback onTap;
  final bool enabled;
  final Color buttonColor;
  final bool filled;
  final EdgeInsetsGeometry? margin;

  const AppButton({
    super.key,
    this.loading = false,
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.filled = true,
    this.buttonColor = AppColors.lightBlue,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(color: !filled ? buttonColor : AppColors.white);
    double? buttonWidth =
        switch (loading) { true => 80, false => double.maxFinite };

    Widget child = switch (loading) {
      true => const CircularProgressIndicator.adaptive(),
      false => Text(label, style: textStyle)
    };

    EdgeInsets padding = switch (loading) {
      true => const EdgeInsets.all(10),
      false => const EdgeInsets.symmetric(horizontal: 11, vertical: 5)
    };

    Decoration decoration = switch (loading) {
      true => CustomDecorations.circleDecoration(
          color: enabled ? filled? buttonColor: Colors.transparent : AppColors.lightGrey,
          borderColor: !filled ? buttonColor : Colors.transparent,
        ),
      false => CustomDecorations.roundedDecoration(
          color: enabled ? filled? buttonColor: Colors.transparent : AppColors.lightGrey,
          borderColor: !filled ? buttonColor : Colors.transparent,
        )
    };

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
          width: buttonWidth,
          padding: padding,
          decoration: decoration,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300), child: child)),
    );
  }
}

class FormSubmitButton extends StatelessWidget {
  final bool loading;
  final String label;
  final VoidCallback onTap;
  final Color buttonColor;
  final AbstractControl? form;

  const FormSubmitButton({
    super.key,
    this.loading = false,
    required this.label,
    required this.onTap,
    this.form,
    this.buttonColor = AppColors.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    final form = this.form ?? ReactiveForm.of(context);
    final disabled = form == null || form.invalid;

    final textStyle = Theme.of(context).textTheme.titleLarge;
    double? buttonWidth =
        switch (loading) { true => 80, false => double.maxFinite };

    Widget child = switch (loading) {
      true => const CircularProgressIndicator.adaptive(),
      false => Text(label, style: textStyle)
    };

    EdgeInsets padding = switch (loading) {
      true => const EdgeInsets.all(10),
      false => const EdgeInsets.symmetric(horizontal: 11, vertical: 5)
    };

    Decoration decoration = switch (loading) {
      true => CustomDecorations.circleDecoration(
          color: !disabled ? buttonColor : AppColors.lightGrey),
      false => CustomDecorations.roundedDecoration(
          color: !disabled ? buttonColor : AppColors.lightGrey,
        )
    };

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
          width: buttonWidth,
          padding: padding,
          decoration: decoration,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300), child: child)),
    );
  }
}
