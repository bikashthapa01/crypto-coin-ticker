import 'dart:io' show Platform;

import 'package:crypto_app/coin_data.dart';
import 'package:crypto_app/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'componenets/crypto_card.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  String selectedCur = 'USD';
  String price = '0.00';
  bool isWaiting = true;
  double value = 0.0;

  DropdownButton<String> androidDropdownPicker() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      items.add(item);
    }
    return DropdownButton<String>(
      value: selectedCur,
      items: items,
      onChanged: (value) {
        setState(() {
          selectedCur = value!;
          getCurrencyData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> items = [];

    for (String currency in currenciesList) {
      var item = Text(currency);
      items.add(item);
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (value) {
          selectedCur = currenciesList[value];
          getCurrencyData();
        },
        children: items);
  }
  // check which os is running to select different picker based on OS

  Widget? getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdownPicker();
    }
  }

  // fetch json data
  Map<String, String> coinPrices = {};
  void getCurrencyData() async {
    NetworkModel networkModel = NetworkModel();
    isWaiting = true;
    var data = await networkModel.getApiData(selectedCur);
    isWaiting = false;
    setState(() {
      coinPrices = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Ticker'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CryptoCard(
                    cryptoCurrency: 'BTC',
                    price: isWaiting ? '?' : coinPrices['BTC'],
                    selectedCur: selectedCur),
                CryptoCard(
                    cryptoCurrency: 'ETH',
                    price: isWaiting ? '?' : coinPrices['ETH'],
                    selectedCur: selectedCur),
                CryptoCard(
                    cryptoCurrency: 'LTC',
                    price: isWaiting ? '?' : coinPrices['LTC'],
                    selectedCur: selectedCur),
              ],
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 20.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropdownPicker(),
            )
          ],
        ),
      ),
    );
  }
}
