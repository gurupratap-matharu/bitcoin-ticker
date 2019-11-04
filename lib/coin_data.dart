import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitCoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  Future getCoinData(String currency) async {
    String requestURL = '$bitCoinAverageURL/BTC$currency';
    http.Response response = await http.get(requestURL);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      var lastPrice = decodedData['last'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the GET request';
    }
  }
}
