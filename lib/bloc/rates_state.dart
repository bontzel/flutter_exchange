part of 'rates_bloc.dart';

abstract class RatesState extends Equatable {
  const RatesState();

  @override
  List<Object> get props => [];
}

class RatesEmpty extends RatesState {}

class RatesLoading extends RatesState {}

class RatesLoaded extends RatesState {
  final List<Rate> rates;

  const RatesLoaded({@required this.rates})
      : assert(rates != null);

  @override
  List<Object> get props => [rates];
}

class RatesError extends RatesState {}
