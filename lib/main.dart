import 'package:article_blog_api/screens/headlines_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Blog',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const HeadlinesScreen(),
    );
  }
}
