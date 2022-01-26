import 'dart:async';
import 'dart:ui';

import "package:flutter/material.dart";

class CreateExercisePage extends StatefulWidget {
  const CreateExercisePage({ Key? key }) : super(key: key);

  @override
  _CreateExercisePageState createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      print(MediaQuery.of(context).devicePixelRatio);
      print(MediaQuery.of(context).size);
    });
  }

  Widget header() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Text("Übung hinzufügen", style: TextStyle(fontFamily: "Lato", fontSize: 24, fontWeight: FontWeight.w500)),
      ),
    );
  }
  Widget input(String label, String text) {
    return SizedBox();
  }
  Widget content() {
    return Column(
      children: [

      ],
    );
  }
  Widget footer() {
    return Row(
      children: [

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(),
            content(),
            footer()
          ],
        )
      ),
    );
  }

}