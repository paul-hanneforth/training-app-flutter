import "package:flutter/material.dart";
import 'package:training_app/ui/color.dart';
import 'package:training_app/utils/date.dart';
import 'package:training_app/utils/types.dart';

class TimelineScreen extends StatefulWidget {
  final Color backgroundColor;
  final Function(ExerciseSession updatedSession)? onWeightIncrement;
  final Function(ExerciseSession updatedSession)? onRepetitionsIncrement;
  final ExerciseSession session;

  const TimelineScreen({ 
    Key? key,
    this.backgroundColor = const Color(0xFFF6F2D4),
    this.onWeightIncrement,
    this.onRepetitionsIncrement,
    required this.session,
  }) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {

  int _selectedSet = -1;
  List<Map<String, num>> _sets = [];

  @override
  void initState() {
    super.initState();

    _sets = widget.session.sets.map((e) => { "weight": e.weight, "repetitions": e.repetitions }).toList();

    _selectedSet = (_sets.length - 1);
  }

  void selectSet(int index) {
    setState(() {
      _selectedSet = index;
    });
  }
  void incrementWeight(int by) {
    int newWeight = _sets[_selectedSet]["weight"]!.toInt() + by;
    if(newWeight < 0) return;

    setState(() {
      _sets[_selectedSet]["weight"] = newWeight;
    });

    if(widget.onWeightIncrement == null) return; // check if onWeightIncrement handler has been set
    final List<ExerciseSet> updatedSets = _sets.map((e) => ExerciseSet(weight: e["weight"]!.toDouble(), repetitions: e["repetitions"]!.toInt())).toList();
    final ExerciseSession updatedSession = ExerciseSession(exercise: widget.session.exercise, date: widget.session.date, sets: updatedSets); 
    widget.onWeightIncrement!(updatedSession);
  }
  void incrementRepetitions(int by) {
    int newRepetitions = _sets[_selectedSet]["repetitions"]!.toInt() + by;
    if(newRepetitions < 0) return;

    setState(() {
      _sets[_selectedSet]["repetitions"] = newRepetitions;
    });

    if(widget.onRepetitionsIncrement == null) return; // check if onRepetitionsIncrement handler has been set
    final List<ExerciseSet> updatedSets = _sets.map((e) => ExerciseSet(weight: e["weight"]!.toDouble(), repetitions: e["repetitions"]!.toInt())).toList();
    final ExerciseSession updatedSession = ExerciseSession(exercise: widget.session.exercise, date: widget.session.date, sets: updatedSets); 
    widget.onRepetitionsIncrement!(updatedSession);
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
  Widget setSelectorElement(int index, bool selected) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          selectSet(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text((index + 1).toString(), style: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w400, fontSize: 18, color: selected ? Colors.black : const Color(0xA6000000))),
        ),
      ),
    );
  }
  Widget setSelector() {
    final List<Widget> children = widget.session.sets.asMap().entries.map((entry) => setSelectorElement(entry.key, entry.key == _selectedSet)).toList();

    return Container(
      child: Row(
        children: children,
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
  Widget counterIcon(IconData icon, Function onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(10), child: Icon(icon, size: 24)
        )
      ),
    );
  }
  Widget counter(String label, int initialValue, Function onDecrement, Function onIncrement) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontFamily: "Lato", fontSize: 21.4, fontWeight: FontWeight.w400)),
        const Padding(padding: EdgeInsets.symmetric(vertical: 7.5)),
        Row(
          children: [
            counterIcon(Icons.remove, onDecrement),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 7.5)),
            Text(initialValue.toString(), style: TextStyle(fontFamily: "Lato", fontSize: 26, fontWeight: FontWeight.w500, color: CustomColor.black80)),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 7.5)),
            counterIcon(Icons.add, onIncrement),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
        )
      ],
    );
  }
  Widget counters() {
    return Column(
      children: [
        counter("Gewicht", _sets[_selectedSet]["weight"]!.toInt(), () => incrementWeight(-1), () => incrementWeight(1)),
        const Padding(padding: EdgeInsets.symmetric(vertical: 39)),
        counter("Wiederholungen", _sets[_selectedSet]["repetitions"]!.toInt(), () => incrementRepetitions(-1), () => incrementRepetitions(1)),
      ],
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
        counters()
      ]
    );
  }
  Widget footer({ required Function newSetButtonOnTap }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () { 
          newSetButtonOnTap(); 
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: widget.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            header(allButtonOnTap: () {}),
            content(widget.session),
            footer(newSetButtonOnTap: () {})
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }  

}