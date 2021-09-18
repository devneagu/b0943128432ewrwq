part of 'crypto_stats_bloc.dart';

abstract class CryptoStatsState extends Equatable {
  const CryptoStatsState();

  @override
  List<Object> get props => [];
}

class CryptoStatsInitial extends CryptoStatsState {}

class CryptoStatsData extends CryptoStatsState {
  const CryptoStatsData({
    required this.stats,
  });

  final Map<String, TradeReport> stats;

  @override
  List<Object> get props => [stats];
}
