import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'components.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String bitcoinValue = '?';
  String ethereumValue = '?';
  String litecoinValue = '?';
  String selectedCurrency = 'USD';

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropDownItems.add(newItem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          bitcoinValue = '?';
          ethereumValue = '?';
          litecoinValue = '?';
          getCoinData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.grey.shade900,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          bitcoinValue = '?';
          ethereumValue = '?';
          litecoinValue = '?';
          getCoinData();
        });
      },
      children: pickerItems,
    );
  }

  Future<void> getCoinData() async {
    try {
      List cryptoValues =
          await CoinData().getCoinData(currency: selectedCurrency);
      setState(() {
        bitcoinValue = cryptoValues[0].toStringAsFixed(0);
        ethereumValue = cryptoValues[1].toStringAsFixed(0);
        litecoinValue = cryptoValues[2].toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCoinData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CurrencyCard(
            crypto: 'BTC',
            bitcoinValue: bitcoinValue,
            selectedCurrency: selectedCurrency,
          ),
          CurrencyCard(
            crypto: 'ETH',
            bitcoinValue: ethereumValue,
            selectedCurrency: selectedCurrency,
          ),
          CurrencyCard(
            crypto: 'LTC',
            bitcoinValue: litecoinValue,
            selectedCurrency: selectedCurrency,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.grey.shade900,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
