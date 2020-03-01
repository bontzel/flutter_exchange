part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class FetchHistory extends HistoryEvent {
  final String baseCurrency;

  FetchHistory({
    @required this.baseCurrency,
  }) : assert(baseCurrency != null);

  @override
  List<Object> get props => [baseCurrency];

}
