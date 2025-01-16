import 'dart:convert';

import 'package:coincap/pages/details_page.dart';
import 'package:coincap/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  HTTPService? _http;
  String? _selectedCoin = "bitcoin";

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPService>();
  }

  // Move the dataWidgets method out of the build method
  Widget _dataWidgets() {
    return FutureBuilder(
      future: _http!.get("/coins/$_selectedCoin"),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          Map _data = jsonDecode(_snapshot.data.toString());
          num _usdPrice = _data["market_data"]["current_price"]["usd"];
          num _change24h = _data["market_data"]["price_change_percentage_24h"];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _coinImageWidget(_data["image"]["large"]),
              _currentPriceWidget(_usdPrice),
              _percentageChangeWidget(_change24h),
              _descriptionCardWidget(_data["description"]["en"]),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _currentPriceWidget(num _rate) {
    return Text(
      "${_rate.toStringAsFixed(2)} USD",
      style: const TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget _percentageChangeWidget(num _change) {
    return Text(
      "${_change.toString()}%",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _coinImageWidget(String _imgURL) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext _context) {
              return DetailsPage();
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.02),
        height: _deviceHeight! * 0.15,
        width: _deviceWidth! * 0.15,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_imgURL),
          ),
        ),
      ),
    );
  }

  Widget _descriptionCardWidget(String _description) {
    return Container(
      height: _deviceHeight! * 0.45,
      width: _deviceWidth! * 0.45,
      margin: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.05,
      ),
      padding: EdgeInsets.symmetric(
          vertical: _deviceHeight! * 0.01, horizontal: _deviceHeight! * 0.01),
      color: const Color.fromRGBO(83, 88, 206, 0.5),
      child: Text(
        _description,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    Widget _selectedCoinDropdown() {
      List<String> _coins = [
      "bitcoin",
      "ethereum",
      "tether",
      "cardano",
      "ripple"];
      List<DropdownMenuItem<String>> _items = _coins
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
          .toList();
      return DropdownButton(
        value: _selectedCoin,
        items: _items,
        onChanged: (dynamic _value) {
          setState(() {
            _selectedCoin = _value;
          });
        },
        dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
        iconSize: 30,
        icon: const Icon(
          Icons.arrow_downward_sharp,
          color: Colors.white,
        ),
        underline: Container(),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF4737B8),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectedCoinDropdown(),
              _dataWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}












// FutureBuilder(
      // future: _http!.get("/coins/bitcoin"),
      // builder: (BuildContext _context, AsyncSnapshot _snapshot){
      //   if (_snapshot.hasData){
      //     Map _data = jsonDecode(_snapshot.data.toString());
      //     num _usdPrice = _data["market_data"]["current_price"]["usd"];
      //     return Text(_usdPrice.toString());
      //   }else{
      //     return const Center(child: CircularProgressIndicator(color: Colors.white),);
      //   }
      // });