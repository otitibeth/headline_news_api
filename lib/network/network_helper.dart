import 'dart:convert';

import 'package:article_blog_api/network/network_enums.dart';
import 'package:article_blog_api/network/network_typedef.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  const NetworkHelper._();

  static String concatUrlQP(String url, Map<String, String>? queryParameters) {
    if (url.isEmpty) return url;
    if (queryParameters == null || queryParameters.isEmpty) {
      return url;
    }
    final StringBuffer stringBuffer = StringBuffer("$url?");
    queryParameters.forEach((key, value) {
      if (value.trim() == '') return;
      if (value.contains(' ')) throw Exception('Invalid input exception');
      stringBuffer.write('$key=$value&');
    });
    final result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  }

  static bool _isValidResponse(json) {
    return json != null &&
        json['status'] != null &&
        json['status'] == 'ok' &&
        json['articles'] != null;
  }

  static R filterResponse<R>({
    required NetworkCallBack callBack,
    required http.Response? response,
    required NetworkOnfailureCallBackWithMessage onfailureCallBackWithMessage,
    CallBackParameterName parameterName = CallBackParameterName.all,
  }) {
    try {
      if (response == null || response.body.isEmpty) {
        return onfailureCallBackWithMessage(
            NetworkResponseErrorType.responseEmpty, 'No Response');
      }

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (_isValidResponse(json)) {
          return callBack(parameterName.getJson(json));
        } else if (response.statusCode == 1708) {
          return onfailureCallBackWithMessage(
              NetworkResponseErrorType.socket, 'Socket error');
        }
      }
      return onfailureCallBackWithMessage(
          NetworkResponseErrorType.didNotSucceed, 'unknown error');
    } catch (e) {
      return onfailureCallBackWithMessage(
          NetworkResponseErrorType.exception, 'Exception $e');
    }
  }
}
