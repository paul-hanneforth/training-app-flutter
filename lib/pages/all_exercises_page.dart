import "package:flutter/material.dart";
import 'package:training_app/pages/add_exercise_page.dart';
import 'package:training_app/ui/constants.dart';
import 'package:training_app/ui/controls.dart';
import 'package:training_app/ui/faker.dart';
import 'package:training_app/ui/icon_button.dart';
import 'package:training_app/utils/types.dart';

class AllExercisesPage extends StatefulWidget {

  const AllExercisesPage({ Key? key }) : super(key: key);

  @override
  _AllExercisesPageState createState() => _AllExercisesPageState();

}

class _AllExercisesPageState extends State<AllExercisesPage> {

  List<Exercise> exercises = [];

  @override
  void initState() {
    super.initState();

    print("AllExercisesPage is loading ...");

    for(int i = 0; i < 4; i ++) {
      exercises.add(Faker.exercise());
    }
  }

  void addExercise() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddExercisePage()));
  }
  void unfoldLess() {
    Navigator.of(context).pop();
  }
  void gotoSettings() {
  }

  /* Design */
  static const double exerciseWidgetWidth = 878.13 / Constants.ratio;

  Widget exerciseWidget(String name, List<String> muscleGroups) {
    const double nameFontSize = 70.65 / Constants.ratio;
    const double muscleGroupsFontSize = 45.42 / Constants.ratio;
    const double textSpacing = 30.28 / Constants.ratio;
    const double widgetVerticalWhitespace = 25.23 / Constants.ratio;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: widgetVerticalWhitespace),
      child: SizedBox(
        width: exerciseWidgetWidth,
        child: Row(
          children: [
            Column(
              children: [
                Text(name, style: const TextStyle(fontFamily: "Lato", fontSize: nameFontSize, fontWeight: FontWeight.w600)),
                const SizedBox(height: textSpacing),
                Text(muscleGroups.join(", "), style: const TextStyle(fontFamily: "lato", fontSize: muscleGroupsFontSize, fontWeight: FontWeight.w500, color: Constants.black50))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            PopupMenuButton(
              onSelected: (String selected) {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              tooltip: "See options",
              itemBuilder: (BuildContext context) {
                return ["Edit", "Delete"].map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice, style: const TextStyle(fontFamily: "Lato", fontSize: muscleGroupsFontSize, fontWeight: FontWeight.w400)),
                  );
                }).toList();
              },
              child: const StandardIconButton(icon: StandardIconType.moreVert)
            ),
            // StandardIconButton(icon: StandardIconType.moreVert, onTap: () {})
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
  Widget exerciseSeperator() {
    const double seperatorHeight = 5.05 / Constants.ratio;
    const double seperatorPadding = 40.37 / Constants.ratio;
    const double seperatorBorderRadius = 17.66 / Constants.ratio;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: seperatorPadding),
      child: Container(
        width: exerciseWidgetWidth,
        height: seperatorHeight,
        decoration: BoxDecoration(
          color: Constants.black10,
          borderRadius: BorderRadius.circular(seperatorBorderRadius)
        ),
      ),
    );
  }
  Widget exercisesWidget() {
    double whiteSpaceAround = (MediaQuery.of(context).size.width - exerciseWidgetWidth) / 2;
    
    List<Widget> children = exercises.map((exercise) => exerciseWidget(exercise.name, exercise.muscleGroups)).toList().expand((Widget _) => [_, exerciseSeperator()]).toList();
    children.removeLast();

    return Padding(
      padding: EdgeInsets.all(whiteSpaceAround),
      child: Column(
        children: children
      ),
    );
  }
  Widget controls() {
    return Controls(
      controlsElements: [
        ControlsElement(
          iconType: StandardIconType.unfoldLess,
          onTap: unfoldLess
        ),
        ControlsElement(
          iconType: StandardIconType.add,
          onTap: addExercise
        ),
        ControlsElement(
          iconType: StandardIconType.settings,
          onTap: gotoSettings
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            exercisesWidget(),
            controls()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }

}