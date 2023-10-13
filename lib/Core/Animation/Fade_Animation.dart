import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation({required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('width', 0.0.tweenTo(1.0), duration: const Duration(milliseconds: 500))
      ..tween(AniProps.translateY, (-30.0).tweenTo(0.0), duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut);
    //Movie movieTweenValue = tween.transform(0.5);
    return CustomAnimationBuilder(
        delay: Duration(milliseconds: (500 * delay).round()),
        duration: tween.duration,
        tween: tween,
        child: child,
        builder: (BuildContext context, Movie value, Widget? child) {
          return Opacity(
              opacity: 0.3,
              child: Transform.translate(
                child: child,
                  offset: Offset(0.0, -30.0,)
              )
          );
        });

  }
}