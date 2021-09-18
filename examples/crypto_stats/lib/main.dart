import 'package:crypto_stats/app/app.dart';
import 'package:crypto_stats_repository/crypto_stats_repository.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  final cryptoStatsRepository = CryptoStatsRepository(
    remoteApi: const CryptoStatsRemoteApi(
      apiKey: '62740DF0-FE15-4481-96E2-CFC7A640996F',
    ),
  );

  // Run the app and pass its dependencies to it.
  runApp(App(cryptoStatsRepository: cryptoStatsRepository));
}
