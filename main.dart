import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Uso da API retorna valor do bitcoin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _precoE = "0";
  String _precoD = "0";
  _buscaPrecoE() async {
    String urlAPI = "https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL,BTC-BRL";
    http.Response response;
    response = await http.get(urlAPI);
    Map<String, dynamic> retorno = json.decode(response.body);
    print(retorno);
    print(retorno["EURBRL"]["high"].toString());

    _precoE = retorno["EURBRL"]["high"].toString();
    print(retorno);
    print(retorno["USDBRL"]["high"].toString());
    setState(() {
      _precoE = retorno["USDBRL"]["high"].toString();
    });
  }

  _buscaPrecoD() async {
    String urlAPI = "https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL,BTC-BRL";
    http.Response response;
    response = await http.get(urlAPI);
    Map<String, dynamic> retorno = json.decode(response.body);
    print(retorno);
    print(retorno["USDBRL"]["high"].toString());
    setState(() {
      _precoD = retorno["USDBRL"]["high"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assessment, size: 100.0, color: Colors.greenAccent),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "Dolar em real " + _precoD + "Dolar em euro:" + _precoE,
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            RaisedButton(
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Text("Atualizar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
                onPressed: _buscaPrecoD),
            RaisedButton(
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Text("Atualizar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
                onPressed: _buscaPrecoE),
          ],
        ),
      ),
    ));
  }
}
