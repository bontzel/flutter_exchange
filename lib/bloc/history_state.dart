part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryEmpty extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final Map<String, List<RateSeries>> chartsData;

  HistoryLoaded({
    @required this.chartsData
  }) : assert (chartsData != null && chartsData.isNotEmpty);

}
