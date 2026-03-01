import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/detection_service.dart';

class DetectionCard extends StatelessWidget {
  final bool isDetected;

  const DetectionCard({super.key, required this.isDetected});

  @override
  Widget build(BuildContext context) {
    final friends = isDetected ? DetectionService.mockNearbyFriends : <String>[];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: AppTheme.cardDecoration(
        hasGlow: isDetected,
        glowColor: AppTheme.accentCyan,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isDetected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
                color: isDetected ? AppTheme.accentCyan : AppTheme.textMuted,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isDetected ? 'Nearby Users Detected' : 'No Nearby Users',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDetected
                        ? AppTheme.accentCyan
                        : AppTheme.textSecondary,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDetected
                      ? AppTheme.success.withAlpha(30)
                      : AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isDetected ? 'ACTIVE' : 'IDLE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: isDetected
                        ? AppTheme.success
                        : AppTheme.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Friend avatars
          if (isDetected)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: friends.map((name) {
                return Chip(
                  avatar: CircleAvatar(
                    backgroundColor: AppTheme.primaryBlue,
                    radius: 12,
                    child: Text(
                      name[0],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  label: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  backgroundColor: AppTheme.surfaceLight,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                );
              }).toList(),
            ),
          const SizedBox(height: 8),
          Text(
            DetectionService.detectionLabel,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.textMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
