import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matgary/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final Color backgroundColor;
  final double borderRadius;
  final void Function() onTap;
  final TextStyle? textStyle;
  final double? width;
  final double? height;

  final Color borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry padding;

  const CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    required this.label,
    required this.onTap,

    this.backgroundColor = Colors.white,

    this.borderRadius = 12.0,
    this.borderColor = Colors.transparent,
    this.borderWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor,
      fontSize: 14.sp,
    );

    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        side: BorderSide(color: borderColor, width: borderWidth ?? 1.0),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[prefixIcon!, SizedBox(width: 8.w)],

          Text(label, style: textStyle ?? defaultStyle),
          if (suffixIcon != null) ...[SizedBox(width: 8.width), suffixIcon!],
        ],
      ),
    );
    if (width != null||height!=null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }
    return button;
  }
}
