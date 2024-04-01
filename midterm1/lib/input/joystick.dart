import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 15,
    paint: BasicPalette.red.withAlpha(200).paint(),
  ),
  background: CircleComponent(
    radius: 60,
    paint: BasicPalette.red.withAlpha(100).paint(),
  ),
  margin: const EdgeInsets.only(left: 40, bottom: 40),
);
