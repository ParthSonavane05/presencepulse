import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ScoreGauge extends StatelessWidget {
  final int score;
  final double size;

  const ScoreGauge({
    super.key,
    required this.score,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: score / 100),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _ScoreGaugePainter(
              progress: value,
              score: (value * 100).round(),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(value * 100).round()}',
                    style: TextStyle(
                      fontSize: size * 0.22,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Social Score',
                    style: TextStyle(
                      fontSize: size * 0.07,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ScoreGaugePainter extends CustomPainter {
  final double progress;
  final int score;

  _ScoreGaugePainter({required this.progress, required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 24) / 2;
    const startAngle = 2.4;
    const sweepAngle = 4.5;
    const strokeWidth = 14.0;

    // Background track
    final bgPaint = Paint()
      ..color = AppTheme.surfaceCardLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Progress arc with gradient
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: const [
          AppTheme.accentCyan,
          AppTheme.primaryBlue,
          AppTheme.primaryPurple,
        ],
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * progress,
        false,
        progressPaint,
      );

      // Glow dot at end
      final endAngle = startAngle + sweepAngle * progress;
      final dotX = center.dx + radius * cos(endAngle);
      final dotY = center.dy + radius * sin(endAngle);

      final dotGlowPaint = Paint()
        ..color = AppTheme.accentCyan.withAlpha(60)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(Offset(dotX, dotY), 10, dotGlowPaint);

      final dotPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(dotX, dotY), 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScoreGaugePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
