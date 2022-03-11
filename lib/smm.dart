class Smm {
  final double easeFactor;
  final int repetitions;
  final int interval;
  Smm([this.repetitions = 0, this.interval = 0, this.easeFactor = 2.5]);
  Smm calc(int quality) {
    if (quality >= 3) {
      final int nextInterval = (() {
        switch (repetitions) {
          case 0:
            return 1;
          case 1:
            return 6;
          default:
            return (interval * easeFactor).round();
        }
      })();
      final nextRepetitions = repetitions + 1;
      final double nextEaseFactor = _calcEaseFactor(easeFactor, quality);
      return Smm(nextRepetitions, nextInterval, nextEaseFactor);
    } else {
      final int nextRepetitions = 0;
      final int nextInterval = 1;
      return Smm(nextRepetitions, nextInterval, easeFactor);
    }
  }

  double _calcEaseFactor(double previousEaseFactor, int quality) {
    final easeFactor = previousEaseFactor +
        (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    final double lowerLimit = 1.3;
    return easeFactor < lowerLimit ? lowerLimit : easeFactor;
  }
}

class SmResult {
  final int interval;
  final int repetitions;
  final double easeFactor;
  SmResult(this.interval, this.repetitions, this.easeFactor);
}
