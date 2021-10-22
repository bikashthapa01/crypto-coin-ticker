import 'dart:convert';

import 'package:crypto_app/coin_data.dart';
import 'package:crypto_app/constant/constant.dart';
import 'package:http/http.dart' as http;

class NetworkModel {
  Future<dynamic> getApiData(String selectedCurrency) async {
    Map<String, String> prices = {};
    for (String crypto in cryptoList) {
      String url = apiURL + '$crypto/$selectedCurrency/?apikey=' + apiKey;
      http.Response responseData = await http.get(Uri.parse(url));
      if (responseData.statusCode == 200) {
        var response = jsonDecode(responseData.body);
        double cryptoPrice = response['rate'];
        prices[crypto] = cryptoPrice.toStringAsFixed(2);
      } else {
        throw ('Error in Fetching data');
      }
    }
    return prices;
  }
}
