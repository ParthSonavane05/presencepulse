import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/social_mode_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/score_gauge.dart';
import '../widgets/status_card.dart';
import '../widgets/streak_card.dart';
import '../widgets/detection_card.dart';
import 'session_summary_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(socialModeProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // App header
                _buildHeader(),
                const SizedBox(height: 24),

                // Score gauge
                ScoreGauge(score: state.score),
                const SizedBox(height: 24),

                // Status card
                StatusCard(
                  isActive: state.isActive,
                  formattedTime: state.formattedTime,
                ),
                const SizedBox(height: 12),

                // Streak card
                StreakCard(streak: state.streak),
                const SizedBox(height: 12),

                // Detection card
                DetectionCard(isDetected: state.isNearbyDetected),
                const SizedBox(height: 28),

                // Action buttons
                _buildActionButtons(context, ref, state),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.people_alt_rounded, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Parth 👋',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                'Presence Pulse · Social Mode AI',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.surfaceCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.settings_outlined,
            color: AppTheme.textSecondary,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    SocialModeState state,
  ) {
    final notifier = ref.read(socialModeProvider.notifier);

    if (!state.isActive) {
      // Inactive: big Start button
      return SizedBox(
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
              notifier.startSession();
            },
            icon: const Icon(Icons.play_arrow_rounded, size: 26),
            label: const Text(
              'Start Social Mode',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
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
      );
    }

    // Active: Phone Usage + End Session buttons
    return Column(
      children: [
        // Simulate Phone Usage button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            onPressed: () {
              HapticFeedback.heavyImpact();
              final nudge = notifier.simulatePhoneUsage();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Text(
                        nudge.emoji,
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'AI Nudge',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: AppTheme.accentCyan,
                              ),
                            ),
                            Text(
                              nudge.text,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.danger.withAlpha(40),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '-8',
                          style: TextStyle(
                            color: AppTheme.danger,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: AppTheme.surfaceCard,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            icon: const Icon(Icons.phone_android_rounded, size: 20),
            label: const Text(
              'Simulate Phone Usage',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.warning,
              side: BorderSide(color: AppTheme.warning.withAlpha(120)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // End Session button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: () {
              HapticFeedback.lightImpact();
              final session = notifier.endSession();
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SessionSummaryScreen(session: session),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      )),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 400),
                ),
              );
            },
            icon: const Icon(Icons.stop_rounded, size: 22),
            label: const Text(
              'End Session',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.danger.withAlpha(40),
              foregroundColor: AppTheme.danger,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
