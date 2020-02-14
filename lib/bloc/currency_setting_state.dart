part of 'currency_setting_bloc.dart';

class CurrencySettingState extends Equatable {
  final String currency;

  const CurrencySettingState({@required this.currency}) : assert(currency != null);

  @override
  List<Object> get props => [currency];
}
