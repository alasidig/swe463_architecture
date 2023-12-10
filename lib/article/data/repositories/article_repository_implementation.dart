
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../data_sources/local_datasource.dart';
import '../data_sources/remote_datasource.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Article> fetchArticle() async {
    try {
      // First try to fetch the article from the remote data source
      final remoteArticle = await remoteDataSource.fetchArticle();

      // Save the remote article to the local data source (if applicable)
      await localDataSource.saveArticle(remoteArticle);

      // Return the article fetched from the remote data source
      return Article.fromData(remoteArticle);
    } catch (e) {
      // If fetching from the remote data source fails, try fetching from the local data source
      final localArticle = await localDataSource.fetchArticle();

      // Return the article fetched from the local data source
      return Article.fromData(localArticle);
    }
  }
}