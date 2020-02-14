part of 'interval_setting_bloc.dart';

abstract class IntervalSettingEvent extends Equatable {
  const IntervalSettingEvent();
}

class IntervalSelected extends IntervalSettingEvent {
  final int interval;

  const IntervalSelected({@required this.interval}) : assert(interval != null);

  @override
  List<Object> get props => [interval];
}