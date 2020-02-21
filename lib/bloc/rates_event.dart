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
  final DateTime timestamp;

  const RefreshRates({@required this.currency, this.interval, @required this.timestamp}) : assert(currency != null);

  @override
  List<Object> get props => [currency, timestamp];

  @override
  String toString() {
  return 'Refresh rates for $interval at $timestamp';
   }
}