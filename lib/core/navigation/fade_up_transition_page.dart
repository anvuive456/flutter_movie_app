
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage fadeUpTransitionPage({required Widget child}) {
  return CustomTransitionPage(child: child,
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      //the animation tween for sliding up
      // this page will start from 80% of the screen and slide up
      final slideTween = Tween(
        begin: const Offset(0, .2),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.ease));
      //the animation tween for fading
      final opacityTween = Tween<double>(
        begin: 0,
        end: 1,
      ).chain(CurveTween(curve: Curves.ease));

      return FadeTransition(
        opacity: animation.drive(opacityTween),
        child: SlideTransition(
            position: animation.drive(slideTween), child: child),
      );
    },

  );
}