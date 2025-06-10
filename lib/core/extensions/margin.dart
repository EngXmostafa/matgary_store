import 'package:flutter/material.dart';

extension margin on Widget {
  marginBottom(double i) {
    return Container(
      margin: EdgeInsets.only(bottom: i),
      child: this,
    );
  }

  marginTop(double i) {
    return Container(
      margin: EdgeInsets.only(top: i),
      child: this,
    );
  }

  marginLeft(double i) {
    return Container(
      margin: EdgeInsets.only(left: i),
      child: this,
    );
  }

  marginRight(double i) {
    return Container(
      margin: EdgeInsets.only(right: i),
      child: this,
    );
  }

  marginVertical(double i) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: i),
      child: this,
    );
  }

  marginHorizontal(double i) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: i),
      child: this,
    );
  }

  marginAll(double i) {
    return Container(
      margin: EdgeInsets.all(i),
      child: this,
    );
  }

  marginOnly(
      {double bottom = 0, double right = 0, double left = 0, double top = 0}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: bottom,
        right: right,
        left: left,
        top: top,
      ),
      child: this,
    );
  }

  marginSym({double hor = 0, double ver = 0}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hor, vertical: ver),
      child: this,
    );
  }
}
