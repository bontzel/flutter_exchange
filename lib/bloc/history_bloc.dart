import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  @override
  HistoryState get initialState => HistoryInitial();

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
