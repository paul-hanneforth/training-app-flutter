import 'package:training_app/utils/date.dart';

enum WeightUnit {
  kilogram
}

/* class ActivitySet {
  final int repetitions;
  final double weight;
  final WeightUnit unit;

  ActivitySet({ required this.repetitions, required this.weight, this.unit = WeightUnit.kilogram });

  String getUnitAsString() {
    if(unit == WeightUnit.kilogram) return "kg";
    return "*";
  }
}

class Activity {
  final DateTime date;
  final List<ActivitySet> sets;
  final String exerciseId;

  Activity({
    required this.date,
    required this.sets,
    required this.exerciseId
  });
}

class Exercise {
  final String name;
  final List<String> muscleGroups;
  final List<Activity> activities;
  
  Exercise({ required this.name, required this.muscleGroups, required this.activities });
} */

class Exercise {
  final String name;
  final List<String> muscleGroups;

  Exercise({
    required this.name,
    required this.muscleGroups
  });
}
class ExerciseSession {
  final Exercise exercise;
  final NewDate date;
  final List<ExerciseSet> sets;

  ExerciseSession({
    required this.exercise,
    required this.date,
    required this.sets
  });
}
class ExerciseSet {
  final num weight;
  final int repetitions;

  ExerciseSet({
    required this.weight,
    required this.repetitions
  });
}