import 'dart:convert';

import 'package:crypto_stats_repository/crypto_stats_repository.dart';
import 'package:test/test.dart';
import '../test/fixtures/fixture_reader.dart';

void main() {
  group('TradeReport', () {
    test('supports value comparison', () {
      final now = DateTime.now();

      expect(
        TradeReport(
          timeExchange: now,
          timeCoinapi: now,
          uuid: 'uuid',
          price: 4500,
          size: 1,
          takerSide: 'SELL',
          symbolId: 'symbolId',
          sequence: 1,
          type: 'type',
        ),
        TradeReport(
          timeExchange: now,
          timeCoinapi: now,
          uuid: 'uuid',
          price: 4500,
          size: 1,
          takerSide: 'SELL',
          symbolId: 'symbolId',
          sequence: 1,
          type: 'type',
        ),
      );
    });

    group('fromJson', () {
      final json1 = fixture('trade_report_1.json');
      final json2 = fixture('trade_report_2.json');

      test('returns correct TradeReport', () {
        final tradeReport =
            TradeReport.fromJson(jsonDecode(json1) as Map<String, dynamic>);

        final tradeReport2 =
            TradeReport.fromJson(jsonDecode(json2) as Map<String, dynamic>);

        expect(tradeReport, isA<TradeReport>());
        expect(tradeReport2, isA<TradeReport>());
      });
    });

    group('toJson', () {
      final json = fixture('trade_report_2.json');

      test('returns correct json', () {
        final tradeReport =
            TradeReport.fromJson(jsonDecode(json) as Map<String, dynamic>);

        expect(jsonEncode(tradeReport.toJson()), json);
      });
    });
  });
}
