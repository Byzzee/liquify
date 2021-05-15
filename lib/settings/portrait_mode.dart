import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


mixin PortraitMode on StatelessWidget {
  @override
  Widget build(BuildContext context) {
    portraitModeOnly();
    return null;
  }
}

void portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}