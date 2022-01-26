import 'package:flutter/material.dart';
import 'package:training_app/pages/create_exercise_page.dart';
import 'package:training_app/pages/test_page_transition.dart';
import 'package:training_app/pages/timeline_page.dart';
import 'package:training_app/pages/v4/create_exercise_page.dart' as v4;
import 'package:training_app/pages/v4/all_exercises_page.dart' as v4;
import 'package:training_app/pages/v5/all_exercises_page.dart' as v5;
import 'package:training_app/pages/v5/exercise_page.dart' as v5;
import 'package:training_app/pages/v5/add_exercise_page.dart' as v5;
import "pages/home.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "training_app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: v5.ExercisePage()
    );
  }

}