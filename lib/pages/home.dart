// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:training_app/pages/activities_timeline_page.dart';
import 'package:training_app/pages/exercises_overview_page.dart';
import 'package:training_app/ui/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navIndex = 0;

  Widget content() {
    if (navIndex == 0) return ExercisesOverviewPage();
    if (navIndex == 1) return ActivitiesTimelinePage();

    return Container();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.backgroundColor,
      body: content(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            navIndex = index;
          });
        },
        currentIndex: navIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "exercises overview"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "timeline")
        ]
      ),
    );
  }
}
