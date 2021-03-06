import 'package:article_blog_api/models/article_model.dart';
import 'package:article_blog_api/network/network_helper.dart';
import 'package:http/http.dart' as http;

enum RequestType { get, post, put }

class NetworkService {
  const NetworkService._();

  static Map<String, String> _getHeaders() =>
      {'Content-Type': 'application/json'};

  static Future<http.Response>? _createRequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    if (requestType == RequestType.get) {
      return http.get(uri, headers: headers);
    }
  }

  static Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? queryparam,
  }) async {
    try {
      final _header = _getHeaders();
      final _url = NetworkHelper.concatUrlQP(url, queryparam);

      final response = await _createRequest(
          requestType: requestType,
          uri: Uri.parse(_url),
          headers: _header,
          body: body);

      return response;
    } catch (e) {
      print('Error - $e');
      return null;
    }
  }

  // final List<Article> _list = [];

  // Article findByUrl(String url) {
  //   return _list.firstWhere((article) => article.url == url);
  // }
}
