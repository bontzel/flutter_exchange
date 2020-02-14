import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exchange/models/models.dart';
import 'package:flutter_exchange/repositories/exchange_repository.dart';

part 'rates_event.dart';
part 'rates_state.dart';

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  final ExchangeRepository repo;
  final int interval;
  final String currency;
  StreamSubscription sub;
  // Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)

  RatesBloc({
    @required this.repo,
    @required this.interval,
    @required this.currency,
  })  : assert(repo != null),
        assert(interval != null),
        assert(currency != null);

  @override
  RatesState get initialState => RatesEmpty();

  @override
  Stream<RatesState> mapEventToState(
    RatesEvent event,
  ) async* {
    if (event is FetchRates) {
      yield RatesLoading();
      sub?.cancel();
      try {
        final List<Rate> rates = await repo.getRatesFor(event.currency);
        yield RatesLoaded(rates: rates);
        sub = Stream.periodic(Duration(seconds: interval), (x) => x).listen(
          (duration) => add(RefreshRates(currency: currency)),
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
    sub.cancel();
    return super.close();
  }
}
