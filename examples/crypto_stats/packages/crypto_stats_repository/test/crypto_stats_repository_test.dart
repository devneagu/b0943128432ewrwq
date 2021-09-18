// ignore_for_file: prefer_const_constructors
import 'package:crypto_stats_remote_api/crypto_stats_remote_api.dart';
import 'package:crypto_stats_repository/crypto_stats_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCryptoStatsRemoteApi extends Mock implements CryptoStatsRemoteApi {}

void main() {
  group('CryptoStatsRepository', () {
    late CryptoStatsRemoteApi remoteApi;
    late CryptoStatsRepository repository;

    setUp(() {
      remoteApi = MockCryptoStatsRemoteApi();
      repository = CryptoStatsRepository(remoteApi: remoteApi);
    });

    test('can be instantiated', () {
      expect(repository, isNotNull);
    });
  });
}
