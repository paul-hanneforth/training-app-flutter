import "package:flutter/material.dart";
import 'package:training_app/ui/constants.dart';
import 'package:training_app/ui/icon_button.dart';

class CounterController extends ValueNotifier<num> {

  CounterController() : super(0);

}

class Counter extends StatefulWidget {

  const Counter({ 
    Key? key,
    required this.label,
    required this.initialValue,
    required this.controller,
  }) : super(key: key);

  final String label;
  final num initialValue;
  final CounterController controller;

  @override
  _CounterState createState() => _CounterState();

}

class _CounterState extends State<Counter> {

  static const double smallButtonSize = 136.26 / Constants.ratio;
  static const double headerContentSpacing = 37.85 / Constants.ratio;
  static const double counterElementsSpacing = 25.23 / Constants.ratio;
  static const double textHorizontalPadding = 30.38 / Constants.ratio;
  static const double labelFontSize = 53.99 / Constants.ratio;
  static const double valueFontSize = 65.61 / Constants.ratio;

  @override
  void initState() {
    super.initState();

    widget.controller.value = widget.initialValue;
  }

  void increment(num step) {

    widget.controller.value = widget.controller.value + step;

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.label, style: const TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w400, fontSize: labelFontSize, color: Constants.black55)),
        const SizedBox(height: headerContentSpacing),
        Row(
          children: [
            SmallIconButton(iconType: SmallIconType.remove, onTap: () { increment(-1); }),
            const SizedBox(width: counterElementsSpacing),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  height: smallButtonSize,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: textHorizontalPadding),
                      child: ValueListenableBuilder(
                        valueListenable: widget.controller,
                        builder: (context, dynamic value, widget) {
                          return Text(
                            value.toString(), // value != null ? value.toString() : widget.initialValue.toString(), 
                            style: const TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w500, fontSize: valueFontSize, color: Constants.black80)
                          );
                        }
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: counterElementsSpacing),
            SmallIconButton(iconType: SmallIconType.add, onTap: () { increment(1); })
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
        ),
      ],
    );
  }

}