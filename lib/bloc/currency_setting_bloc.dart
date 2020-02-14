import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'currency_setting_event.dart';
part 'currency_setting_state.dart';

class CurrencySettingBloc extends Bloc<CurrencySettingEvent, CurrencySettingState> {
  @override
  CurrencySettingState get initialState => CurrencySettingState(currency: "EUR");

  @override
  Stream<CurrencySettingState> mapEventToState(
    CurrencySettingEvent event,
  ) async* {
    if (event is CurrencySelected) {
      yield CurrencySettingState(currency: event.currency);
    }
  }
}
