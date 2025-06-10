import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class LoadingService{
void init() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor = Colors.white
    ..textColor = Colors.white
    ..indicatorColor = const Color(0xFFE00800)
    ..userInteractions = false
    ..dismissOnTap = false;
}
  /// Show the loading indicator. Optionally pass a status message.
  void show({String? status}) => EasyLoading.show(status: status);

  /// Hide the loading indicator.
  void dismiss() => EasyLoading.dismiss();
}
