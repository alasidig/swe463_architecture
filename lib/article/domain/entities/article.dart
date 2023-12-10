import 'dart:convert';

class Article {
  final String title;
  final String message;

  Article({required this.title, required this.message});

  factory Article.fromData(articleData) {
    final article = jsonDecode(articleData);

    return Article(
      title: article['title'],
      message: article['body'],
    );
  }
}
