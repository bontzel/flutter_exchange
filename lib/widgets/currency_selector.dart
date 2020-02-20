import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/bloc.dart';

class CurrencySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencySettingBloc, CurrencySettingState>(
      builder: (context, state) {
        final currency = state.currency;
        final dataSource =
            BlocProvider.of<RatesBloc>(context).getAllCurrencies();

        return ListView.builder(
            itemCount: dataSource.length,
            itemBuilder: (BuildContext context, int index) {
              final text = dataSource[index];

              return ListTile(
                leading: currency == text ? Icon(Icons.check) : null,
                title: Text(text),
                onTap: () => BlocProvider.of<CurrencySettingBloc>(context)
                    .add(CurrencySelected(currency: text)),
              );
            });
      },
    );
  }
}
