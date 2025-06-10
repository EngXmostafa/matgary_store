import 'package:flutter/material.dart';
import 'package:matgary/core/extensions/extensions.dart';

import '../../../../core/theme/app_colors.dart';

class AdvertisementWidget extends StatelessWidget {
  final AdItem ad;
  const AdvertisementWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      // width: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(ad.imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text(
              //   "50-40% OFF",
              //   style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //       fontFamily: 'Montserrat',
              //       color: AppColors.primaryColor),
              // ),
              // 0.01.vSpace(),
              // Text(
              //   "Now in (product)",
              //   style: TextStyle(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w500,
              //     fontFamily: 'Montserrat',
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              // Text(
              //   "All colours",
              //   style: TextStyle(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w500,
              //     fontFamily: 'Montserrat',
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              // 0.05.vSpace(),
                    0.01.vSpace(),
              SizedBox(
                width: 0.4.width,
                child:
                    OutlinedButton.icon(
                      onPressed: ad.onTap,

                      label: const Text("Shop Now"),
                      icon: const Icon(Icons.arrow_forward),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.7,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: AppColors.primaryColor,
                        // padding: EdgeInsets.symmetric(vertical: 5),
                      ),

                      // child: Container(
                      //   padding: EdgeInsets.zero,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(
                      //       color: AppColors.primaryColor,
                      //       width: 1.7,
                      //     ),
                      //   ),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Text(
                      //           "Shop Now",
                      //           style: theme.textTheme.bodySmall!.copyWith(
                      //             fontSize: 12,
                      //           ),
                      //         ),
                      //         0.01.hSpace(),
                      //         Icon(
                      //           Icons.arrow_forward,
                      //           color: AppColors.primaryColor,
                      //         )
                      //       ],
                      //     ).allPadding(7),
                      //   ),
                      // ).center,
                    ).centerLeft
                    // onlyPadding(bottom: 0,left: 0,),

              ),
              0.02.vSpace(),
            ],
          ).allPadding(10).topLeft,
    ).hPadding(0.01).center;
  }
}

class AdItem {
  final String imageAsset;
  final VoidCallback onTap;

  AdItem({required this.imageAsset, required this.onTap});
}
