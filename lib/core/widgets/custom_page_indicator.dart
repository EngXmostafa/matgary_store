import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/core/theme/app_colors.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController controller;
  static final int count = 4;

  const CustomPageIndicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,

      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: AppColors.secondaryColor,
        dotColor: AppColors.dot,
      ),
    );
  }
}
