import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:training_app/pages/all_exercises_page.dart';
import 'package:training_app/ui/constants.dart';
import 'package:training_app/ui/controls.dart';
import 'package:training_app/ui/counter.dart';
import 'package:training_app/ui/faker.dart';
import 'package:training_app/ui/icon_button.dart';
import 'package:training_app/utils/types.dart';

class ExercisePage extends StatefulWidget {

  const ExercisePage({ Key? key }) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();

}

class _ExercisePageState extends State<ExercisePage> {

  List<ExerciseSet> sets = [];
  int activeSetIndex = 0;

  CounterController weightCounterController = CounterController();
  CounterController repetitionsCounterController = CounterController();

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < 2; i++) {

      sets.add(Faker.exerciseSet());

    }

    selectSet(0);

    weightCounterController.addListener(() { setWeight(weightCounterController.value); });
    repetitionsCounterController.addListener(() { setRepetitions(repetitionsCounterController.value.toInt()); });
  }
  
  @override
  void dispose() {
    weightCounterController.dispose();
    repetitionsCounterController.dispose();
    
    super.dispose();
  }

  void setWeight(num weight) {
    final ExerciseSet activeSet = sets[activeSetIndex];
    final ExerciseSet updatedSet = ExerciseSet(repetitions: activeSet.repetitions, weight: weight);
    sets.replaceRange(activeSetIndex, activeSetIndex + 1, [ updatedSet ]);
  }
  void setRepetitions(int repetitions) {
    final ExerciseSet activeSet = sets[activeSetIndex];
    final ExerciseSet updatedSet = ExerciseSet(repetitions: repetitions, weight: activeSet.weight);
    sets.replaceRange(activeSetIndex, activeSetIndex + 1, [ updatedSet ]);
  }

  void unfoldMore() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AllExercisesPage()));
  }
  void done() {
  }
  void gotoPointsOverview() {

  }

  void updateCounters() {
      // update counters
      weightCounterController.value = sets[activeSetIndex].weight;
      repetitionsCounterController.value = sets[activeSetIndex].repetitions;
  }
 
  void selectSet(int targetIndex) {
    setState(() {
      activeSetIndex = targetIndex;

      updateCounters();
    });
  }
  void addSet() {

    final ExerciseSet newSet = Faker.exerciseSet();

    setState(() {
      sets.add(newSet);
      selectSet(sets.length - 1);
    });

  }
  void removeSet(int targetIndex) {
    int? findIndex(List<dynamic> list, int index) {
      if(list.isEmpty) return null;
      if(index < list.length && list.elementAt(index) != null) return index;
      return findIndex(list, index - 1);
    }
    
    setState(() {
      
      sets.removeAt(targetIndex);

      final int? newIndex = findIndex(sets, targetIndex);

      selectSet(newIndex!);

    });
  }


  /* Design */
  Widget content() {
    const headerTextSpacing = 227.1 / Constants.ratio;
    const exerciseSetSelectorSpacing = 105.98 / Constants.ratio;

    return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerText("Brustpresse", ["Brust", "Schultern"]),
              const SizedBox(height: headerTextSpacing),
              exerciseSetSelector(),
              const SizedBox(height: exerciseSetSelectorSpacing),
              counters()
            ],
          ),
        ),
    );
  }
  Widget headerText(String exerciseName, List<String>muscleGroups) {
    const double nameFontSize = 90.84 / Constants.ratio;
    const double muscleGroupsFontSize = 45.42 / Constants.ratio;

    return Column(
      children: [
        Text(exerciseName, style: const TextStyle(
          fontFamily: "Lato",
          fontWeight: FontWeight.w600,
          fontSize: nameFontSize,
        )),
        const SizedBox(height: 35.33 / Constants.ratio),
        Text(muscleGroups.join(", "), style: const TextStyle(
          fontFamily: "Lato",
          fontWeight: FontWeight.w400,
          fontSize: muscleGroupsFontSize,
          color: Constants.black80
        ))
      ],
    );
  }
  Widget exerciseSetSelector() {

    const double borderRadius = 40.37 / Constants.ratio;
    const double borderWidth = 2.52 / Constants.ratio;
    const double setElementsSpacing = 20.19 / Constants.ratio;

    List<Widget> setWidgets = [];

    for(int i = 0; i < sets.length; i ++) {
      setWidgets.add(exerciseSetIndicatorWidget((i + 1), () => selectSet(i), activeSetIndex == i));
    }

    List<Widget> elements = setWidgets;
    elements.add(SmallIconButton(
      iconType: SmallIconType.add,
      onTap: addSet,
      color: Constants.black50,
    ));
    elements = setWidgets.expand((widget) => [
      const SizedBox(width: setElementsSpacing), 
      widget
    ]).toList();
    elements.add(const SizedBox(width: setElementsSpacing));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Constants.black10, width: borderWidth)
        ),
        child: Row(
          children: elements,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
  Widget exerciseSetIndicatorWidget(int label, Function() onTap, [ bool selected = false ]) {
    const double boxSize = 136.26 / Constants.ratio;
    const double numberFontSize = 45.42 / Constants.ratio;

    if(selected) {
    return SmallIconButton(
      iconType: SmallIconType.delete,
      onTap: () {},
      color: const Color(0xFFEB5757),
      label: label.toString(),
      onLongPress: () {},
    );
    }

    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(label.toString(), style: TextStyle(
              fontFamily: "Lato",
              fontWeight: FontWeight.w400,
              fontSize: numberFontSize,
              color: selected ? Constants.black : Constants.black50
            )),
          ),
        ),
      ),
    );
  }
  Widget counters() {
    const double countersSpacing = 123.64 / Constants.ratio;

    return Column(
      children: [
        Counter(label: "Gewicht", initialValue: weightCounterController.value, controller: weightCounterController),
        const SizedBox(height: countersSpacing),
        Counter(label: "Wiederholungen", initialValue: repetitionsCounterController.value, controller: repetitionsCounterController,)
      ],
    );
  }
  Widget controls() {
    return Controls(
      controlsElements: [
        ControlsElement(
          iconType: StandardIconType.unfoldMore,
          onTap: unfoldMore
        ),
        ControlsElement(
          iconType: StandardIconType.check,
          onTap: done
        ),
        ControlsElement(
          iconType: StandardIconType.star,
          onTap: gotoPointsOverview
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            content(),
            controls()
          ],
        ),
      )
    );
  }

}