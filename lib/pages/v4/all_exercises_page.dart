import "package:flutter/material.dart";

class AllExercisesPage extends StatefulWidget {
  const AllExercisesPage({ Key? key }) : super(key: key);

  @override
  _AllExercisesPageState createState() => _AllExercisesPageState();
}

class _AllExercisesPageState extends State<AllExercisesPage> {

  final double exerciseWidth = 340;

  Widget seperator() {
    return Container(
      width: exerciseWidth,
      height: 1,
      color: const Color(0x26000000),
    );
  }
  Widget exercise() {
    return Container(
      width: exerciseWidth,
      height: 100,
      child: Row(
        children: [
          Column(
            children: [
              Text("Latzug", style: const TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w600, fontSize: 28)),
              const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
              Text("Rücken, Bizeps", style: const TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w500, fontSize: 18, color: Color(0x80000000)))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () { print("Test"); },
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.more_vert, size: 32),
                  ),
                ),
              )
            ],
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget exerciseWithSeperator({ bool bottomSeperator = false }) {
    return Column(
      children: [
          seperator(),
          Padding(padding: EdgeInsets.symmetric(vertical: 6)),
          exercise(),
          Padding(padding: EdgeInsets.symmetric(vertical: 6)),
          bottomSeperator ? seperator() : const SizedBox()
      ],
    );
  }

  Widget body() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 18)),
        exerciseWithSeperator(),
        exerciseWithSeperator(),
        exerciseWithSeperator(bottomSeperator: true),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
    );
  }

  Widget iconButton(IconData icon, double size) {
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: InkWell(
        onTap: () { print("Click!"); },
        child: SizedBox(
          width: 57,
          height: 57,
          child: Icon(icon, size: size),
        ),
      ),
    );
  }
  Widget footer() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 43),
        child: Row(
          children: [
            iconButton(Icons.close_fullscreen, 32),
            iconButton(Icons.add, 32),
            iconButton(Icons.settings, 26),
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            body(),
            footer()
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}