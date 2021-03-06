import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/simple_bloc_delegate.dart';
import 'package:flutter_exchange/repositories/exchange_api_client.dart';
import 'package:http/http.dart' as http;

import 'bloc/bloc.dart';
import 'repositories/repos.dart';
import 'routes.dart';
import 'screens/screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final repo = ExchangeRepository(
    client: ExchangeAPIClient(
      httpClient: http.Client(),
    ),
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CurrencySettingBloc>(
        create: (context) =>
            CurrencySettingBloc()..add(CurrencySelected(currency: "EUR")),
      ),
      BlocProvider<IntervalSettingBloc>(
        create: (context) =>
            IntervalSettingBloc()..add(IntervalSelected(interval: 3)),
      ),
      BlocProvider<RatesBloc>(
        create: (context) => RatesBloc(
          currencyBloc: BlocProvider.of<CurrencySettingBloc>(context),
          intervalBloc: BlocProvider.of<IntervalSettingBloc>(context),
          repo: repo,
        ),
      ),
      BlocProvider<HistoryBloc>(
        create: (context) => HistoryBloc(
          currencyBloc: BlocProvider.of<CurrencySettingBloc>(context),
          repo: repo,
        ),
      )
    ],
    child: ExchangeApp(),
  ));
}

class ExchangeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      title: "Flutter Exchange",
      routes: {
        Routes.settings: (context) {
          return SettingsScreen();
        },
        Routes.charts: (context) {
          return ChartsScreen();
        }
      },
    );
  }
}
