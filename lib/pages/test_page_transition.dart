import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestPageTransition extends StatefulWidget {

  const TestPageTransition({ Key? key }) : super(key: key);

  @override
  _TestPageTransitionState createState() => _TestPageTransitionState();

}

class _TestPageTransitionState extends State<TestPageTransition> {

  Future<void> scrollToIndex(ItemScrollController scrollController, int index, {
    Duration duration = const Duration(milliseconds: 500 /*1000*/),
    Curve curve = Curves.easeInOutCubic
  }) async {
    await Future.delayed(const Duration(milliseconds: 10));
    await scrollController.scrollTo(
      index: index,
      duration: duration,
      curve: curve
    );
  }

  void onUpdate(DragUpdateDetails e) {
    print(e.globalPosition);
  }
  void onEnd(DragEndDetails e) {
    print("end");
    scrollToIndex(scrollController, 0);
  }
  void onDown(DragDownDetails e) {
  }

  ItemScrollController scrollController = ItemScrollController();
  ItemPositionsListener positionListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    positionListener.itemPositions.addListener(() {
      List<ItemPosition> positions = positionListener.itemPositions.value.toList();
      print(positions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
        SizedBox.expand(
          child: RawGestureDetector(
            gestures: {
              AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleGestureRecognizer>(() => AllowMultipleGestureRecognizer(), (AllowMultipleGestureRecognizer instance) {
                instance.onUpdate = onUpdate;
                instance.onEnd = onEnd;
                instance.onDown = onDown;
              }) 
            },
            behavior: HitTestBehavior.translucent,
            child: AbsorbPointer(
              absorbing: false,
              child: ScrollablePositionedList.builder(
                // physics: const NeverScrollableScrollPhysics(),
                initialScrollIndex: 0,
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: index == 0 ? Colors.red : Colors.blue,
                  );
                },
                itemScrollController: scrollController,
                itemPositionsListener: positionListener,
              ),
            ),
          ),
        ),
    );
  }

}

class AllowMultipleGestureRecognizer extends PanGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class MultipleGestureDetector extends InheritedWidget {
  final void Function()? onUpdate;

  const MultipleGestureDetector({
    Key? key,
    required Widget child,
    required this.onUpdate,
  }) : super(key: key, child: child);

  static MultipleGestureDetector? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MultipleGestureDetector>();
  }

  @override
  bool updateShouldNotify(MultipleGestureDetector oldWidget) => false;
}