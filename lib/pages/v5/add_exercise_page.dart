import "package:flutter/material.dart";
import 'package:training_app/ui/constants.dart';
import 'package:training_app/ui/controls.dart';
import 'package:training_app/ui/icon_button.dart';
import 'package:training_app/utils/types.dart';

class AddExercisePage extends StatefulWidget {

  const AddExercisePage({ Key? key }) : super(key: key);

  @override
  _AddExercisePageState createState() => _AddExercisePageState();

}

class _AddExercisePageState extends State<AddExercisePage> {

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController muscleGroupsTextController = TextEditingController();

  @override
  void dispose() {
    nameTextController.dispose();
    muscleGroupsTextController.dispose();

    super.dispose();
  }

  void cancel() {
    Navigator.of(context).pop(null);
  }

  void submit() {
    final String exerciseName = nameTextController.text;
    final String muscleGroups = muscleGroupsTextController.text;

    final Exercise newExercise = Exercise(name: exerciseName, muscleGroups: muscleGroups.split(","));

    Navigator.of(context).pop(newExercise);
  }

  Widget content() {
    const elementsHorizontalPadding = 100.93 / Constants.ratio;
    const elementsVerticalPadding = 105.23 / Constants.ratio;

    const titleFontSize = 70.65 / Constants.ratio;
    const subtitleFontSize = 60.56 / Constants.ratio;

    const textsSpacing = 60.56 / Constants.ratio;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: elementsHorizontalPadding, vertical: elementsVerticalPadding),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(fontFamily: "Lato", fontSize: titleFontSize, fontWeight: FontWeight.w400, decoration: TextDecoration.none),
              keyboardType: TextInputType.text,
              controller: nameTextController,
              maxLines: null,
              decoration: const InputDecoration(
                isDense: true,
                hintText: "Name",
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
                hintStyle: TextStyle(fontFamily: "Lato", fontSize: titleFontSize, fontWeight: FontWeight.w400, color: Constants.black25, decoration: TextDecoration.none),
              ),
            ),
            const SizedBox(height: textsSpacing),
            TextField(
              style: const TextStyle(fontFamily: "Lato", fontSize: subtitleFontSize, fontWeight: FontWeight.w400, decoration: TextDecoration.none),
              keyboardType: TextInputType.text,
              controller: muscleGroupsTextController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "Muskelgruppen",
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
                hintStyle: TextStyle(fontFamily: "Lato", fontSize: subtitleFontSize, fontWeight: FontWeight.w400, color: Constants.black15, decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget controls() {
    return Controls(
      controlsElements: [
        ControlsElement(
          iconType: StandardIconType.close,
          onTap: cancel
        ),
        ControlsElement(
          iconType: StandardIconType.check,
          onTap: submit
        )
      ],
    );
    // const iconButtonPadding = 105.07 / Constants.ratio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            content(),
            controls()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

}