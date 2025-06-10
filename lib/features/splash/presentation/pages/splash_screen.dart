import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgary/core/extensions/extensions.dart';
import '../../../../injection_container.dart';
import '../manager/splash_cubit.dart';
import '/core/theme/app_colors.dart';
import '/core/constants/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<SplashCubit>();
    _cubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,

      child: BlocListener<SplashCubit, SplashState>(
        listenWhen: (_, state) => state is SplashNavigate,
        listener: (context, state) {
          Navigator.pushReplacementNamed(
            context,
            (state as SplashNavigate).route,
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Stack(
            children: [
              BounceInDown(
                duration: const Duration(seconds: 2),
                child: Image.asset(AppAssets.splashBG),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: const Duration(seconds: 2),
                    child: Image.asset(AppAssets.logo),
                  ),
                  0.01.vSpace(),
                  Text(
                    "Welcome To",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor,
                    ),
                  ),
                  0.01.vSpace(),
                  Text(
                    "MATGARY",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ).center,
            ],
          ),
        ),
      ),
    );
  }
}
