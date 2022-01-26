import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:training_app/pages/timeline_screen.dart';
import 'package:training_app/ui/custom_gesture_detector.dart';
import 'package:training_app/utils/date.dart';
import 'package:training_app/utils/types.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({ Key? key }) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {

  Future<void> scrollToIndex(ItemScrollController scrollController, int index, {
    Duration duration = const Duration(seconds: 1),
    Curve curve = Curves.easeInOutCubic
  }) async {
    await Future.delayed(const Duration(milliseconds: 10));
    await scrollController.scrollTo(
      index: index,
      duration: duration,
      curve: curve
    );
  }
  Future<void> scrollToHorizontalIndex(int index, {
    Duration duration = const Duration(seconds: 1),
    Curve curve = Curves.easeInOutCubic
  }) async => scrollToIndex(horizontalItemScrollController, index, duration: duration, curve: curve);
  Future<void> scrollToVerticalIndex(int index, {
    Duration duration = const Duration(seconds: 1),
    Curve curve = Curves.easeInOutCubic
  }) async => scrollToIndex(verticalItemScrollController, index, duration: duration, curve: curve);

  final ItemScrollController verticalItemScrollController = ItemScrollController();
  final ItemPositionsListener verticalItemPositionsListener = ItemPositionsListener.create();
  final ItemScrollController horizontalItemScrollController = ItemScrollController();
  final ItemPositionsListener horizontalItemPositionsListener = ItemPositionsListener.create();

  List<TimelineScreen> previousExercises = [];
  List<TimelineScreen> exercises = [];
  int previousExercisesIndex = -1;
  int exerciseIndex = 0;

  ExerciseSession randomExerciseSession([ String name = "Brustpresse" ]) {
    final _random = Random();
    int next(int min, int max) => min + _random.nextInt(max - min);

    final Exercise exercise = Exercise(name: name, muscleGroups: ["Brust", "Schultern"]);

    List<ExerciseSet> sets = [];
    for(int i = 0; i < next(2, 5); i ++) {
      sets.add(ExerciseSet(repetitions: next(8, 12), weight: next(40, 80).toDouble()));
    }

    final ExerciseSession session = ExerciseSession(exercise: exercise, date: NewDate(), sets: sets);
    return session;
  }

  @override
  void initState() {
    super.initState();

    final ExerciseSession prev1 = randomExerciseSession("Previous 1");
    final ExerciseSession prev2 = randomExerciseSession("Previous 2");
    final ExerciseSession prev3 = randomExerciseSession("Previous 3");

    previousExercises.addAll([ screen(prev1), screen(prev2), screen(prev3) ]);
    previousExercisesIndex = previousExercises.length; // index would be out of range

    final ExerciseSession exer1 = randomExerciseSession("Exercise 1");
    final ExerciseSession exer2 = randomExerciseSession("Exercise 2");
    final ExerciseSession exer3 = randomExerciseSession("Exercise 3");
    final ExerciseSession exer4 = randomExerciseSession("Exercise 4");

    exercises.addAll([ screen(exer1), screen(exer2), screen(exer3), screen(exer4) ]);

  }

  final List<Color> colors = [
    const Color(0xFFf6f2d4),
    const Color(0xFFe7c8b5),
    const Color(0xFFc3f6e0),
    const Color(0xFFffdfee),
    const Color(0xFFd2d9f2)
  ];
  TimelineScreen screen(ExerciseSession exerciseSession) {
    final Color color = (colors.toList()..shuffle()).first;
    return TimelineScreen(session: exerciseSession, backgroundColor: color);
  }
  Widget horizontalListScreen(List<Widget> list, int index) {
    return RawGestureDetector(
      gestures: {
        AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleGestureRecognizer>(() => AllowMultipleGestureRecognizer(), (AllowMultipleGestureRecognizer instance) {
          /* instance.onUpdate = (DragUpdateDetails e) => onUpdate(e);
          instance.onEnd = onEnd;
          instance.onDown = onDown; */
        }) 
      },
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ScrollablePositionedList.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          initialScrollIndex: index,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return list[index];
          },
          itemScrollController: horizontalItemScrollController,
          itemPositionsListener: horizontalItemPositionsListener,
        ),
      ),
    );
  }

  Offset? lastDeltaUpdate;

  void onUpdate(DragUpdateDetails e) {
    lastDeltaUpdate = e.delta;
  }
  void onDown(DragDownDetails e) {
  }
  void onEnd(DragEndDetails e) {
    if((lastDeltaUpdate!.dx).abs() > (lastDeltaUpdate!.dy).abs()) {
      // horizontal drag

      // ignore horizontal drag if user is scrolling through previousExercises
      if(previousExercisesIndex != previousExercises.length) {
        return;
      }

      int newIndex = (lastDeltaUpdate!.dx > 0) ? (exerciseIndex - 1) : (exerciseIndex + 1);
      if(newIndex < 0 || (newIndex >= exercises.length)) return;

      exerciseIndex = newIndex;

      scrollToHorizontalIndex(newIndex, duration: const Duration(milliseconds: 600));

    } else {
      // vertical drag

      int newIndex = (lastDeltaUpdate!.dy > 0) ? (previousExercisesIndex - 1) : (previousExercisesIndex + 1);
      if(newIndex < 0 || (newIndex > previousExercises.length)) return;
      if(newIndex == previousExercises.length);

      previousExercisesIndex = newIndex;

      scrollToVerticalIndex(newIndex, duration: const Duration(milliseconds: 600));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
        SizedBox.expand(
          child: RawGestureDetector(
            gestures: {
              AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleGestureRecognizer>(() => AllowMultipleGestureRecognizer(), (AllowMultipleGestureRecognizer instance) {
                instance.onUpdate = onUpdate;
                instance.onEnd = onEnd;
                instance.onDown = onDown;
              }) 
            },
            behavior: HitTestBehavior.translucent,
            child: AbsorbPointer(
              absorbing: false,
              child: ScrollablePositionedList.builder(
                physics: const NeverScrollableScrollPhysics(),
                initialScrollIndex: previousExercises.length,
                scrollDirection: Axis.vertical,
                itemCount: previousExercises.length + 1, // +1 because of the currently active screen aka horizontalListScreen
                itemBuilder: (context, index) {
                  if(index == previousExercises.length) {
                    return horizontalListScreen(exercises, exerciseIndex);
                  }
                  return previousExercises[index];
                },
                itemScrollController: verticalItemScrollController,
                itemPositionsListener: verticalItemPositionsListener,
              ),
            ),
          ),
        ),
    );
  }

}

class AllowMultipleGestureRecognizer extends PanGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class MultipleGestureDetector extends InheritedWidget {
  final void Function()? onUpdate;

  const MultipleGestureDetector({
    Key? key,
    required Widget child,
    required this.onUpdate,
  }) : super(key: key, child: child);

  static MultipleGestureDetector? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MultipleGestureDetector>();
  }

  @override
  bool updateShouldNotify(MultipleGestureDetector oldWidget) => false;
}