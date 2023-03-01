import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nonereceipt/models/receipt.dart';

class HttpClient {
  static const username = "";
  static const password = "";

  static String getUrl() {
    return "";
  }

  // static Future<String> testRequest() async {
  //   var url = Uri.parse("http://127.0.0.1:8000/receipts/");
  //   var result = await http.get(url);
  //   if (result.statusCode == 200) {
  //     return result.body;
  //   } else {
  //     print("Something went wrong: ${result.statusCode}");
  //     return "error occured..";
  //   }
  // }

  static Future<List<Receipt>> testRequest() async {
    var url = Uri.parse("http://127.0.0.1:8000/receipts/");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      var jsonList = json.decode(result.body) as List;
      return jsonList.map((json) => Receipt.fromJson(json)).toList();
    } else {
      print("Something went wrong: ${result.statusCode}");
      return [];
    }
  }
}
