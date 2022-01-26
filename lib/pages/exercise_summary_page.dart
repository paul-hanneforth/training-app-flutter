import "package:flutter/material.dart";
import 'package:training_app/ui/color.dart';
import 'package:training_app/ui/footer_toolbar.dart';
import 'package:training_app/utils/types.dart';

class ExerciseSummaryPage extends StatefulWidget {
  final Exercise exercise;

  const ExerciseSummaryPage({ Key? key, required this.exercise }) : super(key: key);

  @override
  _ExerciseSummaryPageState createState() => _ExerciseSummaryPageState();
}

class _ExerciseSummaryPageState extends State<ExerciseSummaryPage> {

  Widget header() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 75,
      child: Center(
        child: Text(widget.exercise.name, style: TextStyle(fontFamily: "Poppins", fontSize: 18, color: CustomColor.black, fontWeight: FontWeight.w400)),
      ),
    );
  }

  Widget infoContainer(String property, String value) {
    return Column(
      children: [
        Text(property, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w400, fontSize: 21, color: CustomColor.black)),
        const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
        Text(value, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 27, color: CustomColor.black)),
      ],
    );
  }
  Widget content() {
    return Container();
    /* final ExerciseSet bestWeight = (widget.exercise.sets..sort((a, b) {
      if(a.weight < b.weight) return 1;
      return -1;
    }))[0];
    final int averageRepetitions = (widget.exercise.sets.fold(0, (acc, set) {
      if(acc == null) return set.repetitions;
      return (acc as int) + set.repetitions;
    }) / widget.exercise.sets.length).round();

    return Column(
      children: [
        infoContainer("bestes Gewicht", bestWeight.weight.round().toString() + bestWeight.getUnitAsString()),
        const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
        infoContainer("durchschn. Widerholungen", averageRepetitions.toString())
      ],
    ); */
  }

  Widget footer() {
    return DoubleButtonFooterToolbar(mainActionIcon: Icons.arrow_forward, littleActionIcon: Icons.arrow_back, mainActionText: "Set hinzufügen", littleActionText: "Zurück", mainOnTap: () {

    }, littleOnTap: () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            content(),
            footer()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
      ),
    );
  }

}