import 'package:flutter/material.dart';

class AppAnimations {
  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Widget fadeScale(Widget child, {Duration duration = const Duration(milliseconds: 500)}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.9 + (value * 0.1),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  static Widget slideIn(Widget child, {Duration duration = const Duration(milliseconds: 500), Offset offset = const Offset(0, 0.5)}) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: offset, end: Offset.zero),
      duration: duration,
      builder: (BuildContext context, Offset value, Widget? child) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget bounceIn(Widget child, {Duration duration = const Duration(milliseconds: 600)}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (BuildContext context, double value, Widget? child) {
        final curveValue = Curves.elasticOut.transform(value);
        return Transform.scale(
          scale: curveValue,
          child: child,
        );
      },
      child: child,
    );
  }
}