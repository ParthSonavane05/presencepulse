import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/social_session.dart';
import '../theme/app_theme.dart';
import '../widgets/score_gauge.dart';

class SessionSummaryScreen extends StatelessWidget {
  final SocialSession session;

  const SessionSummaryScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const Spacer(flex: 1),

                // Performance emoji
                Text(
                  session.performanceEmoji,
                  style: const TextStyle(fontSize: 56),
                ),
                const SizedBox(height: 12),

                // Title
                const Text(
                  'Session Complete',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  session.performanceMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),

                // Score gauge
                ScoreGauge(score: session.finalScore, size: 160),
                const SizedBox(height: 32),

                // Stats row
                Row(
                  children: [
                    Expanded(
                      child: _StatItem(
                        icon: Icons.timer_outlined,
                        label: 'Duration',
                        value: session.formattedDuration,
                        color: AppTheme.accentCyan,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatItem(
                        icon: Icons.phone_android,
                        label: 'Phone Checks',
                        value: '${session.phoneChecks}',
                        color: AppTheme.warning,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatItem(
                        icon: Icons.star_rounded,
                        label: 'Final Score',
                        value: '${session.finalScore}',
                        color: _scoreColor(session.finalScore),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),

                // Start Again button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withAlpha(80),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.replay_rounded, size: 22),
                      label: const Text(
                        'Start Again',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _scoreColor(int score) {
    if (score >= 80) return AppTheme.success;
    if (score >= 50) return AppTheme.warning;
    return AppTheme.danger;
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
