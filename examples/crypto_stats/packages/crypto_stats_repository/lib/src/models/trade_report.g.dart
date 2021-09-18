// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeReport _$TradeReportFromJson(Map<String, dynamic> json) => TradeReport(
      timeExchange: DateTime.parse(json['time_exchange'] as String),
      timeCoinapi: DateTime.parse(json['time_coinapi'] as String),
      uuid: json['uuid'] as String,
      price: (json['price'] as num).toDouble(),
      size: (json['size'] as num).toDouble(),
      takerSide: json['taker_side'] as String,
      symbolId: json['symbol_id'] as String,
      sequence: json['sequence'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$TradeReportToJson(TradeReport instance) =>
    <String, dynamic>{
      'time_exchange': instance.timeExchange.toIso8601String(),
      'time_coinapi': instance.timeCoinapi.toIso8601String(),
      'uuid': instance.uuid,
      'price': instance.price,
      'size': instance.size,
      'taker_side': instance.takerSide,
      'symbol_id': instance.symbolId,
      'sequence': instance.sequence,
      'type': instance.type,
    };
