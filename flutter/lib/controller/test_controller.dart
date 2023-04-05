import 'dart:convert';

import 'package:nonereceipt/api/http_api.dart';
import 'package:nonereceipt/models/receipt.dart';

class TestController {
  static Future<List<Receipt>> getTestGetRequest() async {
    String response = await HttpClient.fetchReceipts() as String;
    List<dynamic> data = json.decode(response);
    List<Receipt> receipts =
        data.map((json) => Receipt.fromJson(json)).toList();
    return receipts;
  }
}
