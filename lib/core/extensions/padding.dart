import 'package:flutter/material.dart';
import 'package:matgary/core/extensions/extensions.dart';


extension padding on Widget {
  Padding hPadding(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.width),
      child: this,
    );
  }

  Padding vPadding(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding.height),
      child: this,
    );
  }


  Padding symPadding(double ver, double hor) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: hor.height,
        vertical: ver.width,
      ),
      child: this,
    );
  }

  Padding allPadding(double padding) {
    return Padding(
      padding: EdgeInsets.all(
        padding,
      ),
      child: this,
    );
  }
  Padding onlyPadding({double bottom=0, double right=0, double left=0,double top=0}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottom, right:right,left: left,top: top,
      ),
      child: this,
    );
  }
}
