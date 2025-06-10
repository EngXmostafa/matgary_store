import 'package:flutter/material.dart';
import 'package:matgary/core/extensions/extensions.dart';

import '../theme/app_colors.dart';

class ArrowBack extends StatelessWidget {
  final Function()? callBack;
  final Color? iconColor;
  final double? radius;
  final Color? bgColor;

  const ArrowBack({
    super.key,
    this.callBack,
    this.iconColor,
    this.radius,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 25,
      backgroundColor: bgColor ?? AppColors.snowGrey,
      child: IconButton(
        onPressed: callBack ?? ()=> Navigator.pop(context),
        icon: Icon(

          Icons.arrow_back_ios,
          textDirection:TextDirection.ltr ,
          color: iconColor ?? AppColors.blackColor.withOpacity(0.75),
        ).center,
      ),
    );
  }
}
