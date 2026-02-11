import 'package:flutter/material.dart';

extension DoubleExt on double {
  Widget get height {
    return SizedBox(height: toDouble());
  }

  Widget get width {
    return SizedBox(width: toDouble());
  }

  /// 2 digits
  double get toPrecise => double.parse(toStringAsFixed(2));
}
