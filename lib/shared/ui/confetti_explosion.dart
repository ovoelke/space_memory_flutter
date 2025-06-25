import 'dart:math';
import 'package:flutter/material.dart';

class ConfettiExplosion extends StatefulWidget {
  const ConfettiExplosion({super.key});

  @override
  State<ConfettiExplosion> createState() => _ConfettiExplosionState();
}

class _ConfettiExplosionState extends State<ConfettiExplosion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final int particleCount = 100;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
      setState(() {
        for (var p in _particles) {
          p.update();
        }
      });
    });

    _particles = List.generate(particleCount, (_) => Particle());

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _restart,
      child: CustomPaint(
        painter: ConfettiPainter(_particles),
        child: Container(),
      ),
    );
  }

  void _restart() {
    _particles = List.generate(particleCount, (_) => Particle());
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  static final _rand = Random();
  static final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
  ];

  Offset position = const Offset(0, 0);
  Offset velocity = Offset(
    (_rand.nextDouble() - 0.5) * 8,
    (_rand.nextDouble() - 1) * 10,
  );
  double size = _rand.nextDouble() * 6 + 4;
  Color color = colors[_rand.nextInt(colors.length)];
  double life = 1.0; // 1.0 = voll sichtbar, 0.0 = verschwunden

  void update() {
    velocity += const Offset(0, 0.3); // Schwerkraft
    position += velocity;
    life -= 0.01;
    if (life < 0) life = 0;
  }
}

class ConfettiPainter extends CustomPainter {
  final List<Particle> particles;

  ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (final p in particles) {
      final paint =
          Paint()
            ..color = p.color.withValues(alpha: p.life.clamp(0.0, 1.0))
            ..style = PaintingStyle.fill;
      canvas.drawCircle(center + p.position, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
