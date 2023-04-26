import 'package:nonereceipt/api/http_api.dart';
import 'package:nonereceipt/models/receipt.dart';

class ReceiptController {
  static Future<List<Receipt>> getReceipts() {
    return HttpClient.fetchReceipts();
  }

  static Future<List<Receipt>> getReceiptsByRetailerName(String name) {
    return HttpClient.fetchReceiptsByRetailer(name);
  }
}
