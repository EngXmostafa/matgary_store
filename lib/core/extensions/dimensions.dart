  import 'package:flutter/material.dart';


import '../../main.dart';

extension dimensions on num {
  double get height =>
      this * MediaQuery.sizeOf(navigatorKey.currentContext!).height;

  double get width =>
      this * MediaQuery.sizeOf(navigatorKey.currentContext!).width;
}
