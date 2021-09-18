import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'trade_report.g.dart';

enum CryptoCurrency {
  btc,
  eth,
  ada,
  other,
}

@JsonSerializable()
class TradeReport extends Equatable {
  const TradeReport({
    required this.timeExchange,
    required this.timeCoinapi,
    required this.uuid,
    required this.price,
    required this.size,
    required this.takerSide,
    required this.symbolId,
    required this.sequence,
    required this.type,
  });

  factory TradeReport.fromJson(Map<String, dynamic> json) =>
      _$TradeReportFromJson(json);
  Map<String, dynamic> toJson() => _$TradeReportToJson(this);

  @JsonKey(name: 'time_exchange')
  final DateTime timeExchange;

  @JsonKey(name: 'time_coinapi')
  final DateTime timeCoinapi;

  @JsonKey(name: 'uuid')
  final String uuid;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'size')
  final double size;

  @JsonKey(name: 'taker_side')
  final String takerSide;

  @JsonKey(name: 'symbol_id')
  final String symbolId;

  @JsonKey(name: 'sequence')
  final int sequence;

  @JsonKey(name: 'type')
  final String type;

  CryptoCurrency crytpType() {
    switch (symbolId) {
      case 'COINBASE_SPOT_BTC_USD':
        return CryptoCurrency.btc;
      case 'COINBASE_SPOT_ETH_USD':
        return CryptoCurrency.eth;
      case 'COINBASE_SPOT_ADA_USD':
        return CryptoCurrency.ada;
      default:
        return CryptoCurrency.other;
    }
  }

  @override
  List<Object?> get props => [
        timeExchange,
        timeCoinapi,
        uuid,
        price,
        size,
        takerSide,
        symbolId,
        sequence,
        type,
      ];
}
