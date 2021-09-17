import 'package:web_socket_channel/io.dart';

/// {@template crypto_stats_remote_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CryptoStatsRemoteApi {
  /// {@macro crypto_stats_remote_api}
  const CryptoStatsRemoteApi();

  /// Returns a [IOWebSocketChannel] that is connected to the api
  IOWebSocketChannel connectWs() {
    try {
      final baseURI = Uri.parse('wss://ws-sandbox.coinapi.io/v1/');
      final _uri = Uri(
        scheme: 'wss',
        host: baseURI.host,
        port: baseURI.port,
        path: baseURI.path,
      );

      final channel = IOWebSocketChannel.connect(
        _uri.toString(),
        pingInterval: const Duration(seconds: 30),
      );

      channel.sink.add({
        'type': 'hello',
        'apikey': '62740DF0-FE15-4481-96E2-CFC7A640996F',
        'heartbeat': false,
        'subscribe_data_type': ['trade'],
        'subscribe_filter_symbol_id': ['COINBASE_SPOT_BTC_USD']
      });

      return channel;
    } catch (e) {
      rethrow;
    }
  }
}
