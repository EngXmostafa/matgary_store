abstract class Validations {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Email can’t be empty';
    final email = value.trim();
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(email)) return 'Please enter a valid email';
    return null;
  }


  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty)
      return 'Password can’t be empty';
    if (value.length < 8)
      return 'Must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value))
      return 'Must contain an uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(value))
      return 'Must contain a lowercase letter';
    if (!RegExp(r'\d').hasMatch(value))
      return 'Must contain a digit';
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value))
      return 'Must contain a special character (!@#\$&*~)';
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Phone number can’t be empty';
    final digits = value.trim().replaceAll(' ', '');
    if (!RegExp(r'^\d{7,15}$').hasMatch(digits))
      return 'Enter a valid phone number (7–15 digits)';
    return null;
  }


  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Username can’t be empty';
    if (value.trim().length < 3)
      return 'Must be at least 3 characters';
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value))
      return 'Only letters, numbers, and underscores allowed';
    return null;
  }
}
