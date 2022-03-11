import 'package:flutter_test/flutter_test.dart';
import 'package:sm2/sm.dart';

void main() {
  test('Calc success', () {
    final sm = Sm(easeFactor);
    final int quality = 0;
    final Sm sm = sm.calcc(quality).calcc(quality);
    final SmResult result = sm.result();

    expect(result.interval, 1);
    expect(result.repetitions, 0);
    expect(result.easeFactor, 2.5);
  });
}
