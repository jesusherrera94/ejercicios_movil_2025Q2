import 'package:http/http.dart' as http;


class HttpAdapter {
  Future<dynamic> getRequest(String url, String path) async {
    Uri uri = Uri.https(url, path);
    http.Response response = await http.get(uri);
    return response.body;
  }
}
