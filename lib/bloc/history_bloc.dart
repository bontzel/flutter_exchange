import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_exchange/models/models.dart';
import 'package:flutter_exchange/repositories/repos.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {

  final ExchangeRepository repo;
  final CurrencySettingBloc currencyBloc;
  
  StreamSubscription currencySub;

  HistoryBloc({
    @required this.repo,
    @required this.currencyBloc,
  })  : assert(repo != null),
        assert(currencyBloc != null) {

          currencySub = currencyBloc.listen((state) {
            if (state is CurrencySelected) {
              add(FetchHistory(baseCurrency: state.currency));
            }
          });
        }

  @override
  HistoryState get initialState => HistoryEmpty();

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is FetchHistory) {
      yield HistoryLoading();

      Map data = await repo.getEvoAgainstEURBGNRONFor(event.baseCurrency);

      yield HistoryLoaded(chartsData: data);
    }
  }

  @override
  Future<void> close() {
    currencySub.cancel();
    return super.close();
  }
}
