import 'package:http/http.dart' as http;

class HttpClient {
  static const username = "";
  static const password = "";

  static String getUrl() {
    return "";
  }

  static Future<bool> testRequest() async {
    var url = Uri.parse("ip_cimed_ide:8000/");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      print(result.body);
      return true;
    } else {
      print("Something went wrong: ${result.statusCode}");
      return false;
    }
  }
}
