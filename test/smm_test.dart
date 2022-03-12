import 'package:flutter_test/flutter_test.dart';
import 'package:sm2/sm.dart';

void main() {
  test('Calc success', () {
    final int quality = 0;
    final int initRepetitions = 0;
    final int initInterval = 0;
    final double initEaseFactor = 2.5;
    final sm = SM(initRepetitions, initInterval, initEaseFactor);
    final SM sm2 = sm.calc(quality);

    expect(sm2.interval, 1);
    expect(sm2.repetitions, 0);
    expect(sm2.easeFactor, 2.5);

    final smm = SM();
    final SM smm2 = smm.calc(quality);

    expect(smm2.interval, 1);
    expect(smm2.repetitions, 0);
    expect(smm2.easeFactor, 2.5);
  });

  test('Calc - quality: 5, repetitions: 2, interval: 6, factor: 1.3', () {
    final int quality = 5;
    final int initRepetitions = 2;
    final int initInterval = 6;
    final double initEaseFactor = 1.3;
    final sm = SM(initRepetitions, initInterval, initEaseFactor);
    final result = sm.calc(quality);

    expect(result.interval, 8);
    expect(result.repetitions, 3);
    expect(result.easeFactor, 1.4000000000000001);
  });
}
