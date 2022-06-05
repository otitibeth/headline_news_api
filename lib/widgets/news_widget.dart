import 'package:article_blog_api/models/article_model.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final publishedAt = article.publishedAt?.split('T')[0];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title!,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black,
              child: article.imageUrl != null
                  ? Image.network(article.imageUrl!)
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Source: ${article.source.name ?? ''}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  publishedAt ?? '',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Author: ${article.author}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              article.content!,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
