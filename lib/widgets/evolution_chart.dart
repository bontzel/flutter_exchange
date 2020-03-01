import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/bloc.dart';
import 'package:flutter_exchange/widgets/chart.dart';
import 'package:flutter_exchange/widgets/loading_indicator.dart';

class EvolutionChart extends StatelessWidget {
  final String targetCurrency;

  EvolutionChart({
    @required this.targetCurrency,
  }) : assert(targetCurrency != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
          title: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                targetCurrency,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              )),
          BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return LoadingIndicator();
              }
              if (state is HistoryLoaded) {
                return Container(
                    height: 250,
                    width: 400,
                    padding: EdgeInsets.all(10),
                    child: Chart(
                        targetCurrency: targetCurrency,
                        dataSource: state.chartsData[targetCurrency]));
              }
            },
          )
        ],
      ),
    );
  }
}
