import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:ppob/models/pricelist.dart';
const String username = "083153342584";
const String apiKey = "771685d33ba36452yYfw";

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api';
  final String baseUrlIAK = "https://prepaid.iak.dev/api";

  String createReferenceID() {
    final random = Random().nextInt(10000);
    final orderID = 'Order-$random';

    return orderID;
  }

  Future<List<Pricelist>> getAllPriceList(String type, String operator)async{
    try{
      final response = await http.post(Uri.parse('$baseUrl/pricelist'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "type": type,
        "operator": operator,
      }));

      if(response.statusCode == 200){
        final List<dynamic> data = json.decode(response.body)['data']['data']['pricelist'];
        return data.map((item) => Pricelist.fromJson(item)).toList();
      }else{
        throw Exception("Error: ${json.decode(response.body)}");
      }
    }catch(e){
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> beliProduk(Pricelist pricelist)async{
    try{
      final response = await http.post(Uri.parse('$baseUrl/buy'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pricelist.toJson()));

      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        return {
          "success": false,
          "message": json.decode(response.body).toString(),
        };
      }
    }catch(e){
      return{
        "success": false,
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getBalance()async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/balance'));
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        return{
          "success": false,
          "message": json.decode(response.body),
        };
      }
    }catch(e){
      return{
        "success": false,
        "message": e,
      };
    }
  }

  Future<List<Pricelist>> getAllPriceListIAK(String type, String operator)async{
    final String sign = md5.convert(utf8.encode("${username}${apiKey}pl")).toString();
    try{
      final response = await http.post(Uri.parse('$baseUrlIAK/pricelist/$type/$operator'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "status": "active",
        "username": username,
        "sign": sign,
      }));
      if(response.statusCode == 200){
        final List<dynamic> data = json.decode(response.body)['data']['pricelist'];
        return data.map((item) => Pricelist.fromJson(item)).toList();
      }else{
        throw Exception(json.decode(response.body));
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> beliProdukIAK(String kostumer, String code)async{
    final String referenceID = createReferenceID();
    final String sign = md5.convert(utf8.encode("${username}${apiKey}${referenceID}")).toString();
    try{
      final response = await http.post(Uri.parse('$baseUrlIAK/top-up'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "customer_id": kostumer,
        "product_code": code,
        "ref_id": referenceID,
        "username": username,
        "sign": sign,
      }));

      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        throw Exception(json.decode(response.body));
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getBalanceIAK()async{
    final String sign = md5.convert(utf8.encode("${username}${apiKey}bl")).toString();

    try{
      final response = await http.post(Uri.parse('$baseUrlIAK/check-balance'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "username": username,
        "sign": sign,
      }));

      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        throw Exception(json.decode(response.body));
      }
    }catch(e){
      throw Exception(e);
    }
  }
}
