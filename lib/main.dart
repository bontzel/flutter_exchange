
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/simple_bloc_delegate.dart';
import 'package:flutter_exchange/screens/home_screen.dart';

import 'bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CurrencySettingBloc>(
        create: (context) => CurrencySettingBloc(),
      ),
      BlocProvider<IntervalSettingBloc>(
        create: (context) => IntervalSettingBloc(),
      ),
    ],
    child: ExchangeApp(),
  ));
}

class ExchangeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Exchange",
      routes: {
        "/": (context) {
          return HomeScreen();
        }
      },
    );
  }
}
