part of 'crypto_stats_bloc.dart';

abstract class CryptoStatsEvent extends Equatable {
  const CryptoStatsEvent();

  @override
  List<Object> get props => [];
}

class CryptoStatsSocketConnected extends CryptoStatsEvent {
  const CryptoStatsSocketConnected();
}

class CryptoStatsTradeUpdated extends CryptoStatsEvent {
  const CryptoStatsTradeUpdated(this.tradeReport);

  final TradeReport tradeReport;

  @override
  List<Object> get props => [tradeReport];
}
