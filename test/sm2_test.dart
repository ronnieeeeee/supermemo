import 'package:flutter_test/flutter_test.dart';
import 'package:supermemo/sm_response.dart';
import 'package:supermemo/original_sm.dart';
import 'package:supermemo/supermemo.dart';

void main() {
  test('Calc success', () {
    final int quality = 1;
    final int initRepetitions = 0;
    final int initInterval = 0;
    final double initEaseFactor = 2.5;
    final sm = SM(initRepetitions, initInterval, initEaseFactor);

    final SM smResponse = sm.calc(quality);

    expect(smResponse.interval, 1);
    expect(smResponse.repetitions, 0);
    expect(smResponse.easeFactor, 2.5);

    final originalSm = OriginalSm();
    SmResponse originalSmResponse = originalSm.calc(
        quality: quality,
        repetitions: initRepetitions,
        previousInterval: initInterval,
        previousEaseFactor: initEaseFactor);

    expect(smResponse.interval, originalSmResponse.interval);
    expect(smResponse.repetitions, originalSmResponse.repetitions);
    expect(smResponse.easeFactor, originalSmResponse.easeFactor);

    final quality2 = 5;
    SmResponse originalSmResponse2 = originalSm.calc(
        quality: quality2,
        repetitions: originalSmResponse.repetitions,
        previousInterval: originalSmResponse.interval,
        previousEaseFactor: originalSmResponse.easeFactor);

    final smResponse2 = SM(initRepetitions, initInterval, initEaseFactor)
        .calc(quality)
        .calc(quality2);

    expect(smResponse2.interval, originalSmResponse2.interval);
    expect(smResponse2.repetitions, originalSmResponse2.repetitions);
    expect(smResponse2.easeFactor, originalSmResponse2.easeFactor);

    final quality3 = 5;
    SmResponse originalSmResponse3 = originalSm.calc(
        quality: quality3,
        repetitions: originalSmResponse2.repetitions,
        previousInterval: originalSmResponse2.interval,
        previousEaseFactor: originalSmResponse2.easeFactor);

    final smResponse3 = SM(initRepetitions, initInterval, initEaseFactor)
        .calc(quality)
        .calc(quality2)
        .calc(quality3);

    expect(smResponse3.interval, originalSmResponse3.interval);
    expect(smResponse3.repetitions, originalSmResponse3.repetitions);
    expect(smResponse3.easeFactor, originalSmResponse3.easeFactor);
  });

  test('Calc - quality: 5, repetitions: 2, interval: 6, factor: 1.3', () {
    final int quality = 5;
    final int initRepetitions = 2;
    final int initInterval = 6;
    final double initEaseFactor = 1.3;
    final sm = SM(initRepetitions, initInterval, initEaseFactor);
    final smResponse = sm.calc(quality);

    final originalSm = OriginalSm();

    SmResponse originalSmResponse = originalSm.calc(
        quality: quality,
        repetitions: initRepetitions,
        previousInterval: initInterval,
        previousEaseFactor: initEaseFactor);

    expect(smResponse.interval, originalSmResponse.interval);
    expect(smResponse.repetitions, originalSmResponse.repetitions);
    expect(smResponse.easeFactor, originalSmResponse.easeFactor);
  });
}
