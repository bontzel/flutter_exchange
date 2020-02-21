part of 'rates_bloc.dart';

abstract class RatesState extends Equatable {
  const RatesState();
}

class RatesEmpty extends RatesState {
   @override
  List<Object> get props => [];
}

class RatesLoading extends RatesState {
   @override
  List<Object> get props => [];
}

class RatesLoaded extends RatesState {
  final List<Rate> rates;

  const RatesLoaded({@required this.rates})
      : assert(rates != null);

  @override
  List<Object> get props => [rates];
}

class RatesError extends RatesState {
   @override
  List<Object> get props => [];
}
