import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exchange/widgets/currency_selector.dart';
import 'package:flutter_exchange/widgets/interval_selector.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[IntervalSelector()],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[Text('Select base currency:')],
            ),
          ),
          Expanded(
            child: CurrencySelector(),
          ),
        ],
      ),
    );
  }
}
