import 'package:flutter_test/flutter_test.dart';
import 'package:golf_swing_analysis/main.dart';

void main() {
  testWidgets('SwingPath home screen renders dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const SwingPathApp());

    expect(find.text('Kayden Shi'), findsOneWidget);
    expect(find.text('HANDICAP INDEX'), findsOneWidget);
    expect(find.text('14.2'), findsOneWidget);
    expect(find.text('Record a swing'), findsOneWidget);
    expect(find.text("Today's Focus"), findsOneWidget);
    expect(find.text('Recent Swings'), findsOneWidget);
  });

  testWidgets('Bottom nav switches between Home and Drills', (WidgetTester tester) async {
    await tester.pumpWidget(const SwingPathApp());

    expect(find.text('Practice'), findsNothing);

    await tester.tap(find.text('Drills'));
    await tester.pumpAndSettle();

    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Posture & Path Reset'), findsOneWidget);
    expect(find.text('The Chair Drill'), findsOneWidget);
    expect(find.text('Drill Library'), findsOneWidget);
    expect(find.text('Kayden Shi'), findsNothing);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Kayden Shi'), findsOneWidget);
    expect(find.text('Practice'), findsNothing);
  });

  testWidgets('Bottom nav switches to Progress screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SwingPathApp());

    await tester.tap(find.text('Progress'));
    await tester.pumpAndSettle();

    expect(find.text('Last 8 weeks'), findsOneWidget);
    expect(find.text('Trending down'), findsOneWidget);
    expect(find.text('FAULT FREQUENCY'), findsOneWidget);
    expect(find.text('Early Extension'), findsOneWidget);
    expect(find.text('Milestones'), findsOneWidget);
    expect(find.text('7 earned'), findsOneWidget);
  });

  testWidgets('Bottom nav switches to Profile screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SwingPathApp());

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Pinehurst GC · Member since 2024'), findsOneWidget);
    expect(find.text('HCP 14.2'), findsOneWidget);
    expect(find.text('Pro Member'), findsOneWidget);
    expect(find.text('MY BAG'), findsOneWidget);
    expect(find.text('Driver'), findsOneWidget);
    expect(find.text('SETTINGS'), findsOneWidget);
    expect(find.text('Voice Coaching'), findsOneWidget);
  });
}
