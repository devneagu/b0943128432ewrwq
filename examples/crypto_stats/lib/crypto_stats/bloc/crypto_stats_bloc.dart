import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_stats_repository/crypto_stats_repository.dart';
import 'package:equatable/equatable.dart';

part 'crypto_stats_event.dart';
part 'crypto_stats_state.dart';

class CryptoStatsBloc extends Bloc<CryptoStatsEvent, CryptoStatsState> {
  CryptoStatsBloc({
    required CryptoStatsRepository cryptoStatsRepository,
  })  : _repository = cryptoStatsRepository,
        super(CryptoStatsInitial()) {
    tradeReportsSubscription = _repository.tradeReportStream.listen((event) {
      add(CryptoStatsTradeUpdated(event));
    }, onError: (dynamic _, dynamic __) {
      // handle error
    });

    on<CryptoStatsSocketConnected>(_onSocketConnected);
    on<CryptoStatsTradeUpdated>(_onTradeUpdated);
  }

  final CryptoStatsRepository _repository;

  late StreamSubscription<TradeReport> tradeReportsSubscription;

  Future<void> _onSocketConnected(
    CryptoStatsSocketConnected event,
    Emitter<CryptoStatsState> emit,
  ) async {
    try {
      await _repository.initializeWS();
    } catch (e) {
      // hanlde catch
    }
  }

  void _onTradeUpdated(
    CryptoStatsTradeUpdated event,
    Emitter<CryptoStatsState> emit,
  ) {
    if (state is CryptoStatsData) {
      final stats =
          Map<String, TradeReport>.from((state as CryptoStatsData).stats);
      stats[event.tradeReport.symbolId] = event.tradeReport;
      emit(CryptoStatsData(stats: stats));
    } else {
      emit(
        CryptoStatsData(stats: {
          event.tradeReport.symbolId: event.tradeReport,
        }),
      );
    }
  }

  @override
  Future<void> close() {
    tradeReportsSubscription.cancel();
    return super.close();
  }
}
