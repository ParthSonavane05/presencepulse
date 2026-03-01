import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/score_service.dart';
import '../services/nudge_service.dart';
import '../services/detection_service.dart';
import '../models/nudge_message.dart';
import '../models/social_session.dart';

// State
class SocialModeState {
  final bool isActive;
  final int score;
  final int elapsedSeconds;
  final int phoneChecks;
  final int streak;
  final bool isNearbyDetected;
  final NudgeMessage? lastNudge;
  final SocialSession? lastSession;

  const SocialModeState({
    this.isActive = false,
    this.score = ScoreService.initialScore,
    this.elapsedSeconds = 0,
    this.phoneChecks = 0,
    this.streak = 0,
    this.isNearbyDetected = false,
    this.lastNudge,
    this.lastSession,
  });

  SocialModeState copyWith({
    bool? isActive,
    int? score,
    int? elapsedSeconds,
    int? phoneChecks,
    int? streak,
    bool? isNearbyDetected,
    NudgeMessage? lastNudge,
    SocialSession? lastSession,
  }) {
    return SocialModeState(
      isActive: isActive ?? this.isActive,
      score: score ?? this.score,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      phoneChecks: phoneChecks ?? this.phoneChecks,
      streak: streak ?? this.streak,
      isNearbyDetected: isNearbyDetected ?? this.isNearbyDetected,
      lastNudge: lastNudge ?? this.lastNudge,
      lastSession: lastSession ?? this.lastSession,
    );
  }

  String get formattedTime {
    final minutes =
        (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds =
        (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

// Notifier
class SocialModeNotifier extends StateNotifier<SocialModeState> {
  SocialModeNotifier() : super(const SocialModeState()) {
    _loadStreak();
  }

  Timer? _timer;
  DateTime? _sessionStart;
  final NudgeService _nudgeService = NudgeService();
  final DetectionService _detectionService = DetectionService();

  List<String> get nearbyFriends => _detectionService.getNearbyFriends();

  Future<void> _loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final streak = prefs.getInt('daily_streak') ?? 0;
    final lastDate = prefs.getString('last_session_date') ?? '';
    final today = DateTime.now().toIso8601String().substring(0, 10);

    if (lastDate == today) {
      state = state.copyWith(streak: streak);
    } else {
      // Check if it was yesterday (continue streak) or older (reset)
      if (lastDate.isNotEmpty) {
        final last = DateTime.parse(lastDate);
        final diff = DateTime.now().difference(last).inDays;
        if (diff == 1) {
          state = state.copyWith(streak: streak);
        } else if (diff > 1) {
          state = state.copyWith(streak: 0);
        }
      }
    }
  }

  Future<void> _saveStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_streak', streak);
    await prefs.setString(
      'last_session_date',
      DateTime.now().toIso8601String().substring(0, 10),
    );
  }

  void startSession() {
    _sessionStart = DateTime.now();
    _detectionService.startDetection();
    state = SocialModeState(
      isActive: true,
      score: ScoreService.initialScore,
      elapsedSeconds: 0,
      phoneChecks: 0,
      streak: state.streak,
      isNearbyDetected: true,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick();
    });
  }

  void _tick() {
    if (!state.isActive) return;

    final newElapsed = state.elapsedSeconds + 1;
    int newScore = state.score;

    if (newElapsed % ScoreService.ticksPerIncrement == 0) {
      newScore = ScoreService.increment(newScore);
    }

    state = state.copyWith(
      elapsedSeconds: newElapsed,
      score: newScore,
    );
  }

  NudgeMessage simulatePhoneUsage() {
    final nudge = _nudgeService.getRandomNudge();
    final newScore = ScoreService.penalize(state.score);
    state = state.copyWith(
      score: newScore,
      phoneChecks: state.phoneChecks + 1,
      lastNudge: nudge,
    );
    return nudge;
  }

  SocialSession endSession() {
    _timer?.cancel();
    _timer = null;
    _detectionService.stopDetection();

    final session = SocialSession(
      startTime: _sessionStart ?? DateTime.now(),
      endTime: DateTime.now(),
      finalScore: state.score,
      phoneChecks: state.phoneChecks,
    );

    final newStreak = state.streak + 1;
    _saveStreak(newStreak);

    state = state.copyWith(
      isActive: false,
      isNearbyDetected: false,
      lastSession: session,
      streak: newStreak,
    );

    return session;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Provider
final socialModeProvider =
    StateNotifierProvider<SocialModeNotifier, SocialModeState>(
  (ref) => SocialModeNotifier(),
);
