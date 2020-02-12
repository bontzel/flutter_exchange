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

  RatesBloc({@required this.repo}) : assert(repo != null);

  @override
  RatesState get initialState => RatesEmpty();

  @override
  Stream<RatesState> mapEventToState(
    RatesEvent event,
  ) async* {
    if (event is FetchRates) {
      yield RatesLoading();
      try {
        final List<Rate> rates = await repo.getRatesFor(event.currency);
        yield RatesLoaded(rates: rates);
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
}
