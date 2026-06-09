import 'package:flutter/material.dart';

/// Mixin para animaciones comunes de hover
mixin HoverAnimationMixin<T extends StatefulWidget> on State<T>, TickerProviderStateMixin<T> {
  late AnimationController hoverController;
  late Animation<double> scaleAnimation;
  late Animation<double> elevationAnimation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    initializeHoverAnimation();
  }

  void initializeHoverAnimation() {
    hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: hoverController, curve: Curves.easeInOut),
    );

    elevationAnimation = Tween<double>(begin: 2.0, end: 8.0).animate(
      CurvedAnimation(parent: hoverController, curve: Curves.easeInOut),
    );
  }

  void onHoverEnter() {
    setState(() => isHovered = true);
    hoverController.forward();
  }

  void onHoverExit() {
    setState(() => isHovered = false);
    hoverController.reverse();
  }

  @override
  void dispose() {
    hoverController.dispose();
    super.dispose();
  }
}

/// Mixin para animaciones de fade in
mixin FadeInAnimationMixin<T extends StatefulWidget> on State<T>, TickerProviderStateMixin<T> {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    initializeFadeAnimation();
  }

  void initializeFadeAnimation({
    int durationMs = 600,
    Curve curve = Curves.easeOut,
    Offset begin = const Offset(0, 0.3),
  }) {
    fadeController = AnimationController(
      duration: Duration(milliseconds: durationMs),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: fadeController, curve: curve),
    );

    slideAnimation = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: fadeController, curve: curve),
    );

    fadeController.forward();
  }

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
  }
}

/// Mixin para animaciones de pulsación (bounce)
mixin BounceAnimationMixin<T extends StatefulWidget> on State<T>, TickerProviderStateMixin<T> {
  late AnimationController bounceController;
  late Animation<double> bounceAnimation;

  @override
  void initState() {
    super.initState();
    initializeBounceAnimation();
  }

  void initializeBounceAnimation() {
    bounceController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    bounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: bounceController, curve: Curves.elasticOut),
    );
  }

  void triggerBounce() {
    bounceController.forward().then((_) {
      bounceController.reverse();
    });
  }

  @override
  void dispose() {
    bounceController.dispose();
    super.dispose();
  }
}

/// Mixin para animaciones de rotación
mixin RotationAnimationMixin<T extends StatefulWidget> on State<T>, TickerProviderStateMixin<T> {
  late AnimationController rotationController;
  late Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();
    initializeRotationAnimation();
  }

  void initializeRotationAnimation({bool repeat = false}) {
    rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: rotationController, curve: Curves.linear),
    );

    if (repeat) {
      rotationController.repeat();
    }
  }

  void startRotation() => rotationController.repeat();
  void stopRotation() => rotationController.stop();
  void rotateOnce() => rotationController.forward(from: 0.0);

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}

/// Mixin para animaciones de shake (sacudida)
mixin ShakeAnimationMixin<T extends StatefulWidget> on State<T>, TickerProviderStateMixin<T> {
  late AnimationController shakeController;
  late Animation<double> shakeAnimation;

  @override
  void initState() {
    super.initState();
    initializeShakeAnimation();
  }

  void initializeShakeAnimation() {
    shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0), weight: 1),
    ]).animate(shakeController);
  }

  void triggerShake() {
    shakeController.forward(from: 0.0);
  }

  @override
  void dispose() {
    shakeController.dispose();
    super.dispose();
  }
}

/// Mixin para staggered animations en listas
mixin StaggeredAnimationMixin<T extends StatefulWidget> on State<T>, TickerProviderStateMixin<T> {
  late AnimationController staggerController;

  @override
  void initState() {
    super.initState();
    initializeStaggerAnimation();
  }

  void initializeStaggerAnimation({int durationMs = 1000}) {
    staggerController = AnimationController(
      duration: Duration(milliseconds: durationMs),
      vsync: this,
    );
    staggerController.forward();
  }

  Animation<double> getStaggeredAnimation(int index, int total) {
    final start = (index / total) * 0.5;
    final end = start + 0.5;

    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: staggerController,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    staggerController.dispose();
    super.dispose();
  }
}
