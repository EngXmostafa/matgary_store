import 'package:flutter/material.dart';

enum DialogType {
  success,
  error,
  info,
  warning,
}

Future<void> showCustomDialog(
  BuildContext context, {
  required String title,
  required String message,
  DialogType type = DialogType.info,
  String buttonText = "OK",
  VoidCallback? onPressed,
}) {
  final color = _getColor(type);
  final icon = _getIcon(type);
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => Center(),
    transitionBuilder: (context, animation, secondaryAnimation, _) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        ),
        child: FadeTransition(
          opacity: animation,
          child: AlertDialog(
            title: Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(title),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: onPressed ?? () => Navigator.pop(context),
                child: Text(buttonText, style: TextStyle(color: color)),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Color _getColor(DialogType type) {
  switch (type) {
    case DialogType.success:
      return Colors.green;
    case DialogType.error:
      return Colors.red;
    case DialogType.info:
    case DialogType.warning:
      return Colors.orange;
    default:
      return Colors.blue;
  }
}

IconData _getIcon(DialogType type) {
  switch (type) {
    case DialogType.success:
      return Icons.check_circle;
    case DialogType.error:
      return Icons.error;
    case DialogType.warning:
      return Icons.warning;
    case DialogType.info:
    default:
      return Icons.info_outline;
  }
}
