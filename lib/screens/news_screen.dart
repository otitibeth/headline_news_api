import 'package:article_blog_api/models/article_model.dart';
import 'package:article_blog_api/widgets/news_widget.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
      ),
      body: NewsWidget(article: article),
    );
  }
}
