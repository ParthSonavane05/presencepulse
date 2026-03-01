import 'package:flutter_test/flutter_test.dart';
import 'package:presencepulse/main.dart';

void main() {
  testWidgets('App launches without error', (WidgetTester tester) async {
    await tester.pumpWidget(const PresencePulseApp());
    expect(find.text('Presence Pulse'), findsOneWidget);
  });
}
