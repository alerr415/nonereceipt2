import 'package:nonereceipt/api/http_api.dart';

class TestController {

  TestController() {
  }
  static Future<bool> getTestGetRequest() async {
    return await HttpClient.testRequest();
  }
}