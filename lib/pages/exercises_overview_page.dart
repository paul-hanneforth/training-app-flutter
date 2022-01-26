import 'package:flutter/material.dart';
import 'package:training_app/pages/create_exercise_page.dart';
import 'package:training_app/pages/exercise_summary_page.dart';
import 'package:training_app/ui/color.dart';
import 'package:training_app/ui/footer_toolbar.dart';
import 'package:training_app/utils/types.dart';

class ExercisesOverviewPage extends StatefulWidget {
  const ExercisesOverviewPage({ Key? key }) : super(key: key);

  @override
  _ExercisesOverviewPageState createState() => _ExercisesOverviewPageState();
}
class _ExercisesOverviewPageState extends State<ExercisesOverviewPage> {

  double contentWidth = 328;

  OutlineInputBorder textFieldOutlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: CustomColor.black10, width: 1.0)
  );
  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        width: contentWidth, // 368
        height: 70, // 70
        child: TextField(
          obscureText: false,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: CustomColor.black15,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400
            ),
            labelStyle: TextStyle(
              color: CustomColor.black15,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400
            ),
            labelText: "Search for exercise",
            focusedBorder: textFieldOutlineInputBorder,
            enabledBorder: textFieldOutlineInputBorder,
            disabledBorder: textFieldOutlineInputBorder,
            border: textFieldOutlineInputBorder,
            prefixIcon: Icon(Icons.search, color: CustomColor.black20)
          ),
          style: TextStyle(
            color: CustomColor.black90,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400
          ),
        )
      ),
    );
  }

  static List<Widget> recommendedExercisesWidgets = [
    /*
    exerciseWidget("Brustpresse", "Brust, Rücken"),
    exerciseWidget("Latzug", "Bizeps, Rücken"),
    */
  ];
  static List<Widget> allExercisesWidgets = [
    /*
    exerciseWidget("Brustpresse", "Brust, Rücken"),
    exerciseWidget("Sit-Ups", "Bizeps, Rücken"),
    exerciseWidget("Beinpresse", "Beine"),
    exerciseWidget("Trizepsstrecken", "Trizeps"),
    */
  ];

  Widget exerciseWidget(Exercise exercise) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) { return ExerciseSummaryPage(exercise: exercise); }));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Text(exercise.name, style: TextStyle(fontFamily: "Poppins", fontSize: 24, fontWeight: FontWeight.w500, color: CustomColor.black90 )),
              const Padding(padding: EdgeInsets.only(left: 6, right: 6)),
              Text(exercise.muscleGroups.join(", "), style: TextStyle(fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w500, color: CustomColor.black60 )),
            ],
          ),
        ),
      ),
    );
  }

  Widget content() {
    return Expanded(
      child: SizedBox(
        width: contentWidth,
        child: ListView.builder(
          itemCount: recommendedExercisesWidgets.length + allExercisesWidgets.length + 4,
          itemBuilder: (context, index) {
            if(index == 0) {
              return const Padding(padding: EdgeInsets.only(top: 16));
            } else if(index == 1) {
              return Text("Vorgeschlagen", style: TextStyle(fontFamily: "Poppins", fontSize: 18, fontWeight: FontWeight.w400, color: CustomColor.welcomingBlue));
            } else if(index == (2 + recommendedExercisesWidgets.length)) {
              return const Padding(padding: EdgeInsets.only(top: 16));
            } else if(index == (3 + recommendedExercisesWidgets.length)) {
              return Text("Alle", style: TextStyle(fontFamily: "Poppins", fontSize: 20, fontWeight: FontWeight.w400, color: CustomColor.darkerGreen));
            } else {

              int recommendedIndex = index - 2;
              int allIndex = index - 2 - recommendedExercisesWidgets.length - 2;

              if(index > 1 && index <= (1 + recommendedExercisesWidgets.length)) { 
                return recommendedExercisesWidgets[recommendedIndex];
              } else {
                return allExercisesWidgets[allIndex];
              }

            }
          },
        ),
      ),
    );
  }

  Widget footer() {
    return SingleButtonFooterToolbar(actionIcon: Icons.add, actionText: "Neue Übung erstellen", onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) { return const CreateExercisePage(); }));
    });
  }

  Widget exerciseToWidget(Exercise exercise) {
    return exerciseWidget(exercise);
  }

  @override
  void initState() {
    super.initState();

    /* final List<ExerciseSet> sets = [
      ExerciseSet(repetitions: 10, weight: 45, unit: WeightUnit.kilogram),
      ExerciseSet(repetitions: 9, weight: 60, unit: WeightUnit.kilogram),
      ExerciseSet(repetitions: 10, weight: 50, unit: WeightUnit.kilogram)
    ];

    final List<Exercise> recommendedExercises = [
      Exercise(name: "Brustpresse", muscleGroups: ["Brust", "Rücken"], sets: sets),
      Exercise(name: "Latzug", muscleGroups: ["Bizeps", "Rücken"], sets: sets),
    ];
    final List<Exercise> allExercises = [
      Exercise(name: "Liegestützte", muscleGroups: ["Brust", "Rücken"], sets: sets),
      Exercise(name: "Sit-Ups", muscleGroups: ["Bizeps", "Rücken"], sets: sets),
      Exercise(name: "Beinpresse", muscleGroups: ["Beine"], sets: sets),
      Exercise(name: "Trizepsstrecken", muscleGroups: ["Trizeps"], sets: sets),
    ];

    setState(() {
      recommendedExercisesWidgets = recommendedExercises.map((exercise) => exerciseToWidget((exercise))).toList();
      allExercisesWidgets = allExercises.map((exercise) => exerciseToWidget((exercise))).toList();
    }); */

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Column(
          children: [
            searchBar(),
            content(),
            footer()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      )
    );
  }

}