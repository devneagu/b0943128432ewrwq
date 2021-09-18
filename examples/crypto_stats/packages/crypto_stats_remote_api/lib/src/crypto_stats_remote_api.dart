import 'dart:convert';

import 'package:web_socket_channel/io.dart';

/// {@template crypto_stats_remote_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CryptoStatsRemoteApi {
  /// {@macro crypto_stats_remote_api}
  const CryptoStatsRemoteApi({
    this.baseUrl = 'wss://ws-sandbox.coinapi.io/v1/',
    this.webSocketScheme = 'wss',
    required this.apiKey,
  });

  /// Web socket scheme defaults to `wss`
  final String webSocketScheme;

  /// API Key
  final String apiKey;

  /// Base url
  final String baseUrl;

  /// Returns a [IOWebSocketChannel] that is connected to the api
  IOWebSocketChannel connectWs() {
    try {
      final baseURI = Uri.parse(baseUrl);
      final _uri = Uri(
        scheme: webSocketScheme,
        host: baseURI.host,
        port: baseURI.port,
        path: baseURI.path,
      );

      final channel = IOWebSocketChannel.connect(
        _uri.toString(),
        pingInterval: const Duration(seconds: 30),
      );

      channel.sink.add(
        json.encode({
          'type': 'hello',
          'apikey': apiKey,
          'heartbeat': false,
          'subscribe_data_type': ['trade'],
          'subscribe_filter_symbol_id': [
            'COINBASE_SPOT_BTC_USD',
            'COINBASE_SPOT_ETH_USD',
            'COINBASE_SPOT_ADA_USD',
          ]
        }),
      );

      return channel;
    } catch (e) {
      rethrow;
    }
  }
}
