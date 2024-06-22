import 'dart:math';

class Util {
  static String createRand32String() {
    var length = 32;

    var rand = Random();

    var codeUnits = List.generate(length, (index) {
      int next = rand.nextInt(33);
      if (next < 10) {
        return next + 48;
      } else {
        return next + 87;
      }
    });

    String randomString = String.fromCharCodes(codeUnits);
    return randomString;
  }
}
