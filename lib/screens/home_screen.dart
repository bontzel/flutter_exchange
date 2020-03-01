import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/bloc.dart';
import 'package:flutter_exchange/widgets/rates_list.dart';

import '../routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Exchange'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Settings',
            onPressed: () {
              Navigator.pushNamed(context, Routes.settings);
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Show History',
            onPressed: () {
              final currency = BlocProvider.of<CurrencySettingBloc>(context).state.currency;
              BlocProvider.of<HistoryBloc>(context).add(FetchHistory(baseCurrency: currency));
              Navigator.pushNamed(context, Routes.charts);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder<CurrencySettingBloc, CurrencySettingState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      state.currency,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<RatesBloc, RatesState>(
            builder: (context, state) {
              if (state is RatesLoaded) {
                final date = DateTime.now();

                return Text('Updated at: $date');
              } else {
                return Text('Updated never.');
              }
            },
          ),
          Expanded(
            child: RatesList(),
          )
        ],
      ),
    );
  }
}
