class ScoreService {
  static const int initialScore = 50;
  static const int maxScore = 100;
  static const int minScore = 0;
  static const int incrementAmount = 1;
  static const int penaltyAmount = 8;
  static const int ticksPerIncrement = 5;

  static int increment(int currentScore) {
    return (currentScore + incrementAmount).clamp(minScore, maxScore);
  }

  static int penalize(int currentScore) {
    return (currentScore - penaltyAmount).clamp(minScore, maxScore);
  }
}
