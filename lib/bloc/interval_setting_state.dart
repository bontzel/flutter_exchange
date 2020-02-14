part of 'interval_setting_bloc.dart';

class IntervalSettingState extends Equatable {
  final int interval;

  const IntervalSettingState({@required this.interval}) : assert(interval != null);

  @override
  List<Object> get props => [interval];
}
