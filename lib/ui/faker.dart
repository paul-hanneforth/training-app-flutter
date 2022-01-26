import 'dart:math';

import 'package:training_app/utils/types.dart';

class Faker {

  static int randomNumberBetween(min, max) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }

  static ExerciseSet exerciseSet() {
    final num weight = randomNumberBetween(40, 70);
    final int repetitions = randomNumberBetween(3, 11);

    return ExerciseSet(weight: weight, repetitions: repetitions);
  }

  static Exercise exercise() {
    final List<String> muscles = ["Rücken", "Bizeps", "Trizeps", "Brust", "Beine"];
    final List<String> names = ["Latzug", "Brustpresse", "Klimmzüge", "Beinpresse", "Latzug", "Rudern", "Bizeps Curls"];

    muscles.shuffle();
    names.shuffle();

    return Exercise(name: names[0], muscleGroups: muscles.sublist(0, randomNumberBetween(1, 3)));
  }

}