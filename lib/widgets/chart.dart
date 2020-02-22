import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exchange/models/models.dart';

class Chart extends StatelessWidget {
  final String targetCurrency;
  final List<RateSeries> dataSource;

  Chart({
    @required this.targetCurrency,
    @required this.dataSource,
  });

  @override
  Widget build(BuildContext context) {
    List<Series<RateSeries, DateTime>> series = [
      Series(
        id: targetCurrency,
        data: dataSource,
        domainFn: (RateSeries series, _) => series.day,
        measureFn:  (RateSeries series, _) => series.value,
        ),
    ];

    return LineChart(series);
  }
}
