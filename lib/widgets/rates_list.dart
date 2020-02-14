import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/bloc.dart';
import 'package:flutter_exchange/widgets/loading_indicator.dart';
import 'package:flutter_exchange/widgets/rates_item.dart';


class RatesList extends StatelessWidget {
  RatesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatesBloc, RatesState>(
      builder: (context, state) {
        if (state is RatesLoading) {
          return LoadingIndicator();
        } else if (state is RatesLoaded) {
          final rates = state.rates;
          return ListView.builder(
            itemCount: rates.length,
            itemBuilder: (BuildContext context, int index) {
              final rateItem = rates[index];

              return RatesItem(rate: rateItem);
             });
        } else {
          return Container(
            child: Text("no rates loaded."),
          );
        }
      },
    );
  }
}