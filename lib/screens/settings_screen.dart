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
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[IntervalSelector()],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Select base currency:')],
          ),
          Expanded(
            child: CurrencySelector(),
          ),
        ],
      ),
    );
  }
}
