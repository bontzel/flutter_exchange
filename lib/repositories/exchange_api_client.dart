import 'dart:convert';
import 'dart:math';

import 'package:flutter_exchange/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ExchangeAPIClient {
  static const baseURL = 'https://api.exchangeratesapi.io';
  final http.Client httpClient;
  List<String> currencies = List<String>();

  ExchangeAPIClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Rate>> getRatesFor(String baseCurrency) async {
    final ratesURL = '$baseURL/latest?base=$baseCurrency';
    final ratesResponse = await this.httpClient.get(ratesURL);
    if (ratesResponse.statusCode != 200) {
      throw Exception('error getting rate for $baseCurrency');
    }

    final ratesJson = jsonDecode(ratesResponse.body) as Map;
    final ratesMap = ratesJson["rates"] as Map;
    var modelArray = List<Rate>();

    currencies = List<String>();
    for (var key in ratesMap.keys) {
      currencies.add(key);
      modelArray.add(Rate(
        currency: key,
        value: ratesMap[key],
      ));
    }
    modelArray.add(Rate(currency: "XXX", value: Random().nextDouble()));
    currencies.add("EUR");
    return modelArray;
  }
}
