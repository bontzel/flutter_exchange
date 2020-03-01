import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exchange/models/models.dart';

class Chart extends StatelessWidget {
  final String targetCurrency;
  final List<RateSeries> dataSource;

  Chart({
    @required this.targetCurrency,
    @required this.dataSource,
  }) : assert(dataSource != null);

  @override
  Widget build(BuildContext context) {

    dataSource.sort();

    RateSeries min = dataSource.reduce( (item1, item2) {
      return item1.value < item2.value ? item1 : item2;
    });

    RateSeries max = dataSource.reduce( (item1, item2) {
      return item1.value > item2.value ? item1 : item2;
    });


    List<Series<RateSeries, String>> series = [
      Series(
        id: targetCurrency,
        data: dataSource,
        domainFn: (RateSeries series, index) => series.day.day.toString(),
        measureFn:  (RateSeries series, _) => series.value,
        measureUpperBoundFn: (RateSeries series, _) => max.value,
        measureLowerBoundFn: (RateSeries series, _) => min.value
        ),
    ];

    return BarChart(series);
  }
}
