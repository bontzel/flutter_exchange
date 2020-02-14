import 'dart:convert';

import 'package:flutter_exchange/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ExchangeAPIClient {
  static const baseURL = 'https://api.exchangeratesapi.io';
  final http.Client httpClient;

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

    for (var key in ratesMap.keys) {
      modelArray.add(Rate(
        currency: key,
        value: ratesMap[key],
      ));
    }
    return modelArray;
  }
}
