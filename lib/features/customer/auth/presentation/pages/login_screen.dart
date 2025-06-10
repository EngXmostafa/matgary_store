import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



import '../../../../../core/route/route_name.dart';
import '../../../../../core/services/_index.dart';
import '../../../../../injection_container.dart';
import '../manager/auth_cubit.dart';

import '../widgets/remember_me_widget.dart';
import '/core/constants/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

import '/core/widgets/_index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late AuthCubit _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().clearLoginFields();
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is ErrorLoginState) {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(state.message);
        }
        // if (state is InitialAuthState) return;
        //
        //  sl<LoadingService>().dismiss();

        if (state is SuccessLoginState) {
          EasyLoading.dismiss();
          SnackBarService.showSuccessMessage("Logged in successfully");

          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteNames.mainLayoutScreen,
            (_) => false,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      Image.asset(AppAssets.logo, scale: 5, fit: BoxFit.cover),
                      // const ArrowBack(),
                    ],
                  ).hPadding(0.01),
                ).topLeft,
                0.01.vSpace(),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ).center,
                0.004.vSpace(),
                Text(
                  "Welcome back! Please enter your details.",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,

                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyColor,
                  ),
                ).center,
                0.1.vSpace(),

                BuildTextField(
                  controller: _cubit.loginEmail,
                  backgroundColor: Colors.white,
                  hint: "you@example.com",
                  label: "Email",

                  textInputType: TextInputType.emailAddress,
                  validation: AppValidators.validateEmail,
                ),

                0.01.vSpace(),

                BuildTextField(
                  controller: _cubit.loginPassword,
                  backgroundColor: Colors.white,
                  hint: '*************',
                  label: "Password",
                  validation: AppValidators.validatePassword,
                  isObscured: true,
                  textInputType: TextInputType.text,
                ),
                0.01.vSpace(),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: RememberMeWidget()),
                    Expanded(
                      child: CustomTextButton(
                        text: "Forget Password",
                        callback: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.forgetPasswordScreen,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                0.02.vSpace(),
                CustomElevatedButton(
                  label: "Sign in ",
                  backgroundColor: AppColors.secondaryColor,

                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Optionally show a SnackBar:
                      // SnackBarService.showErrorMessage(
                      //   "Please Enter Valid Credentials.",
                      // );

                      sl<LoadingService>().show();
                      _cubit.login();
                    }
                  },
                ),

                0.02.vSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                    CustomTextButton(
                      text: "Sign up for free",
                      callback:
                          () => Navigator.pushNamed(
                            context,
                            RouteNames.customerSignUpScreen,
                          ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryColor,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
                0.04.vSpace(),
                Label(
                  text: "or sign in with",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    fontFamily: "Poppins",
                  ),
                ).center,
                0.01.vSpace(),
              ],
            ).hPadding(0.08),
          ).hPadding(0.01),
        ).allPadding(10),
      ),
    );
  }
}
