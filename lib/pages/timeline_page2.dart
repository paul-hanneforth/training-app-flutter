import 'dart:async';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:training_app/ui/color.dart';
import 'package:training_app/utils/date.dart';
import 'package:training_app/utils/types.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({ Key? key }) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {

  int _weight = 45;
  int _repetitions = 10;

  int activeIndex = 0;
  List<ExerciseSession> exercises = [];

  void incrementWeight(int by) {
    int newWeight = _weight + by;
    if(newWeight < 0) return;

    setState(() {
      _weight = newWeight;
    });
  }
  void incrementRepetitions(int by) {
    int newRepetitions = _repetitions + by;
    if(newRepetitions < 0) return;

    setState(() {
      _repetitions = newRepetitions;
    });
  }

  Widget header({ required Function allButtonOnTap }) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => allButtonOnTap(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
              child: Text("Alle (20)", style: TextStyle(fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w500)),
            ),
          ),
        )
      ],
    );
  }
  Widget info({
    required String date,
    required String exerciseName,
    required List<String> exerciseMuscleGroups
  }) {
    return Column(
      children: [
        Text(date, style: const TextStyle(fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w400, color: Color(0x99000000))),
        Text(exerciseName, style: const TextStyle(fontFamily: "Lato", fontSize: 36, fontWeight: FontWeight.w600)),
        const Padding(padding: EdgeInsets.symmetric(vertical: 7)),
        Text(exerciseMuscleGroups.join(", "), style: const TextStyle(fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xCC000000))),
      ],
    );
  }
  Widget setSelectorElement(String label, bool selected) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => print("now!"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(label, style: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w400, fontSize: 18, color: selected ? Colors.black : const Color(0xA6000000))),
        ),
      ),
    );
  }
  Widget setSelector() {
    return Container(
      child: Row(
        children: [
          setSelectorElement("1", false),
          setSelectorElement("2", false),
          setSelectorElement("3", false),
          setSelectorElement("4", true)
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: CustomColor.black10),
      ),
    );
  }
  Widget sets() {
    return Column(
      children: [
        setSelector()
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
  Widget content(ExerciseSession session) {
    final NewDate currentDate = NewDate();
    final NewDate dayStartDate = currentDate.toDayStart(); // currentDate but at the start of the day for example: 18:46@07.12.2021 -> 00:00@07.12.2021

    final bool wasToday = (currentDate.isAfter(dayStartDate) || currentDate.isAtSameMomentAs(dayStartDate));
    final bool wasYesterday = (session.date.isAfter(dayStartDate.subtract(const Duration(days: 1))) && session.date.isBefore(dayStartDate));

    return Column(
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 9)),
        info(
          exerciseName: session.exercise.name,
          exerciseMuscleGroups: session.exercise.muscleGroups,
          date: wasToday ? "Heute" :
                wasYesterday ? "Gestern" :
                session.date.format()
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 45)),
        sets(),
        const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
      ]
    );
  }
  Widget footer({ required Function newSetButtonOnTap }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () { 
          newSetButtonOnTap(); 
          /* Navigator.of(context).push(
            CupertinoPageRoute(  
              fullscreenDialog: true,
              builder: (context) {
                return TimelinePage();
              },
            ),
          ); */
          /* Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => new TimelinePage(),
            transitionsBuilder: (context, Animation animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              // animation.drive(Animatable())

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            }
          )); */
        },
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 125,
            child: Center(
              child: Row(
                children: [
                  const Text("Neuer Satz", style: TextStyle(fontFamily: "Lato", fontSize: 21, fontWeight: FontWeight.w500)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
                  Icon(Icons.add, color: CustomColor.black80)
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              )
            ),
        ),
      ),
    );
  }

  Widget screen() {
    final Exercise exercise = Exercise(name: "Brustpresse", muscleGroups: ["Brust", "Schultern"]);
    final ExerciseSet set = ExerciseSet(repetitions: 11, weight: 45);
    final ExerciseSession session = ExerciseSession(exercise: exercise, date: NewDate(), sets: [ set, set, set ]);

    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            header(allButtonOnTap: () {}),
            content(session),
            footer(newSetButtonOnTap: () {})
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

  Widget page1() {
    return screen();
  }
  Widget page2() {
    return screen();
  }
  Widget page3() {
    return screen();
  }

  Widget fromExercise(Exercise exercise) {
    return Container();
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    int index = 0;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // print(Scrollable.of(context)?.position.pixels);
    });

    Timer.periodic(const Duration(seconds: 30), (timer) {
      if(index == 2) {
        index = 0;
      } else {
        index ++;
      }
      itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2D4),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          // print(notification.scrollDelta);
          // print(notification.metrics.pixels);
          return true;
        },
        child: ScrollablePositionedList.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            if(index == 0) {
              return page1();
            } else if(index == 1) {
              return page2();
            } else if(index == 3) {
              return page3();
            }
            return page3();
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
        ),
      )
    );
  }

}