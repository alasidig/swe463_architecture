import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/local_datasource.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/remote_datasource.dart';
import 'package:swe_463_arch_testing_lec/article/data/repositories/article_repository_implementation.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}
class MockLocalDataSource extends Mock implements LocalDataSource {}

void main() {
  group('ArticleRepositoryImplementation', () {
    late ArticleRepositoryImpl articleRepository;
    late MockRemoteDataSource mockRemoteDataSource;
late MockLocalDataSource mockLocalDataSource;

    setUp(() {
      mockRemoteDataSource = MockRemoteDataSource();
      mockLocalDataSource = MockLocalDataSource();
      articleRepository = ArticleRepositoryImpl(remoteDataSource: mockRemoteDataSource, localDataSource: mockLocalDataSource);
    });

    test('getArticle returns the article from the remote data source', () async {
      //arrange
      const String articleContent = '{"title": "Test article", "body": "Test article content"}';
      when(()=>mockRemoteDataSource.fetchArticle()).thenAnswer((_) async => articleContent);
      when(()=>mockLocalDataSource.saveArticle(articleContent)).thenAnswer((_) async => '');

      //act
      final result = await articleRepository.fetchArticle();

      //assert
      expect(result.title, equals('Test article'));
      expect(result.message, equals('Test article content'));
      verify(()=>mockRemoteDataSource.fetchArticle()).called(1);
    });

    test('getArticle returns the article from the local data source', () async {
      //arrange
      const String articleContent = '{"title": "Test Local article", "body": "Test article local content"}';
      when(()=>mockRemoteDataSource.fetchArticle()).thenAnswer((_) async => '');
      when(()=>mockLocalDataSource.fetchArticle()).thenAnswer((_) async => articleContent);
      when(()=>mockLocalDataSource.saveArticle(articleContent)).thenAnswer((_) async => '');

      //act
      final result = await articleRepository.fetchArticle();

      //assert
      expect(result.title, equals('Test Local article'));
      expect(result.message, equals('Test article local content'));
      verify(()=>mockLocalDataSource.fetchArticle()).called(1);
      verify(()=>mockRemoteDataSource.fetchArticle()).called(1);
      //uncomment to discover a bug
      //verifyNever(()=>mockLocalDataSource.saveArticle(''));
    });
  });
}