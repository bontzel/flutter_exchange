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
}
