import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_memory_flutter/page/home/ui/home_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("HomePage Tests", () {
    Widget buildTestWidget() {
      return EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        startLocale: Locale('en'),
        saveLocale: false,
        useOnlyLangCode: true,
        child: MaterialApp(home: Scaffold(body: HomePage())),
      );
    }

    testWidgets("Buttons for game start and highscore page are shown", (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text(tr('home_page.start_button')), findsOneWidget);
      expect(find.text(tr('home_page.highscores_button')), findsOneWidget);
    });

    testWidgets("Start button opens difficulty dialog", (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('start_button')));
      await tester.pump();

      expect(find.text(tr('shared.difficulty.easy')), findsOneWidget);
      expect(find.text(tr('shared.difficulty.medium')), findsOneWidget);
      expect(find.text(tr('shared.difficulty.hard')), findsOneWidget);
    });
  });
}
