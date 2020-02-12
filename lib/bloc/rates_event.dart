part of 'rates_bloc.dart';

abstract class RatesEvent extends Equatable {
  const RatesEvent();
}

class FetchRates extends RatesEvent {
  final String currency;

  const FetchRates({@required this.currency}) : assert(currency != null);

  @override
  List<Object> get props => [currency];
}

class RefreshRates extends RatesEvent {
  final String currency;

  const RefreshRates({@required this.currency}) : assert(currency != null);

  @override
  List<Object> get props => [currency];
}