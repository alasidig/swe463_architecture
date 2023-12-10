
import 'package:http/http.dart' as http;
import 'utils.dart';



class RemoteDataSource {
  final String apiUrl;
  final http.Client httpClient;

  RemoteDataSource({required this.apiUrl, required this.httpClient});

  Future<String> fetchArticle() async {
    final articleId = getRandomArticleId(1, 30);
    final response = await httpClient.get(Uri.parse('$apiUrl/$articleId'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch article');
    }
  }
 
}