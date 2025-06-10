import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:matgary/core/extensions/extensions.dart';



import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/route/route_name.dart';
import '../../../../../core/services/_index.dart';
import '../../../../../core/theme/_index.dart';
import '../../../../../core/widgets/_index.dart';
import '../manager/auth_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _confirmPasswordController = TextEditingController();
  bool _acceptedPolicy = false;
  late AuthCubit _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().clearRegisterFields();
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
        EasyLoading.dismiss();

        if (state is SuccessRegisterState) {
          SnackBarService.showSuccessMessage('Account created—please log in');
          Navigator.pushReplacementNamed(context, RouteNames.customerLoginScreen);
        }
        if (state is ErrorRegisterState) {
          SnackBarService.showErrorMessage(state.message);
        }
      },

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               0.09.vSpace(),
              // ArrowBack(),
              Image.asset(
                AppAssets.logo,
                scale: 4,
                // height: 80,
                // width: 80,
                fit: BoxFit.cover,
              ).center,
              0.001.vSpace(),

              Label(
                text: "Create an Account",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 34,
                  color: AppColors.blackColor,
                ),
              ).center,
              0.001.vSpace(),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    BuildTextField(
                      controller: _cubit.registerUsername,
                      backgroundColor: Colors.white,
                      hint: "Enter your UserName",
                      label: "UserName",
                      textInputType: TextInputType.name,
                      validation: AppValidators.validateUsername,
                    ),
                    0.01.vSpace(),

                    BuildTextField(
                      controller: _cubit.registerEmail,
                      backgroundColor: Colors.white,
                      hint: "you@example.com",
                      label: "Email",
                      textInputType: TextInputType.emailAddress,
                      validation: AppValidators.validateEmail,
                    ),
                    0.01.vSpace(),

                    BuildTextField(
                      controller: _cubit.registerPhone,
                      backgroundColor: Colors.white,
                      hint: "01000000000",
                      label: "Phone Number",
                      textInputType: TextInputType.phone,
                      validation: AppValidators.validatePhoneNumber,
                    ),
                    0.01.vSpace(),

                    BuildTextField(
                      controller: _cubit.registerAddress,
                      backgroundColor: Colors.white,
                      hint: "your Address",
                      label: "Address",
                      textInputType: TextInputType.streetAddress,
                      validation:
                          (val) =>
                              (val == null || val.isEmpty)
                                  ? "Address can't be empty"
                                  : null,
                    ),
                    0.01.vSpace(),

                    BuildTextField(
                      controller: _cubit.registerPassword,
                      backgroundColor: Colors.white,
                      hint: "Must be 8 characters",
                      label: "Password",
                      textInputType: TextInputType.text,
                      validation: AppValidators.validatePassword,
                      isObscured: true,
                    ),

                    0.01.vSpace(),
                    BuildTextField(
                      controller: _confirmPasswordController,
                      backgroundColor: Colors.white,
                      hint: "Repeat password",
                      label: "Confirm Password",
                      textInputType: TextInputType.text,
                      isObscured: true,
                      validation: (v) {
                        if (v == null || v.isEmpty) return 'Please confirm';
                        return v != _cubit.registerPassword.text
                            ? 'Passwords don’t match'
                            : null;
                      },
                    ),
                    0.01.vSpace(),

                    CheckboxListTile(
                      value: _acceptedPolicy,
                      onChanged: (b) => setState(() => _acceptedPolicy = b!),
                      title: Text(
                        "I accept the Terms & Privacy Policy",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.greyColor,

                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    // if (!_acceptedPolicy)
                    //   Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(left: 12),
                    //       // child: Text(
                    //       //   "You must accept before registering",
                    //       //   style: TextStyle(color: Colors.red, fontSize: 12),
                    //       // ),
                    //     ),
                    //   ),
                    0.01.vSpace(),

                    CustomElevatedButton(
                      width: double.infinity,

                      label: 'Sign Up',
                      backgroundColor: AppColors.secondaryColor,

                      onTap: () {
                        if (!(_formKey.currentState!.validate())) {
                          // SnackBarService.showErrorMessage("Please Enter Valid Data.");
                          return;
                        }

                        if (!_acceptedPolicy) {
                          SnackBarService.showErrorMessage(
                            "You must accept our Terms & Privacy Policy",
                          );
                          return;
                        }
                        // if (_confirmPasswordController.text !=
                        //     _cubit.registerPassword.text) {
                        //   SnackBarService.showErrorMessage("Passwords don’t match");
                        //   return;
                        // }
                        EasyLoading.show();
                        _cubit.register();
                      },
                    ).center,
                  ],
                ).marginHorizontal(15),
              ),0.1.vSpace(),
            ],
          ).hPadding(0.03),
        ),
      ),
    );
  }
}
