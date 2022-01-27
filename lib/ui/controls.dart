import "package:flutter/material.dart";
import 'package:training_app/ui/constants.dart';
import 'package:training_app/ui/icon_button.dart';

class ControlsElement {

  const ControlsElement({ required this.iconType, required this.onTap });

  final StandardIconType iconType;
  final Function() onTap;

}

class Controls extends StatelessWidget {

  const Controls({ Key? key, required this.controlsElements }) : super(key: key);

  final List<ControlsElement?> controlsElements; 

  static const iconButtonPadding = 88.32 / Constants.ratio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(iconButtonPadding),
        child: Row(
          children: controlsElements.map((controlsElement) {
            if(controlsElement != null) {
              return StandardIconButton(
                icon: controlsElement.iconType,
                onTap: controlsElement.onTap
              );
            } else {
              return const StandardIconButton(
                icon: StandardIconType.placeholder,
                onTap: null,
              );
            }
          }).toList(),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

}