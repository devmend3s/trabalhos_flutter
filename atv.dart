import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    TextEditingController _controllerCEP = TextEditingController();
    String _rua = "";
    String _lagradouro = "";
    String _complemento = "";
    String _bairro = "";
    String _cidade = "";
    String _estado = "";



  _recupera_cep() async {
    String meu_cep = _controllerCEP.text;
    String url = "https://viacep.com.br/ws/${meu_cep}/json/";
    http.Response response;
    response = await http.get(url);
    print("resposta: "+ response.body);

    Map<String, dynamic> retorno = json.decode( response.body );
    String lagradouro = retorno["logradouro"];


    String complemento = retorno["complemento"];


    String bairro = retorno["bairro"];


    String cidade = retorno["localidade"];


    String estado = retorno["uf"];



  setState(() {
   _rua = "${lagradouro}";
   _lagradouro = "${complemento}";
   _bairro = "${bairro}";
   _cidade = "${cidade}";
   _estado = "${estado}";

  });







  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:  Text(
        "Consumo de API - CEP"
      ),
      ),
      body: Container(

        padding: EdgeInsets.all(35)
        ,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Digite o CEP:"
            ),
            style: TextStyle(
              fontSize: 25,
            ),
            controller: _controllerCEP,
          ),
         Text("Rua: "+_rua),

            Padding(padding: EdgeInsets.only(left: 100),
              child: Text("Complemento: "+_complemento),
            ),
            Padding(padding: EdgeInsets.only(left: 100),
              child: Text("Bairro: "+_bairro),
            ), Padding(padding: EdgeInsets.only(left: 100),
              child: Text("Cidade: "+_cidade),
            ),
            Padding(padding: EdgeInsets.only(left: 100),
              child: Text("UF: "+_estado),
            ),


            Padding(padding: EdgeInsets.only(bottom: 200),
                child:  RaisedButton(
                  onPressed: _recupera_cep,
                  child: Text("Clique aqui!"),
                )
                  ),



          ],

        ),

      ),
      backgroundColor: Colors.blue[200],
    );
  }
}