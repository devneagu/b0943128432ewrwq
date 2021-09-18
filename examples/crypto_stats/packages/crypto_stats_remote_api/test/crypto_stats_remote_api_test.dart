// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:crypto_stats_remote_api/crypto_stats_remote_api.dart';
import 'package:test/test.dart';
import 'fixtures/fixture_reader.dart';

void main() {
  group('CryptoStatsRemoteApi', () {
    final jsonInitializationRequest =
        fixture('socket_initialization_request.json');

    CryptoStatsRemoteApi apiWithPort(int port) => CryptoStatsRemoteApi(
          apiKey: 'apiKey',
          webSocketScheme: 'ws',
          baseUrl: 'ws://localhost:$port',
        );

    test('can be instantiated', () async {
      final server = await HttpServer.bind('localhost', 0);
      server.transform(WebSocketTransformer()).listen((webSocket) {
        final channel = IOWebSocketChannel(webSocket);
        channel.stream.listen((dynamic request) {
          expect(
            request,
            equals(jsonInitializationRequest),
          );
          channel.sink.add('');
          channel.sink.close();
        });
      });

      final api = apiWithPort(server.port);
      final webSocket = api.connectWs();

      await expectLater(webSocket.stream, emitsInOrder(<dynamic>['']));
    });
  });
}
