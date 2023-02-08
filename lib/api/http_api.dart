import 'package:http/http.dart' as http;

class HttpClient {
  static const username = "";
  static const password = "";

  static String getUrl() {
    return "";
  }

  static Future<String> testRequest() async {
    var url = Uri.parse("192.168.1.11:8000/");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      return result.body;
    } else {
      print("Something went wrong: ${result.statusCode}");
      return "error occured..";
    }
  }
}
