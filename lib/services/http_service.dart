import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:aloteq/crypto_model.dart';


class Httpservice{
  static const String url = 'https://data.messari.io/api/v2/assets?fields=name,symbol,metrics/market_data/price_usd';




  List<Crypto> parseCryptos(String responseBody){
    final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();

    return parsed.map<Crypto>((json) => Crypto.fromJson(json)).toList();
  }

  Future<List<Crypto>> getCryptos() async{
     final response = await http.get(Uri.parse(url));
     print(response.body);
     return compute(parseCryptos,response.body);
     }


}