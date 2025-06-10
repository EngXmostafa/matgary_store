import 'package:flutter/material.dart';
import 'package:matgary/core/extensions/extensions.dart';

import '../theme/app_colors.dart';

class BottomNavItemData {
  final String iconPath;
  final String label;
  final double iconSize;

  BottomNavItemData({
    required this.iconPath,
    required this.label,
    this.iconSize = 24.0,
  });
}

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<BottomNavItemData> items;
  final double? height;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: SizedBox(
        height: height ?? 70,
        child: BottomNavigationBar(
          backgroundColor: AppColors.secondaryColor,
          type: BottomNavigationBarType.fixed,
          fixedColor: AppColors.blackColor,
          unselectedItemColor: AppColors.primaryColor,
          currentIndex: selectedIndex,
          onTap: onItemTapped,

          items:
              items
                  .map(
                    (item) => BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage(item.iconPath),
                        size: item.iconSize,
                      ),
                      label: item.label,
                    ),
                  )
                  .toList(),
        ),
      ),
    ).onlyPadding(bottom: 25, right: 19, left: 18);
  }
}
