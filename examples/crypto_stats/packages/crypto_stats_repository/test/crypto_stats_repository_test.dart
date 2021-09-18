// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:crypto_stats_repository/crypto_stats_repository.dart';

void main() {
  group('CryptoStatsRepository', () {
    test('can be instantiated', () {
      expect(CryptoStatsRepository(), isNotNull);
    });
  });
}