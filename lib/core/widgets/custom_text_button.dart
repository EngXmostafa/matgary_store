import 'package:flutter/material.dart';

import '../theme/app_colors.dart';


typedef OnPressed = void Function()?;

class CustomTextButton extends StatelessWidget {
  final OnPressed callback;
  final String text;
  final TextStyle? style;

  const CustomTextButton({
    super.key,
    this.callback,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: callback ?? (){},
      child: Text(
        text,
        style: style ??
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.richBlack,
              fontFamily: "Poppins",
            ),
      ),
    );
  }
}
