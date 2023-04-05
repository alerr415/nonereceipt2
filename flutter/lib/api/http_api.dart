import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nonereceipt/models/receipt.dart';
import 'package:nonereceipt/models/retailer.dart';

class HttpClient {
  static const username = "";
  static const password = "";

  static String getUrl() {
    return "";
  }

  // Fetch receipts from the API
  static Future<List<Receipt>> fetchReceipts() async {
    var url = Uri.parse("http://127.0.0.1:8000/receipts/");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      var jsonList = json.decode(result.body) as List;
      return jsonList.map((json) => Receipt.fromJson(json)).toList();
    } else {
      throw Exception("Something went wrong: ${result.statusCode}");
    }
  }

  static Future<List<Receipt>> fetchReceiptsByRetailer(
      String retailerName) async {
    var url =
        Uri.parse("http://127.0.0.1:8000/retailers/$retailerName/receipts");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      var jsonList = json.decode(result.body) as List;
      return jsonList.map((json) => Receipt.fromJson(json)).toList();
    } else {
      throw Exception("failed to fetch recipes from retailer: $retailerName");
    }
  }
}
