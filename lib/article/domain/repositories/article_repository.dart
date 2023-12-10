import '../entities/article.dart';

abstract class ArticleRepository {
  Future<Article> fetchArticle();
}

