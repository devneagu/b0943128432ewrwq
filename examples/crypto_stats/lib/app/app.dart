import 'package:crypto_stats/crypto_stats/crypto_stats.dart';
import 'package:crypto_stats/generated/fonts.gen.dart';
import 'package:crypto_stats_repository/crypto_stats_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// {@template app}
/// The widget that handles the dependency injection of your application.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({
    Key? key,
    required this.cryptoStatsRepository,
  }) : super(key: key);

  final CryptoStatsRepository cryptoStatsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CryptoStatsRepository>.value(
          value: cryptoStatsRepository,
        )
      ],
      child: const AppView(),
    );
  }
}

/// {@template app_view}
/// The widget that configures your application.
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Providing a `restorationScopeId` allows the `Navigator` built by the
      // `MaterialApp` to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',
      // Provide the generated AppLocalizations to the `MaterialApp`. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code.
      ],
      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // `SettingsBloc` to display the correct theme.
      theme: ThemeData(fontFamily: FontFamily.poppins),
      darkTheme: ThemeData.dark(),

      home: const CryptoStatsPage(),
    );
  }
}
