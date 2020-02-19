part of 'rates_bloc.dart';

abstract class RatesEvent extends Equatable {
  const RatesEvent();
}

class FetchRates extends RatesEvent {
  final String currency;
  final int interval;

  const FetchRates({@required this.currency, @required this.interval}) : assert(currency != null);

  @override
  List<Object> get props => [currency];
}

class RefreshRates extends RatesEvent {
  final String currency;
  final int interval;

  const RefreshRates({@required this.currency, this.interval}) : assert(currency != null);

  @override
  List<Object> get props => [currency];

  @override
  String toString() {
  return 'Refresh rates for $interval';
   }
}