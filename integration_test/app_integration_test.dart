import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:swe_463_arch_testing_lec/app.dart';
import 'package:swe_463_arch_testing_lec/article/presentation/widgets/article_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('End to End tests', () {
    testWidgets('Shows an article', (widgetTester) async {
      await widgetTester.pumpWidget(MyApp());
      await widgetTester.pumpAndSettle();
      expect(find.byType(ArticleCard), findsOneWidget);
    });
  });
}
