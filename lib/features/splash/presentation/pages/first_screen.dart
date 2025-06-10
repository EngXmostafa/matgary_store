import 'package:flutter/material.dart';
import 'package:matgary/core/extensions/extensions.dart';
import '../../../../core/route/route_name.dart';
import '../../../../core/services/_index.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/_index.dart';
import '/core/constants/app_assets.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  void _selectUserType(BuildContext context, String type) {
 CacheHelper.setString('userType', type);

 final route = type == 'customer'
     ? RouteNames.customerLoginScreen
     : RouteNames.sellerLoginScreen;
 Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.logo,
          ).center,
          Text(
            "Continue As",
            style: TextStyle(
              fontSize: 34,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),
          ),
          Text(
            "Choose your account type",
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: AppColors.greyColor,
            ),
          ),
          0.06.vSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomElevatedButton(
                label: 'Customer',
                padding: EdgeInsets.symmetric(
                  horizontal: 0.08.width,
                  vertical: 12,
                ),
                backgroundColor: AppColors.secondaryColor,
                onTap: () => _selectUserType(context, 'customer'),
              ),
              CustomElevatedButton(
                label: 'Seller',
                onTap: () => _selectUserType(context, 'seller'),
                backgroundColor: AppColors.greyColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 0.09.width,
                  vertical: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
