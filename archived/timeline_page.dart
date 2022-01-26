import 'dart:async';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:training_app/ui/color.dart';
import 'package:training_app/utils/types.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({ Key? key }) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {

  int _weight = 45;
  int _repetitions = 10;

  int activeIndex = 0;
  List<Exercise> exercises = [];

  void incrementWeight(int by) {
    int newWeight = _weight + by;
    if(newWeight < 0) return;

    setState(() {
      _weight = newWeight;
    });
  }
  void incrementRepetitions(int by) {
    int newRepetitions = _repetitions + by;
    if(newRepetitions < 0) return;

    setState(() {
      _repetitions = newRepetitions;
    });
  }

  void dragStart(DragStartDetails e) {
    print("start");
    print(e.localPosition);
    print(e.globalPosition);
  }
  void dragEnd(DragEndDetails e) {
    print("end");
    print(e.velocity);
    print(e.primaryVelocity);
  }
  void dragDown(DragDownDetails e) {
    print("down");
    print(e.localPosition);
    print(e.globalPosition);
  }
  void dragUpdate(DragUpdateDetails e) {
    print("update");
    print(e.localPosition);
    print(e.globalPosition);
  }

  Widget header() {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => print("Test"),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
              child: Text("Alle (20)", style: TextStyle(fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w500)),
            ),
          ),
        )
      ],
    );
  }

  Widget info() {
    return Column(
      children: const [
        Text("Gestern", style: TextStyle(fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w400, color: Color(0x99000000))),
        Text("Brustpresse", style: TextStyle(fontFamily: "Lato", fontSize: 36, fontWeight: FontWeight.w600)),
        Padding(padding: EdgeInsets.symmetric(vertical: 7)),
        Text("Brust, Schultern", style: TextStyle(fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xCC000000))),
      ],
    );
  }
  Widget setSelectorElement(String label, bool selected) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => print("now!"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(label, style: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w400, fontSize: 18, color: selected ? Colors.black : const Color(0xA6000000))),
        ),
      ),
    );
  }
  Widget setSelector() {
    return Container(
      child: Row(
        children: [
          setSelectorElement("1", false),
          setSelectorElement("2", false),
          setSelectorElement("3", false),
          setSelectorElement("4", true)
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: CustomColor.black10),
      ),
    );
  }
  Widget sets() {
    return Column(
      children: [
        setSelector()
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
  Widget counterIcon(IconData icon, Function onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(10), child: Icon(icon, size: 24)
        )
      ),
    );
  }
  Widget counter(String label, int initialValue, Function onDecrement, Function onIncrement) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontFamily: "Lato", fontSize: 21.4, fontWeight: FontWeight.w400)),
        const Padding(padding: EdgeInsets.symmetric(vertical: 7.5)),
        Row(
          children: [
            counterIcon(Icons.remove, onDecrement),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 7.5)),
            Text(initialValue.toString(), style: TextStyle(fontFamily: "Lato", fontSize: 26, fontWeight: FontWeight.w500, color: CustomColor.black80)),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 7.5)),
            counterIcon(Icons.add, onIncrement),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
        )
      ],
    );
  }
  Widget counters() {
    return Column(
      children: [
        counter("Gewicht", _weight, () => incrementWeight(-1), () => incrementWeight(1)),
        const Padding(padding: EdgeInsets.symmetric(vertical: 39)),
        counter("Wiederholungen", _repetitions, () => incrementRepetitions(-1), () => incrementRepetitions(1)),
      ],
    );
  }
  Widget content() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 9)),
        info(),
        const Padding(padding: EdgeInsets.symmetric(vertical: 45)),
        sets(),
        const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
        counters()
      ]
    );
  }

  Widget footer() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () { 
          print("Clicked footer!"); 
          /* Navigator.of(context).push(
            CupertinoPageRoute(  
              fullscreenDialog: true,
              builder: (context) {
                return TimelinePage();
              },
            ),
          ); */
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => new TimelinePage(),
            transitionsBuilder: (context, Animation animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              // animation.drive(Animatable())

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            }
          ));
        },
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 125,
            child: Center(
              child: Row(
                children: [
                  const Text("Neuer Satz", style: TextStyle(fontFamily: "Lato", fontSize: 21, fontWeight: FontWeight.w500)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
                  Icon(Icons.add, color: CustomColor.black80)
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              )
            ),
        ),
      ),
    );
  }

  Widget page1() {
    return Container(
      // color: Colors.blue,
      color: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            header(),
            content(),
            footer()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
  Widget page2() {
    return Container(
      // color: Colors.blue,
      color: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            header(),
            content(),
            footer()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
  Widget page3() {
    return Container(
      // color: Colors.blue,
      color: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            header(),
            content(),
            footer()
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

  Widget child = Container();

  void _onHorizontalSwipe(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      setState(() {
        child = page1();
      });
    } else {
      setState(() {
        child = page2();
      });
    }
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    int index = 0;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      print(Scrollable.of(context)?.position.pixels);
    });

    Timer.periodic(const Duration(seconds: 30), (timer) {
      if(index == 2) {
        index = 0;
      } else {
        index ++;
      }
      itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2D4),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          print(notification.scrollDelta);
          print(notification.metrics.pixels);
          return true;
        },
        child: ScrollablePositionedList.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            if(index == 0) {
              return page1();
            } else if(index == 1) {
              return page2();
            } else if(index == 3) {
              return page3();
            }
            return page3();
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
        ),
      )
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2D4),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                .animate(animation),
            child: child,
          );
        },
        layoutBuilder: (currentChild, _) {
          if(currentChild != null) {
            return currentChild;
          } else {
            throw "error!";
          }
        },
        child: Dismissible(
          key: UniqueKey(),
          resizeDuration: null,
          onDismissed: _onHorizontalSwipe,
          direction: DismissDirection.horizontal,
          child: child,
        ),
      )
      /* body: GestureDetector(
        onVerticalDragStart: dragStart,
        onVerticalDragDown: dragDown,
        onVerticalDragEnd: dragEnd,
        onVerticalDragUpdate: dragUpdate,
        child: Container(
          // color: Colors.blue,
          color: Colors.transparent,
          child: SafeArea(
            child: Column(
              children: [
                header(),
                content(),
                footer()
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
      ) */
    );
  }

}