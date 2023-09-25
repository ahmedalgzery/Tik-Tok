// ignore_for_file: library_private_types_in_public_api is used to ignore specific linting rules in this file, library_private_types_in_public_api

import 'package:flutter/material.dart';

// A custom widget for adding a rotating animation to a child widget
class CircleAnimation extends StatefulWidget {
  final Widget child;

  // Constructor for CircleAnimation that takes a child widget as a parameter
  const CircleAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _CircleAnimationState createState() => _CircleAnimationState();
}

// The state class for CircleAnimation
class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    // Initialize an AnimationController for managing the animation
    controller = AnimationController(
      vsync: this, // Specify this widget as the vsync provider
      duration: const Duration(
        milliseconds: 5000, // Duration of the rotation animation (5 seconds)
      ),
    );

    // Start and repeat the animation
    controller.forward();
    controller.repeat();
  }

  @override
  void dispose() {
    // Dispose of the AnimationController when the widget is removed
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      // Apply a rotation animation to the child widget
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: widget.child, // Display the provided child widget
    );
  }
}
