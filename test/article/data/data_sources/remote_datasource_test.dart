import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/remote_datasource.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/utils.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('RemoteDataSource', () {
    late RemoteDataSource remoteDataSource;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      remoteDataSource = RemoteDataSource(apiUrl: 'http://example.com', httpClient: mockHttpClient);
    });

    test('fetchArticle returns the fetched article', () async {
      final articleId = 1;
      final response = http.Response('Test article content', 200);

      when(mockHttpClient.get(Uri.parse('http://example.com/$articleId')))
          .thenAnswer((_) async => response);

      when(getRandomArticleId(1, 30)).thenReturn(articleId);

      final result = await remoteDataSource.fetchArticle();

      expect(result, equals(response.body));
      verify(mockHttpClient.get(Uri.parse('http://example.com/$articleId'))).called(1);
    });

    test('fetchArticle throws an exception if the response status code is not 200', () async {
      final articleId = 1;
      final response = http.Response('Error', 404);

      when(mockHttpClient.get(Uri.parse('http://example.com/$articleId')))
          .thenAnswer((_) async => response);

      when(getRandomArticleId(1, 30)).thenReturn(articleId);

      expect(() => remoteDataSource.fetchArticle(), throwsException);
      verify(mockHttpClient.get(Uri.parse('http://example.com/$articleId'))).called(1);
    });
  });
}