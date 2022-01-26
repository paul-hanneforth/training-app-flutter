import "package:flutter/material.dart";
import 'package:training_app/ui/color.dart';


class SingleButtonFooterToolbar extends StatelessWidget {
  final String actionText;
  final Function onTap;
  final IconData actionIcon;

  const SingleButtonFooterToolbar({ Key? key, required this.actionIcon, required this.actionText, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 120,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(actionText, style: TextStyle(fontFamily: "Poppins", fontSize: 18, fontWeight: FontWeight.w500, color: CustomColor.relaxingYellow)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
                  Icon(actionIcon, color: CustomColor.lightRelaxingYellow,)
                ],
              )
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: CustomColor.black10),
          borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      ),
    );
  }
}

class DoubleButtonFooterToolbar extends StatelessWidget {
  final String mainActionText;
  final String littleActionText;
  final IconData mainActionIcon;
  final IconData littleActionIcon;
  final Function mainOnTap;
  final Function littleOnTap;

  const DoubleButtonFooterToolbar({ Key? key, 
    required this.mainActionText,
    required this.littleActionText, 
    required this.mainOnTap, 
    required this.littleOnTap,
    required this.mainActionIcon,
    required this.littleActionIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 72,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                littleOnTap();
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(littleActionIcon, color: CustomColor.black80),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                    Text(littleActionText, style: TextStyle(fontFamily: "Poppins", fontSize: 16, fontWeight: FontWeight.w500, color: CustomColor.black80)),
                  ],
                )
              )
            )
          )
        ),
        SingleButtonFooterToolbar(actionIcon: mainActionIcon, onTap: mainOnTap, actionText: mainActionText)
      ]
    );
  }
}