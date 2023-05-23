import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nonereceipt/models/receipt.dart';

import '../models/retailer.dart';

class HttpClient {
  static const username = "";
  static const password = "";

  static String getUrl() {
    return "http://127.0.0.1:8000";
  }

  static Future<List<Receipt>> fetchReceipts() async {
    var url = Uri.parse("${getUrl()}/receipts");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      return List<Receipt>.from(
          json.decode(result.body).map((receipt) => Receipt.fromJson(receipt)));
    } else {
      throw Exception("Something went wrong: ${result.statusCode}");
    }
  }

  static Future<List<Receipt>> fetchReceiptsByRetailer(
      String retailerName) async {
    var url = Uri.parse("${getUrl()}/retailers/$retailerName/receipts");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      var jsonList = json.decode(result.body) as List;
      return jsonList.map((json) => Receipt.fromJson(json)).toList();
    } else {
      throw Exception("failed to fetch recipes from retailer: $retailerName");
    }
  }

  static Future<List<Retailer>> fetchRetailers() async {
    var url = Uri.parse("${getUrl()}/retailers");
    print(url);
    var result = await http.get(url);
    print("Valami történt");
    if (result.statusCode == 200) {
      var jsonList = json.decode(result.body) as List;
      return jsonList.map((json) => Retailer.fromJson(json)).toList();
    } else {
      throw Exception("failed to fetch retailers");
    }
  }
}
