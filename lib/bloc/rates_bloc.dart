import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exchange/bloc/bloc.dart';
import 'package:flutter_exchange/models/models.dart';
import 'package:flutter_exchange/repositories/exchange_repository.dart';
import 'package:rxdart/streams.dart';

part 'rates_event.dart';
part 'rates_state.dart';

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  final ExchangeRepository repo;
  final IntervalSettingBloc intervalBloc;
  final CurrencySettingBloc currencyBloc;
  
  StreamSubscription refreshSub;
  StreamSubscription dependencySub;

  RatesBloc({
    @required this.repo,
    @required this.intervalBloc,
    @required this.currencyBloc,
  })  : assert(repo != null),
        assert(intervalBloc != null),
        assert(currencyBloc != null) {

          dependencySub = CombineLatestStream.list([
            intervalBloc.asBroadcastStream(),
            currencyBloc.asBroadcastStream()
          ]).listen((dataList) {

            final intervalState = dataList.first;
            final currencyState = dataList[1];

            if (intervalState is IntervalSettingState && currencyState is CurrencySettingState) {
              add(FetchRates(currency: currencyState.currency, interval: intervalState.interval));
            }
          });

        }

  @override
  RatesState get initialState => RatesEmpty();

  @override
  Stream<RatesState> mapEventToState(
    RatesEvent event,
  ) async* {
    if (event is FetchRates) {
      yield RatesLoading();
      refreshSub?.cancel();
      try {
        final List<Rate> rates = await repo.getRatesFor(event.currency);
        yield RatesLoaded(rates: rates);
        refreshSub = Stream.periodic(Duration(seconds: event.interval), (x) => x).listen(
          (duration) => add(RefreshRates(currency: event.currency, interval: event.interval)),
        );
      } catch (_) {
        yield RatesError();
      }
    }

    if (event is RefreshRates) {
      try {
        final List<Rate> rates = await repo.getRatesFor(event.currency);
        yield RatesLoaded(rates: rates);
      } catch (_) {
        yield RatesError();
      }
    }
  }

  @override
  Future<void> close() {
    refreshSub.cancel();
    dependencySub.cancel();
    return super.close();
  }
}
