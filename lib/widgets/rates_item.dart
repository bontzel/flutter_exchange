import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exchange/models/models.dart';

class RatesItem extends StatelessWidget {
  final Rate rate;

  RatesItem({
    Key key,
    @required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(rate.currency),
      title: Text(this.rate.value.toString()),
    );
  }
}