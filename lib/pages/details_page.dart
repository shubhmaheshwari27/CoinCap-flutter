import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map rates;
  const DetailsPage({Key? key, required this.rates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _currencies = rates.keys.toList();
    List _exchangeRates = rates.values.toList();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(83, 88, 206, 0.9),
      appBar: AppBar(
        title: const Text('Exchange Rates'),
        backgroundColor: const Color.fromRGBO(83, 88, 206, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pops the current screen and goes back
          },
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _currencies.length,
          itemBuilder: (context, index) {
            String currency = _currencies[index].toString().toUpperCase();
            String exchangeRate = _exchangeRates[index].toString();
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  "$currency: $exchangeRate",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
