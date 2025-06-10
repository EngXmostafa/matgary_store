class RegisterRequest {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final String address;

  RegisterRequest({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.address,

  });

  Map<String, dynamic> toJson() {
    return {
      "name": userName,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "phone": phone,
      "address": address,

    };
  }
}
