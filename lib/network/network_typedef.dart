import 'package:article_blog_api/network/network_enums.dart';

typedef NetworkCallBack<R> = R Function(dynamic);
typedef NetworkOnfailureCallBackWithMessage<R> = R Function(
    NetworkResponseErrorType, String?);
