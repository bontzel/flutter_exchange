
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/bloc.dart';
import 'package:flutter_exchange/widgets/evolution_chart.dart';

class ChartsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Widget> charts = List<Widget>();

    if(BlocProvider.of<CurrencySettingBloc>(context).state.currency != "EUR") {
      charts.add(EvolutionChart(targetCurrency: "EUR"));
    }
    if(BlocProvider.of<CurrencySettingBloc>(context).state.currency != "RON") {
      charts.add(EvolutionChart(targetCurrency: "RON"));
    }
    if(BlocProvider.of<CurrencySettingBloc>(context).state.currency != "BGN") {
      charts.add(EvolutionChart(targetCurrency: "BGN"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: charts.length,
        itemBuilder:  (BuildContext context, int index) {
          return charts[index];
      }),
    );

  }

}