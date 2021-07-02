// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:erstegroup_api_consumer/provider/combined/CombinedResultsProvider.dart';
import 'package:erstegroup_api_consumer/screen/combined/CombinedResultsScreen.dart';
import 'package:erstegroup_api_consumer/util/config/ConfigUtils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ConfigUtils.me.init();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale("en"),
      Locale("cs"),
    ],
    path: 'lang',
    useOnlyLangCode: true,
    startLocale: const Locale("cs"),
    fallbackLocale: const Locale("cs"),
    child: MyApp(),
  ));
}

/// The main app class.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CombinedResultProvider.me,
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Erste Combine Products Mobile App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CombinedResultsScreen(),
      ),
    );
  }
}
