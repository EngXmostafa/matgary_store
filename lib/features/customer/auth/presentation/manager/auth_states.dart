part of "auth_cubit.dart";

abstract class AuthStates {
  const AuthStates();
}

class InitialAuthState extends AuthStates {
  const InitialAuthState();
}

class SuccessLoginState extends AuthStates {
  const SuccessLoginState();
}

class ErrorLoginState extends AuthStates {
  final String message;
  const ErrorLoginState(this.message);
}

class SuccessRegisterState extends AuthStates {
  const SuccessRegisterState();
}

class ErrorRegisterState extends AuthStates {
  final String message;
  const ErrorRegisterState(this.message);
}
class LogoutState extends AuthStates {
  const LogoutState();
}