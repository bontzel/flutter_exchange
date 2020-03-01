import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RateSeries extends Equatable implements Comparable {
  final DateTime day;
  final double value;

  RateSeries({@required this.day, @required this.value});

  @override
  List<Object> get props => [day, value];

  static List<RateSeries> fromJson(Map json, String forCurrency) {
    Map rates = json["rates"];
    List<RateSeries> seriesList = List<RateSeries>();

    for (String day in rates.keys) {
      DateTime date = DateTime.parse(day);
      seriesList.add(RateSeries(day: date, value: rates[forCurrency]));
    }

    return seriesList;
  }

  @override
  int compareTo(other) {
    return day.compareTo(other.day);
  }
}
