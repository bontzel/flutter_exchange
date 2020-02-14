import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/bloc.dart';
import 'package:flutter_exchange/bloc/interval_setting_bloc.dart';
import 'package:flutter_exchange/repositories/exchange_api_client.dart';
import 'package:flutter_exchange/repositories/exchange_repository.dart';
import 'package:flutter_exchange/widgets/rates_list.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencySettingBloc, CurrencySettingState>(
      builder: (context, state) {
        final currencyState = state;
        return BlocBuilder<IntervalSettingBloc, IntervalSettingState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Flutter Exchange'),
              ),
              body: BlocProvider(
                create: (context) => RatesBloc(
                  interval: state.interval,
                  currency: currencyState.currency,
                  repo: ExchangeRepository(
                    client: ExchangeAPIClient(
                      httpClient: http.Client(),
                    ),
                  ),
                )..add(
                    FetchRates(currency: currencyState.currency),
                  ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[Text(currencyState.currency)],
                    ),
                    Expanded(
                      child: RatesList(),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
