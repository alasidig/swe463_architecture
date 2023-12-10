import 'package:flutter/material.dart';
import 'package:swe_463_arch_testing_lec/article/domain/entities/article.dart';
import 'package:swe_463_arch_testing_lec/article/domain/repositories/article_repository.dart';
import 'package:swe_463_arch_testing_lec/article/presentation/widgets/article_card.dart';

class HomeScreen extends StatefulWidget {
  final ArticleRepository articleRepository;

  const HomeScreen({super.key, required this.articleRepository});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Article> _article;

  @override
  void initState() {
    super.initState();
    _article = widget.articleRepository.fetchArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article App'),
      ),
      body: FutureBuilder<Article>(
        future: _article,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ArticleCard(article: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}