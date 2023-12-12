import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/remote_datasource.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('RemoteDataSource', () {
    late RemoteDataSource remoteDataSource;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      remoteDataSource = RemoteDataSource(apiUrl: 'http://example.com', httpClient: mockHttpClient);
      registerFallbackValue(Uri.parse('http://example.com/1'));
    });

    test('fetchArticle returns the fetched article', () async {
      final response = http.Response('Test article content', 200);

      when(()=>mockHttpClient.get(any()))
          .thenAnswer((_) async => response);

      final result = await remoteDataSource.fetchArticle();
      expect(result, equals(response.body));
    });

    test('fetchArticle throws an exception if the response status code is not 200', () async {
      final response = http.Response('Error', 404);

      when(()=>mockHttpClient.get(any()))
          .thenAnswer((_) async => response);
      expect(() => remoteDataSource.fetchArticle(), throwsException);
    });
  });
}