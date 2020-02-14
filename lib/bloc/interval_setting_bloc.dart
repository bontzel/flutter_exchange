import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'interval_setting_event.dart';
part 'interval_setting_state.dart';

class IntervalSettingBloc extends Bloc<IntervalSettingEvent, IntervalSettingState> {
  @override
  IntervalSettingState get initialState => IntervalSettingState(interval: 3);

  @override
  Stream<IntervalSettingState> mapEventToState(
    IntervalSettingEvent event,
  ) async* {
    if (event is IntervalSelected) {
      yield  IntervalSettingState(interval: event.interval);
    }
  }
}
