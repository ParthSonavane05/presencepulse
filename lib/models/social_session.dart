class SocialSession {
  final DateTime startTime;
  final DateTime endTime;
  final int finalScore;
  final int phoneChecks;

  SocialSession({
    required this.startTime,
    required this.endTime,
    required this.finalScore,
    required this.phoneChecks,
  });

  Duration get duration => endTime.difference(startTime);

  String get formattedDuration {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get performanceMessage {
    if (finalScore >= 80) return 'Great presence! 🌟';
    if (finalScore >= 50) return 'Good, but improve focus 💪';
    return 'Try reducing distractions 📱';
  }

  String get performanceEmoji {
    if (finalScore >= 80) return '🏆';
    if (finalScore >= 50) return '👍';
    return '🔄';
  }
}
