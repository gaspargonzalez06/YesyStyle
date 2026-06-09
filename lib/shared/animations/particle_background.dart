import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class Particle {
  double x;
  double y;
  double vx;
  double vy;
  double size;
  Color color;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.opacity,
  });
}

class ParticleBackground extends StatefulWidget {
  final int particleCount;
  final bool interactive;

  const ParticleBackground({
    Key? key,
    this.particleCount = 50,
    this.interactive = true,
  }) : super(key: key);

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;
  final Random _random = Random();
  Offset? _mousePosition;

  @override
  void initState() {
    super.initState();
    particles = [];
    _initializeParticles();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  void _initializeParticles() {
    particles.clear();
    for (int i = 0; i < widget.particleCount; i++) {
      particles.add(
        Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          vx: (_random.nextDouble() - 0.5) * 0.0005,
          vy: (_random.nextDouble() - 0.5) * 0.0005,
          size: _random.nextDouble() * 3 + 1,
          color: _random.nextBool()
              ? AppColors.roseGold
              : AppColors.primaryDark,
          opacity: _random.nextDouble() * 0.5 + 0.2,
        ),
      );
    }
  }

  void _updateParticles(Size size) {
    for (var particle in particles) {
      // Update position
      particle.x += particle.vx;
      particle.y += particle.vy;

      // Interact with mouse if enabled
      if (widget.interactive && _mousePosition != null) {
        final dx = _mousePosition!.dx / size.width - particle.x;
        final dy = _mousePosition!.dy / size.height - particle.y;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < 0.1) {
          particle.vx += dx * 0.00001;
          particle.vy += dy * 0.00001;
        }
      }

      // Keep particles within bounds
      if (particle.x < 0 || particle.x > 1) {
        particle.vx *= -1;
        particle.x = particle.x.clamp(0.0, 1.0);
      }
      if (particle.y < 0 || particle.y > 1) {
        particle.vy *= -1;
        particle.y = particle.y.clamp(0.0, 1.0);
      }

      // Add slight random movement
      particle.vx += (_random.nextDouble() - 0.5) * 0.00001;
      particle.vy += (_random.nextDouble() - 0.5) * 0.00001;

      // Limit velocity
      particle.vx = particle.vx.clamp(-0.001, 0.001);
      particle.vy = particle.vy.clamp(-0.001, 0.001);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: widget.interactive
          ? (event) {
              setState(() {
                _mousePosition = event.position;
              });
            }
          : null,
      onExit: widget.interactive
          ? (_) {
              setState(() {
                _mousePosition = null;
              });
            }
          : null,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              _updateParticles(constraints.biggest);
              return CustomPaint(
                size: constraints.biggest,
                painter: ParticlePainter(
                  particles: particles,
                  mousePosition: _mousePosition,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset? mousePosition;

  ParticlePainter({
    required this.particles,
    this.mousePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw connections between nearby particles
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final particle1 = particles[i];
        final particle2 = particles[j];

        final dx = particle1.x - particle2.x;
        final dy = particle1.y - particle2.y;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < 0.15) {
          final paint = Paint()
            ..color = AppColors.roseGold.withOpacity(
              (1 - distance / 0.15) * 0.1,
            )
            ..strokeWidth = 0.5;

          canvas.drawLine(
            Offset(particle1.x * size.width, particle1.y * size.height),
            Offset(particle2.x * size.width, particle2.y * size.height),
            paint,
          );
        }
      }
    }

    // Draw particles
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill;

      final glowPaint = Paint()
        ..color = particle.color.withOpacity(particle.opacity * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      final center = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );

      // Draw glow
      canvas.drawCircle(center, particle.size * 2, glowPaint);

      // Draw particle
      canvas.drawCircle(center, particle.size, paint);
    }

    // Draw mouse interaction circle
    if (mousePosition != null) {
      final paint = Paint()
        ..color = AppColors.roseGold.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(mousePosition!, 50, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
