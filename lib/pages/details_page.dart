import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map rates;
  const DetailsPage({Key? key, required this.rates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  List  _currencies = rates.keys.toList();
  List _exchangeRates = rates.values.toList();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(83, 88, 206, 0.5),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _currencies.length,
          itemBuilder: (context, index) {
            String currency = _currencies[index].toString().toUpperCase();
            String exchangeRate = _exchangeRates[index].toString();
            return ListTile(
              title: Text("$currency: $exchangeRate", style: TextStyle(color: Colors.white),),
            );
          },
        ),
      ),
    );
  }
}