import 'dart:math';
import '../models/nudge_message.dart';

class NudgeService {
  final _random = Random();
  int _lastIndex = -1;

  NudgeMessage getRandomNudge() {
    final nudges = NudgeMessage.allNudges;
    int index;
    do {
      index = _random.nextInt(nudges.length);
    } while (index == _lastIndex && nudges.length > 1);
    _lastIndex = index;
    return nudges[index];
  }
}
