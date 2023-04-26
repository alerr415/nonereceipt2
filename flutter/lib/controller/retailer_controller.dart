import 'package:nonereceipt/api/http_api.dart';
import 'package:nonereceipt/models/retailer.dart';

class RetailerController {
  static Future<List<Retailer>> getRetailers() {
    return HttpClient.fetchRetailers();
  }
}
