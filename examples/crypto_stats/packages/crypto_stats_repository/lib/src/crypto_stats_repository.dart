import 'package:crypto_stats_remote_api/crypto_stats_remote_api.dart';

/// {@template crypto_stats_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CryptoStatsRepository {
  /// {@macro crypto_stats_repository}
  const CryptoStatsRepository({
    required this.remoteApi,
  });

  final CryptoStatsRemoteApi remoteApi;
}
