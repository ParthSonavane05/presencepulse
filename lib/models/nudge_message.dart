class NudgeMessage {
  final String text;
  final String emoji;

  const NudgeMessage({required this.text, required this.emoji});

  @override
  String toString() => '$emoji $text';

  static const List<NudgeMessage> allNudges = [
    NudgeMessage(text: 'Stay present', emoji: '👀'),
    NudgeMessage(text: 'This moment matters', emoji: '✨'),
    NudgeMessage(text: 'Focus on people, not screens', emoji: '🤝'),
    NudgeMessage(text: 'Be here now', emoji: '🧘'),
    NudgeMessage(text: 'Your friends deserve your attention', emoji: '💬'),
    NudgeMessage(text: 'Put the phone down', emoji: '📵'),
    NudgeMessage(text: 'Real connections beat notifications', emoji: '❤️'),
    NudgeMessage(text: 'Look up and smile', emoji: '😊'),
    NudgeMessage(text: 'The best moments happen offline', emoji: '🌅'),
    NudgeMessage(text: 'You were doing great! Keep going', emoji: '🔥'),
    NudgeMessage(text: 'Screen time can wait', emoji: '⏳'),
    NudgeMessage(text: 'Be the friend you want to have', emoji: '🌟'),
  ];
}
