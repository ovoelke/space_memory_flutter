import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_memory_flutter/home/ui/home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Expect buttons for start and highscore', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        startLocale: Locale('en'),
        child: MaterialApp(home: Scaffold(body: HomeScreen())),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(tr('home.start')), findsOneWidget);
    expect(find.text(tr('home.highscores')), findsOneWidget);

    // Tap the 'start' button and trigger a dialog.
    await tester.tap(find.byKey(const Key('button_start')));
    await tester.pump();

    // Verify that dialog shows three buttons
    expect(find.text(tr('difficulty.easy')), findsOneWidget);
    expect(find.text(tr('difficulty.medium')), findsOneWidget);
    expect(find.text(tr('difficulty.hard')), findsOneWidget);
  });
}
