import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/theme/app_colors.dart';

/// Helper for medium text style
TextStyle mediumStyle({required Color color, required double fontSize}) {
  return TextStyle(
    fontWeight: FontWeight.w500,
    color: color,
    fontSize: fontSize.sp,
  );
}

/// Helper for regular text style
TextStyle regularStyle({required Color color, required double fontSize}) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    color: color,
    fontSize: fontSize.sp,
  );
}
typedef FormFieldValidator =String? Function(String?);

class BuildTextField extends StatefulWidget {
  const BuildTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.label,
    this.hint,
    this.isObscured = false,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor,
    this.readOnly = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.validation,
    this.onTap,
    this.borderRadius = 8.0,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final String? label;
  final String? hint;
  final bool isObscured;
  final TextInputType textInputType;
  final Color? backgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator? validation;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  String? _errorText;
  late bool _hidden = widget.isObscured;
 // String? get errorText => _errorText;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius.r),
    borderSide: BorderSide(color: color, width: 1.5),
  );

  void _validate(String val){
    if(widget.validation != null){
      setState(() {
        _errorText= widget.validation!(val);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final effectiveSuffix =
        widget.isObscured
            ? IconButton(
              icon: Icon(
                _hidden ? Icons.visibility_off : Icons.visibility,
                size: 20.sp,
                color: widget.cursorColor ?? AppColors.greyColor,
              ),
              onPressed: () => setState(() => _hidden = !_hidden),
            )
            : widget.suffixIcon;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style:
                widget.labelTextStyle ??
                mediumStyle(color: AppColors.blackColor, fontSize: 16),
          ),
          SizedBox(height: 4.h),
        ],

        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          obscureText: _hidden,
          maxLines: widget.maxLines,
          keyboardType: widget.textInputType,
          style: mediumStyle(color: AppColors.blackColor, fontSize: 16),
          cursorColor: widget.cursorColor ?? AppColors.blackColor,
          onTap: widget.onTap,
          textInputAction:
              widget.nextFocus == null
                  ? TextInputAction.done
                  : TextInputAction.next,
          onChanged: _validate,
          onEditingComplete: () {
            widget.focusNode?.unfocus();
            if (widget.nextFocus != null) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            }
          },

          decoration: InputDecoration(
            filled: true,
            errorText: _errorText,

            fillColor: widget.backgroundColor ?? Colors.grey.withOpacity(0.15),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            hintText: widget.hint,
            hintStyle:
                widget.hintTextStyle ??
                regularStyle(color: AppColors.greyColor, fontSize: 16),
            prefixIcon: widget.prefixIcon,

            suffixIcon: effectiveSuffix,
            border: _border(AppColors.greyColor.withOpacity(0.7)),
            enabledBorder: _border(AppColors.greyColor.withOpacity(0.7)),
            focusedBorder: _border(AppColors.secondaryColor),
            errorBorder: _border(AppColors.secondaryColor),
            focusedErrorBorder: _border(AppColors.secondaryColor),
            disabledBorder: _border(Colors.transparent),
          ),
        ),
      ],
    );
  }
}
