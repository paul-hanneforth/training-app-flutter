import 'package:flutter/gestures.dart';

class CustomGestureRecognizer extends OneSequenceGestureRecognizer {
  final Function onEvent;

  CustomGestureRecognizer({
    required this.onEvent
  });

  @override
  void addPointer(PointerEvent event) {
    if (onEvent(event)) {
      startTrackingPointer(event.pointer);
      resolve(GestureDisposition.accepted);
    } else {
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      onEvent(event);
    }
    if (event is PointerUpEvent) {
      onEvent(event);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'customPan';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}