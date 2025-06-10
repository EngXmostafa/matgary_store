import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.borderRadius,
    this.hintStyle,
    this.borderColor,
    this.isPassword = false,
    required this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: (widget.isPassword) ? !visible : false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.greyColor.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.greyColor.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(
            color:
                widget.borderColor ?? AppColors.secondaryColor.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.greyColor.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.greyColor.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(
            color: AppColors.secondaryColor.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(
              color: AppColors.greyColor,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              fontFamily: "Poppins",
            ),
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              visible = !visible;
            });
          },
          icon: Icon(
            visible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: AppColors.greyColor,
          ),
        )
            : null,
      ),
    );
  }
}
