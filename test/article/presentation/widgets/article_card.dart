import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swe_463_arch_testing_lec/article/domain/entities/article.dart';
import 'package:swe_463_arch_testing_lec/article/presentation/widgets/article_card.dart';

void main() {
  testWidgets('ArticleCard displays the correct title and content', (WidgetTester tester) async {
    // arrange
    const String title = 'Test Article Title';
    const String content = 'Test Article Content';

   // act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ArticleCard(article: Article(title: title, message: content),),
        ),
      ),
    );

// assert
    expect(find.text(title), findsOneWidget);
    expect(find.text(content), findsOneWidget);
  });
}