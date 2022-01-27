import 'dart:async';

import "package:flutter/material.dart";
import 'package:training_app/ui/constants.dart';

enum StandardIconType {
  check,
  unfoldMore,
  star,
  close,
  unfoldLess,
  settings,
  add,
  moreVert,
  placeholder
}

enum SmallIconType {
  add,
  remove,
  delete,
  restoreFromTrash,
}

class SmallIconButton extends StatefulWidget {

  const SmallIconButton({ Key? key, 
    required this.iconType, 
    required this.onTap, 
    this.color = Colors.black, 
    this.label, 
    this.onLongPress 
  }) : super(key: key);

  final SmallIconType iconType;
  final Function() onTap;
  final Color color;
  final String? label;
  final Function()? onLongPress;

  @override
  State<SmallIconButton> createState() => _SmallIconButtonState();
}

class _SmallIconButtonState extends State<SmallIconButton> {

  static const double buttonSize = 136.26 / Constants.ratio;
  static const double borderRadius = 20.19 / Constants.ratio;

  static const double fontSize = 42.88 / Constants.ratio;

  double gradientProgression = 0.0; 
  double completionProgression = 0.0;
  bool longPressConfirmed = false;
  Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) { });

  void triggerCompletionGradient() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      final double updatedCompletionProgression = completionProgression += 0.01;
        if(updatedCompletionProgression <= 1.05) {
          setState(() {
            completionProgression = updatedCompletionProgression;
          });
        } else {
          timer.cancel();
        }
    });
  }

  void onTapDown(TapDownDetails e) {
    // not used
  }

  void onTapCancel() {
    // not used
  }

  void onHighlightChanged(bool tapDown) {
    if(longPressConfirmed) return; 

    timer.cancel();

    if(tapDown) {

      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        final double updatedGradientProgression = gradientProgression += 0.01;
        if(updatedGradientProgression <= 1.05 && !longPressConfirmed) {
          setState(() {
            gradientProgression = updatedGradientProgression;
          });
        } else {
          timer.cancel();

          longPressConfirmed = true;
          triggerCompletionGradient();
          widget.onLongPress!();
        }
      });

    } else {

      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        final double updatedGradientProgression = gradientProgression -= 0.025;
        if(updatedGradientProgression > -0.01 && !longPressConfirmed) {
          setState(() {
            gradientProgression = updatedGradientProgression;
          });
        } else {
          timer.cancel();
        }
      });

    }
  }

  LinearGradient progressionGradient() {
    return LinearGradient(
      colors: [
        Colors.transparent,
        widget.color.withOpacity(0.10)
      ],
      stops: [1.0 - gradientProgression, 1.0 - gradientProgression],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter,
      tileMode: TileMode.decal
    );
  }
  LinearGradient completionGradient() {
    return LinearGradient(
      colors: [
        Colors.transparent,
        widget.color.withOpacity(0.125)
      ],
      stops: [1 - completionProgression, 1 - completionProgression],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter,
      tileMode: TileMode.decal
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: buttonSize,
          height: buttonSize,
          decoration: widget.onLongPress != null ? BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: progressionGradient()
          ) : null,
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: widget.onLongPress != null ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: completionGradient()
            ) : null,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Theme(
                data: ThemeData(
                  splashColor: widget.onLongPress != null ? Colors.transparent : null,
                  highlightColor: widget.onLongPress != null ? Colors.transparent : null
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTap: widget.onTap,
                  // onTapDown: widget.onLongPress != null ? onTapDown : null,
                  // onTapCancel: widget.onLongPress != null ? onTapCancel : null,
                  onHighlightChanged: widget.onLongPress != null ? onHighlightChanged : null,
                  child: Center(
                    child: SmallIcon(widget.iconType, color: widget.color),
                  ),
                ),
              ),
            ),
          )
        ),
        widget.label != null ? SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 2.5, left: 0.5),
              child: Text(widget.label!, style: const TextStyle(color: Constants.white, fontFamily: "Lato", fontSize: fontSize, fontWeight: FontWeight.w400)),
            ),
          ),
        ) : Material(),
      ]
    );
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: widget.onTap,
          child: Center(
            child: SmallIcon(widget.iconType, color: widget.color),
          ),
        ),
      )
    );
  }
}


class SmallIcon extends StatelessWidget {

  const SmallIcon(this.iconType, { Key? key, this.color = Colors.black }) : super(key: key);

  final SmallIconType iconType;
  final Color color;

  static const double iconSize = 111.03 / Constants.ratio;

  final Map icons = const <SmallIconType, List<dynamic>> {
    SmallIconType.add: [Icons.add, 68.13 / Constants.ratio],
    SmallIconType.remove: [Icons.remove, 68.13 / Constants.ratio],
    SmallIconType.delete: [Icons.delete, 75.7 / Constants.ratio],
    SmallIconType.restoreFromTrash: [Icons.restore_from_trash, 75.7 / Constants.ratio]
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: Center(
        child: Icon(icons[iconType][0], size: icons[iconType][1], color: color)
      )
    );
  }

}

class StandardIconButton extends StatelessWidget {
  
  const StandardIconButton({ Key? key, required this.icon, this.onTap }) : super(key: key);

  final StandardIconType icon;
  final Function()? onTap;

  static const double buttonSize = 201.78 / Constants.ratio;
  static const double borderRadius = 20.19 / Constants.ratio;

  final Map icons = const <StandardIconType, Widget>{
    StandardIconType.check: Icon(Icons.check, size: 87.09 / Constants.ratio),
    StandardIconType.unfoldMore: Icon(Icons.unfold_more, size: 83.27 / Constants.ratio),
    StandardIconType.star: Icon(Icons.star, size: 73.81 / Constants.ratio),
    StandardIconType.close: Icon(Icons.close, size: 83.27 / Constants.ratio),
    StandardIconType.unfoldLess: Icon(Icons.unfold_less, size: 83.27 / Constants.ratio),
    StandardIconType.settings: Icon(Icons.settings, size: 87.06 / Constants.ratio),
    StandardIconType.add: Icon(Icons.add, size: 99.28 / Constants.ratio),
    StandardIconType.moreVert: Icon(Icons.more_vert, size: 80.75 / Constants.ratio),
    StandardIconType.placeholder: SizedBox()
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Center(
            child: icons[icon],
          ),
        ),
      ),
    );
  }

}

class StandardIcon extends StatelessWidget {

  const StandardIcon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }

}