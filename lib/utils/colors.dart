import 'dart:math';

import 'package:flutter/material.dart';

Color generateRandomColor() {
  final Random random = Random();
  double hue = random.nextDouble() * 360;
  double saturation = 0.5 + random.nextDouble() * 0.5;
  double lightness = 0.4 + random.nextDouble() * 0.3;
  HSLColor hslColor = HSLColor.fromAHSL(1.0, hue, saturation, lightness);
  return hslColor.toColor();
}
