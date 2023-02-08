import 'package:nonereceipt/api/http_api.dart';

class TestController {

  static Future<String> getTestGetRequest() async {
    return await HttpClient.testRequest();
  }
}
