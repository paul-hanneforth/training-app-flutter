import "package:flutter/material.dart";
import 'package:training_app/ui/color.dart';
import 'package:training_app/ui/footer_toolbar.dart';

class CreateExercisePage extends StatefulWidget {
  const CreateExercisePage({ Key? key }) : super(key: key);

  @override
  _CreateExercisePageState createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {

  Widget input() {
    return const SizedBox();
  }
  Widget exerciseName() {
    return Column(
      children: const [
        Text("Übung Name", style: TextStyle(fontFamily: "Poppins", fontSize: 18, fontWeight: FontWeight.w400)),

      ]
    );
  }
  Widget muscleGroups() {
    return Column(

    );
  }

  Widget content() {
    return Column(
      children: [
        exerciseName(),
        muscleGroups()
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [

            content(),
            DoubleButtonFooterToolbar(
              littleActionIcon: Icons.arrow_back,
              littleActionText: "Zurück",
              littleOnTap: () {
                Navigator.of(context).pop();
              },
              mainActionIcon: Icons.arrow_forward,
              mainActionText: "Abschließen",
              mainOnTap: () {

              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

}