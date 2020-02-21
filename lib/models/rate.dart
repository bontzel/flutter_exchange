import 'package:equatable/equatable.dart';

class Rate extends Equatable {
  final String currency;
  final double value;

  const Rate ({
    this.currency,
    this.value
  });

  @override
  List<Object> get props => [currency, value];

  static Rate fromJson(Map json) {
    var rate;
    for (var key in json.keys) {
      rate = Rate(
        currency: key,
        value: json[key]
      );
    }

    return rate;
  }

}