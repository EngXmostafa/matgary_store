import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class Label extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextStyle? style;

  const Label({
    super.key,
    required this.text,
    this.style,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextStyle(
            fontSize: fontSize ?? 16,
            fontWeight: style?.fontWeight ??FontWeight.w500,
            color: AppColors.blackColor,
          ),
    );
  }
}
