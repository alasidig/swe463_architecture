import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/local_datasource.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/remote_datasource.dart';
import 'package:swe_463_arch_testing_lec/article/presentation/pages/home_screen.dart';

import 'article/data/repositories/article_repository_implementation.dart';
import 'article/domain/repositories/article_repository.dart';

class MyApp extends StatelessWidget {
  final RemoteDataSource remoteDataSource = RemoteDataSource(
      apiUrl: 'https://jsonplaceholder.typicode.com/posts',
      httpClient: Client());
  final LocalDataSource localDataSource = LocalDataSource();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticleRepository articleRepository = ArticleRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    return MaterialApp(
      title: 'Article App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(articleRepository: articleRepository),
    );
  }
}
