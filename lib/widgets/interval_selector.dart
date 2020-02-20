import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exchange/bloc/bloc.dart';

class IntervalSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntervalSettingBloc, IntervalSettingState>(
      builder: (context, state) {
        final interval = state.interval;

        return Center(
          child: RaisedButton(
            onPressed: () async {
              final interval = await showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: Text('Interval Selection'),
                      actions: <Widget>[
                        casaIn(context, '3 seconds', isDefaultAction: true),
                        casaIn(context, '5 seconds', returnValue: 5),
                        casaIn(context, '10 seconds', returnValue: 10)
                      ],
                    );
                  });

              BlocProvider.of<IntervalSettingBloc>(context)
                  .add(IntervalSelected(interval: interval));
            },
            child: Text('Interval: $interval seconds'),
          ),
        );
      },
    );
  }

  CupertinoActionSheetAction casaIn(BuildContext context, String text,
      {bool isDefaultAction = false, int returnValue = 3}) {
    return CupertinoActionSheetAction(
      onPressed: () {
        Navigator.of(context).pop(returnValue);
      },
      child: Text(text),
      isDefaultAction: isDefaultAction,
    );
  }
}
