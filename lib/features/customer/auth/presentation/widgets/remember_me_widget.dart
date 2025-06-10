import 'package:flutter/material.dart';

import '../../../../../core/theme/_index.dart';


class RememberMeWidget extends StatefulWidget {
  final String text;

  const RememberMeWidget({
    super.key,
    this.text = 'Remember Me',
  });

  @override
  _RememberMeWidgetState createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor:
              _isChecked ? AppColors.secondaryColor : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(
              () {
                _isChecked = newValue!;
              },
            );
          },
        ),
        Expanded(
          child: Text(

            widget.text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontFamily: "Poppins",
            ),
          ),
        ),
      ],
    );
  }
}
