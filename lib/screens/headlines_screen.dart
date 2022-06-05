import 'package:article_blog_api/models/article_model.dart';
import 'package:article_blog_api/network/network_enums.dart';
import 'package:article_blog_api/network/network_helper.dart';
import 'package:article_blog_api/network/network_service.dart';
import 'package:article_blog_api/network/query_param.dart';
import 'package:article_blog_api/static/static_values.dart';
import 'package:article_blog_api/widgets/article_widget.dart';
import 'package:flutter/material.dart';

class HeadlinesScreen extends StatefulWidget {
  const HeadlinesScreen({Key? key}) : super(key: key);

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Headline News',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => getData(),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final List<Article> articles = snapshot.data as List<Article>;

              return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return ArticleWidget(article: articles[index]);
                  });
            } else if (snapshot.hasError) {
              return const SnackBar(
                // backgroundColor: Colors.black45,
                content: Text('Something went wrong, try again'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<List<Article>?> getData() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      url: StaticValues.apiUrl,
      queryparam: QP.apiQP(
          apiKey: StaticValues.apiKey, country: StaticValues.apiCountry),
    );

    print(response?.body);
    print(response?.statusCode);

    return await NetworkHelper.filterResponse(
        callBack: _listOfArticlesFromJson,
        response: response,
        onfailureCallBackWithMessage: (errorType, msg) {
          print('Error type - $errorType, Message - $msg');
          return null;
        },
        parameterName: CallBackParameterName.articles);
  }

  List<Article> _listOfArticlesFromJson(json) => (json as List)
      .map((e) => Article.fromJson(e as Map<String, dynamic>))
      .toList();
}
