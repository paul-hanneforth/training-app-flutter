import 'dart:ui';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:training_app/ui/color.dart';

class CreateExercisePage extends StatefulWidget {
  const CreateExercisePage({ Key? key }) : super(key: key);

  @override
  _CreateExercisePageState createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {

  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void submit() {
    final String exerciseName = textController.text;
    print(exerciseName);
  }

  Widget header() {
    const double inputPadding = 125 / 2.8125;
    const double fontSize = 70.65 / 2.8125;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(inputPadding),
        child: TextField(
          style: const TextStyle(fontFamily: "Lato", fontSize: fontSize, fontWeight: FontWeight.w400, decoration: TextDecoration.none),
          keyboardType: TextInputType.text,
          controller: textController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Name",
            border: InputBorder.none,
            hintStyle: TextStyle(fontFamily: "Lato", fontSize: fontSize, fontWeight: FontWeight.w400, color: CustomColor.black25, decoration: TextDecoration.none),
          ),
        )
      ),
    );
  }

  Widget iconButton(double size, IconData icon, double iconSize, Function() onTap) {
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: iconSize),
        ),
      ),
    );
  }

  Widget footer() {
    const double buttonPadding = 75 / 2.8125;
    const double buttonSize = 200 / 2.8125;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: buttonPadding),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: buttonPadding),
              child: iconButton(buttonSize, Icons.close, 83.4 / 2.8125, cancel),
            ),
            Padding(
              padding: const EdgeInsets.only(right: buttonPadding),
              child: iconButton(buttonSize, Icons.check, 76 / 2.8125, submit)
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            footer()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
      ),
    );
  }

}