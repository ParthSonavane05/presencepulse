import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatusCard extends StatelessWidget {
  final bool isActive;
  final String formattedTime;

  const StatusCard({
    super.key,
    required this.isActive,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: AppTheme.cardDecoration(
        hasGlow: isActive,
        glowColor: AppTheme.success,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Status indicator dot
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppTheme.success : AppTheme.textMuted,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppTheme.success.withAlpha(120),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(width: 12),
          // Status text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isActive ? 'Social Mode Active' : 'Social Mode Inactive',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isActive ? AppTheme.success : AppTheme.textSecondary,
                  ),
                ),
                if (isActive)
                  Text(
                    'Stay present and engaged',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          // Timer
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surface.withAlpha(200),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.success.withAlpha(60),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: AppTheme.success,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
