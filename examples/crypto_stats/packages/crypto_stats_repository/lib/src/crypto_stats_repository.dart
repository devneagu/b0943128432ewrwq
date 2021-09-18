import 'dart:async';
import 'dart:convert';

import 'package:crypto_stats_remote_api/crypto_stats_remote_api.dart';
import 'package:crypto_stats_repository/crypto_stats_repository.dart';

/// {@template crypto_stats_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CryptoStatsRepository {
  /// {@macro crypto_stats_repository}
  CryptoStatsRepository({
    required CryptoStatsRemoteApi remoteApi,
  }) : _remoteApi = remoteApi;

  final CryptoStatsRemoteApi _remoteApi;
  IOWebSocketChannel? _channel;

  final _tradeReportController = StreamController<TradeReport>();

  Stream<TradeReport> get tradeReportStream => _tradeReportController.stream;

  Future<void> initializeWS() async {
    _channel = _remoteApi.connectWs();

    if (_channel != null) {
      _channel!.stream.listen((dynamic event) {
        try {
          final tradeReport = TradeReport.fromJson(
              jsonDecode(event as String) as Map<String, dynamic>);

          if (!_tradeReportController.isClosed) {
            _tradeReportController.add(tradeReport);
          }
        } catch (e) {
          _tradeReportController.addError(e);
        }
      });
    }
  }

  Future<void> dispose() async {
    await _tradeReportController.close();
  }
}
