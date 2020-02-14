part of 'currency_setting_bloc.dart';

abstract class CurrencySettingEvent extends Equatable {
  const CurrencySettingEvent();
}

class CurrencySelected extends CurrencySettingEvent {
  final String currency;

  const CurrencySelected({@required this.currency}) : assert(currency != null);

  @override
  List<Object> get props => [currency];
}