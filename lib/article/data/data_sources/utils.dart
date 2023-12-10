 // function to return random integer between min and max
  import 'dart:math' show Random;

int getRandomArticleId(int min, int max) {
    return min + Random().nextInt(max - min);
  }