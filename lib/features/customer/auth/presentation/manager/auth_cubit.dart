import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/route/route_name.dart';
import '../../../../../core/services/_index.dart';
import '../../../../../main.dart';
import '../../domain/entities/login_request.dart';
import '../../domain/entities/register_request.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
part 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       super(const InitialAuthState());

  // Controllers
  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();
  final TextEditingController registerUsername = TextEditingController();
  final TextEditingController registerEmail = TextEditingController();
  final TextEditingController registerPassword = TextEditingController();
  final TextEditingController registerConfirmPassword = TextEditingController();
  final TextEditingController registerPhone = TextEditingController();
  final TextEditingController registerAddress = TextEditingController();

  Future<bool> login() async {
    final request = LoginRequest(
      email: loginEmail.text.trim(),
      password: loginPassword.text,
    );
    EasyLoading.show();
    final result = await _loginUseCase(request);

    return result.fold(
      (failure) {
        EasyLoading.dismiss();
        final error = (failure as ServerFailure).message ?? 'Login failed';
        // SnackBarService.showErrorMessage(error.message ?? 'Login failed');
        emit(ErrorLoginState(error));
        return false;
      },
      (response) async {
        // Save token locally
        await CacheHelper.setString('Authorization', response.token);

        await CacheHelper.setString('userType', 'customer');
        EasyLoading.dismiss();
        emit(const SuccessLoginState());
        // SnackBarService.showSuccessMessage('Logged in successfully');
        return true;
      },
    );
  }

  Future<void> register() async {
    final request = RegisterRequest(
      userName: registerUsername.text.trim(),
      email: registerEmail.text.trim(),
      password: registerPassword.text,
      confirmPassword: registerConfirmPassword.text,
      phone: registerPhone.text.trim(),
      address: registerAddress.text.trim(),
    );

    //  EasyLoading.show();
    final result = await _registerUseCase(request);

    result.fold(
      (failure) {
        EasyLoading.dismiss();
        final error =
            (failure as ServerFailure).message ?? 'Registration failed';
        emit(ErrorRegisterState(error));

        //  SnackBarService.showErrorMessage(error);
      },
      (_) {
        EasyLoading.dismiss();
        emit(const SuccessRegisterState());
        SnackBarService.showSuccessMessage('Account created successfully');
      },
    );
  }
  Future<void> logout() async {

    await CacheHelper.removeKey('token');
    await CacheHelper.removeKey('userType');
    clearLoginFields();
    clearRegisterFields();
    emit(const LogoutState());
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(RouteNames.firstScreen, (_) => false);
  }

  /// Clears all login form fields
  void clearLoginFields() {
    loginEmail.clear();
    loginPassword.clear();
  }

  /// Clears all registration form fields
  void clearRegisterFields() {
    registerUsername.clear();
    registerEmail.clear();
    registerPassword.clear();
    registerPhone.clear();
    registerAddress.clear();
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
//
// import '../../../../core/errors/server_failure.dart';
// import '../../../../core/services/_index.dart';
// import '../../../../core/services/web_service.dart';
// import '../../data/data_sources/seller_auth_interface_data_source.dart';
// import '../../data/data_sources/seller_remote_data_source.dart';
// import '../../data/repositories/seller_repositories_imp.dart';
// import '../../domain/entities/seller_login_request.dart';
// import '../../domain/entities/seller_register_request.dart';
// import '../../domain/repositories/seller_auth_repository.dart';
// import '../../domain/use_cases/seller_login_use_case.dart';
// import '../../domain/use_cases/seller_register_use_case.dart';
// part 'auth_states.dart';
//
// class AuthCubit extends Cubit<AuthStates> {
//   AuthCubit() : super(const InitialAuthState());
//
//   final WebServices _services = WebServices();
//
//   late LoginUseCase _loginUseCase;
//   late RegisterUseCase _registerUseCase;
//   late AuthRepositories _authRepositories;
//   late AuthInterfaceDataSource _authInterfaceDataSource;
//
//   // Controllers
//   TextEditingController loginEmail = TextEditingController();
//   TextEditingController loginPassword = TextEditingController();
//   TextEditingController registerEmail = TextEditingController();
//   TextEditingController registerPassword = TextEditingController();
//   TextEditingController registerUsername = TextEditingController();
//   TextEditingController registerPhone = TextEditingController();
//   TextEditingController registerAddress = TextEditingController();
//
//   Future<bool> login() async {
//     /// DI | dependency Injection
//     _authInterfaceDataSource = RemoteAuthDataSource(_services.freeDio);
//     _authRepositories = AuthRepositoriesImp(_authInterfaceDataSource);
//     _loginUseCase = LoginUseCase(_authRepositories);
//
//     LoginRequest data = LoginRequest(
//       email: loginEmail.text,
//       password: loginPassword.text,
//     );
//     EasyLoading.show();
//
//     final result = await _loginUseCase.call(data);
//
//     return result.fold(
//       (fail) {
//         var error = fail as ServerFailure;
//
//         SnackBarService.showErrorMessage(error.message ?? "");
//         EasyLoading.dismiss();
//         emit(const ErrorLoginState());
//         return Future.value(false);
//       },
//       (data) {
//         _services.setMobileToken(data.token);
//         EasyLoading.dismiss();
//         emit(const SuccessLoginState());
//         SnackBarService.showSuccessMessage("Logged in successfully");
//         return Future.value(true);
//       },
//     );
//   }
//
//   Future<bool> register() async {
//     /// DI | dependency Injection
//     _authInterfaceDataSource = RemoteAuthDataSource(_services.freeDio);
//     _authRepositories = AuthRepositoriesImp(_authInterfaceDataSource);
//     _registerUseCase = RegisterUseCase(_authRepositories);
//
//     RegisterRequest data = RegisterRequest(
//       email: registerEmail.text,
//       password: registerPassword.text,
//       userName: registerUsername.text,
//       phone: registerPhone.text,
//       address: registerAddress.text,
//       img: "",
//     );
//     EasyLoading.show();
//     final result = await _registerUseCase.call(data);
//
//     return result.fold(
//       (fail) {
//         var error = fail as ServerFailure;
//
//         SnackBarService.showErrorMessage(error.message ?? "");
//         EasyLoading.dismiss();
//         emit(const ErrorRegisterState());
//         return Future.value(false);
//       },
//       (data) {
//         EasyLoading.dismiss();
//         emit(const SuccessRegisterState());
//         SnackBarService.showSuccessMessage("Account successfully created");
//         return Future.value(true);
//       },
//     );
//   }
// }
//
// //
// //     emit(CustomerAuthLoading());
// //     try {
// //       final result = await registerUser(
// //         email: email,
// //         password: password,
// //         username: username,
// //         phone: phone,
// //         address: address,
// //         userType: UserType.customer,
// //         nationalIdImg: img,
// //       );
// //
// //       result.fold(
// //             (failure) => emit(CustomerAuthFailure(failure.message)),
// //             (session) async {
// //           await _saveUserSession(session);
// //           emit(CustomerAuthSuccess(session));
// //         },
// //       );
// //     } catch (e) {
// //       emit(CustomerAuthFailure(e.toString()));
// //     }
// //   }
// //
// //   Future<void> signInWithGoogle() async {
// //     emit(CustomerAuthLoading());
// //     try {
// //       final googleUser = await GoogleSignIn().signIn();
// //       final googleAuth = await googleUser?.authentication;
// //       final token = googleAuth?.idToken;
// //
// //       if (token == null) throw ValidationException("Google token is null");
// //
// //       final result = await googleSignUpCustomer(
// //         googleToken: token,
// //         userType: UserType.customer,
// //       );
// //
// //       result.fold(
// //             (failure) => emit(CustomerAuthFailure(failure.message)),
// //             (session) async {
// //           await _saveUserSession(session);
// //           emit(CustomerAuthSuccess(session));
// //         },
// //       );
// //     } catch (e) {
// //       emit(CustomerAuthFailure(e.toString()));
// //     }
// //   }
// //
// //   Future<void> forgotPassword({EmailAddress? email, PhoneNumber? phone}) async {
// //     emit(CustomerAuthLoading());
// //     try {
// //       await requestPasswordReset(
// //         email: email,
// //         phone: phone,
// //         userType: UserType.customer,
// //       );
// //       emit(CustomerAuthMessage("Verification code sent successfully"));
// //     } catch (e) {
// //       emit(CustomerAuthFailure(e.toString()));
// //     }
// //   }
// //
// //   Future<void> verifyOtp(String code) async {
// //     emit(CustomerAuthLoading());
// //     try {
// //       if (code == "1234") {
// //         emit(CustomerAuthMessage("Code verified successfully"));
// //       } else {
// //         throw ValidationException("Invalid verification code");
// //       }
// //     } catch (e) {
// //       emit(CustomerAuthFailure(e.toString()));
// //     }
// //   }
// //
// //   Future<void> logout() async {
// //     emit(CustomerAuthLoading());
// //     try {
// //       await logoutUser(UserType.customer);
// //       await localStorageService.clearUserData();
// //       emit(CustomerAuthInitial());
// //     } catch (e) {
// //       emit(CustomerAuthFailure(e.toString()));
// //     }
// //   }
// //   Future<void> sendOtpToEmail(String email) async {
// //     emit(CustomerAuthLoading());
// //     try {
// //       await sendOtpUseCase.execute(email);
// //       emit(CustomerAuthMessage("OTP sent to $email"));
// //     } catch (e) {
// //       emit(CustomerAuthFailure("Failed to send OTP: ${e.toString()}"));
// //     }
// //   }
// //   void resendOtp(String email) async {
// //     emit(CustomerAuthLoading());
// //     try {
// //       await sendOtpUseCase.execute(email); // Use the actual SendOtp use case injected
// //       emit(CustomerAuthMessage("OTP has been resent successfully."));
// //     } catch (e) {
// //       emit(CustomerAuthFailure(e.toString()));
// //     }
// //   }
// //
// //   Future<void> _saveUserSession(UserSession session) async {
// //     await localStorageService.saveToken(session.token);
// //     await localStorageService.saveUserType(session.user.userType.userName);
// //   }
// // }
// //
// // class Cubit {
// // }
