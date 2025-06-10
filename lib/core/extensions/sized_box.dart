import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';

extension sized on num {
  Widget vSpace() {
    return SizedBox(
      height: this.height,
    );
  }

  Widget hSpace() {
    return SizedBox(
      width: this.width,
    );
  }
}
