import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:space_memory_flutter/pages/home/ui/home_page.dart';
import 'package:space_memory_flutter/services/highscore/highscore_service.dart';
import 'package:space_memory_flutter/services/highscore/highscore_service_debug.dart';

const appSupportedLocals = [Locale('en'), Locale('de')];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerServices();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: appSupportedLocals,
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      useFallbackTranslations: kReleaseMode,
      useOnlyLangCode: true,
      child: MyApp(),
    ),
  );
}

Future<void> registerServices() async {
  final serviceLocator = GetIt.I;
  serviceLocator.registerSingletonAsync<HighscoreService>(
    () => HighScoreServiceDebug.create(),
  );
  await serviceLocator.allReady();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Space Memory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}
