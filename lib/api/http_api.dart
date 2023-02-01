import 'package:http/http.dart' as http;

class HttpClient {
  static const username = "";
  static const password = "";

  static String getUrl() {
    return "";
  }
}

Future<bool> testRequest() async {
  var url = Uri.parse("${HttpClient.getUrl()}/path/to/request");
  var result = await http.get(url);
  if (result.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
