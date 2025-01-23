import 'package:flutter/material.dart';

class ListAnimationWrapper extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const ListAnimationWrapper(
      {super.key, required this.child, required this.animation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        )
            .chain(
              CurveTween(curve: Curves.bounceInOut),
            )
            .animate(animation),
        child: child,
      ),
    );
  }
}
