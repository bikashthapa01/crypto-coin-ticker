import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.price,
    required this.selectedCur,
    required this.cryptoCurrency,
  }) : super(key: key);

  final String? price;
  final String selectedCur;
  final String cryptoCurrency;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '1 $cryptoCurrency = $price $selectedCur',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      color: Colors.blueAccent,
    );
  }
}
