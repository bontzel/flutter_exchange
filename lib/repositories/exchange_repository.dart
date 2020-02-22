import 'package:flutter_exchange/models/models.dart';
import 'package:meta/meta.dart';
import 'package:flutter_exchange/repositories/exchange_api_client.dart';

class ExchangeRepository {
  final ExchangeAPIClient client;

  ExchangeRepository({@required this.client}) : assert(client != null);

  Future<List<Rate>> getRatesFor(String currency) async {
    return await client.getRatesFor(currency);
  }

  List<String> getAllCurrencies() {
    return client.currencies;
  }

  Future<Map<String, RateSeries>> getEvoAgainstEURBGNRONFor(String baseCurrency) async {

    Map json = await client.getLast5DaysFor(baseCurrency);

    Map<String, RateSeries> model = Map<String, RateSeries>();

    final rates = json["rates"] as Map;

    for (String day in rates.keys) {
      DateTime date = DateTime.parse(day);

      for (String currency in rates[day].keys) {
        final ratesForDate = rates[day] as Map;
        switch (currency) {
          case "RON":
          case "BGN":
          case "EUR":
            model[currency] =
                RateSeries(day: date, value: ratesForDate[currency]);
            break;
          default:
        }
      }
    }

    return model;
  }


}
