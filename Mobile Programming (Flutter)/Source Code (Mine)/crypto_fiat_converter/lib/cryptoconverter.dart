import 'dart:convert';
import 'package:flutter/material.dart';
import 'crypto.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CryptoConverterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Crypto Converter'),
          backgroundColor: Colors.greenAccent,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 200,
                child: Center(
                  child: Image.asset('assets/images/Crypto Converter Logo.png',
                      scale: 4),
                )),
            Container(height: 300, child: CryptoConverter()),
          ]),
        ),
      ),
    );
  }
}

class CryptoConverter extends StatefulWidget {
  const CryptoConverter({Key? key}) : super(key: key);
 

  @override
  State<CryptoConverter> createState() => _CryptoConverterState();
}

class _CryptoConverterState extends State<CryptoConverter> {
  String selectedCrypto = "btc", description = "No information";
  Crypto curCrypto =
      Crypto("Not Availabe", "Not Avaliable", 0.0, "Not Avaliable");
  var currencyName, unit, value, type;
  List<String> cryptoList = [
    "btc","eth","ltc","bch","bnb","eos","xrp","xlm","link","dot","yfi",
    "usd","aed","ars","bdt","bhd","bmd","brl","cad","chf","clp","cny","czk","dkk","eur","gbp","hkd","huf",
    "idr","ils","inr","jpy","krw","kwd","lkr","mmk","mxn","myr","ngn","nok","nzd","php","pkr","pln",
    "rub","sar","sek","sgd","thb","try","twd","uah","vef","vnd","zar","xdr","xag","xau","bits","sats",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          children: [
            const Text(
              "Please Select:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              itemHeight: 60,
              value: selectedCrypto,
              onChanged: (newValue) {
                setState(() {
                  selectedCrypto = newValue.toString();
                });
              },
              items: cryptoList.map((selectLoc) {
                return DropdownMenuItem(
                  child: Text(
                    selectLoc,
                  ),
                  value: selectLoc,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _loadCryptoValue,
                child: const Text("CONVERT"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ],
        )));
  
  }

  Future<void> _loadCryptoValue() async {
    ProgressDialog progressDialog = new ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Converting....."));
    progressDialog.show();

    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      setState(() {
        currencyName = parsedData['rates'][selectedCrypto]['name'];
        unit = parsedData['rates'][selectedCrypto]['unit'];
        value = parsedData['rates'][selectedCrypto]['value'];
        type = parsedData['rates'][selectedCrypto]['type'];
        curCrypto = Crypto(currencyName, unit, value, type);
      });
      progressDialog.dismiss();
      Fluttertoast.showToast(
          msg: "Converted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }
}

class CryptoGrid extends StatefulWidget {
  final Crypto curCrypto;
  const CryptoGrid({Key? key, required this.curCrypto}) : super(key: key);

  @override
  State<CryptoGrid> createState() => _CryptoGridState();
}

class _CryptoGridState extends State<CryptoGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Currency Name"),
              const Icon(
                Icons.fact_check_rounded,
                size: 64,
              ),
              Text(widget.curCrypto.currencyName)
            ],
          ),
          color: Colors.greenAccent,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Unit"),
              const Icon(
                Icons.currency_exchange_sharp,
                size: 64,
              ),
              Text(widget.curCrypto.unit)
            ],
          ),
          color: Colors.greenAccent,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Value"),
              const Icon(
                Icons.attach_money,
                size: 64,
              ),
              Text(widget.curCrypto.value.toString()),
            ],
          ),
          color: Colors.greenAccent,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Type"),
              const Icon(
                Icons.loop_outlined,
                size: 64,
              ),
              Text(widget.curCrypto.type)
            ],
          ),
          color: Colors.greenAccent,
        ),
      ],
    );
  }
  
}
