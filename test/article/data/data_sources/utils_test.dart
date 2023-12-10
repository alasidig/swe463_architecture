import 'package:flutter_test/flutter_test.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/utils.dart';

void main() {
  test('getRandomArticleId returns a random number between min and max', () {
    final min = 1;
    final max = 100;

    final result = getRandomArticleId(min, max);

    expect(result, greaterThanOrEqualTo(min));
    expect(result, lessThanOrEqualTo(max));
  });
}