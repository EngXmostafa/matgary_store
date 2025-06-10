import 'package:flutter/material.dart';
import 'package:matgary/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/customer/wishlist/presentation/manager/wishlist_cubit.dart';
import '../../features/customer/wishlist/presentation/manager/wishlist_state.dart';

import '../constants/app_assets.dart';

import '../route/route_name.dart';
import '../theme/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onFavoritesTap;
  const AppBarWidget({super.key,this.onFavoritesTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppAssets.logo,
                scale: 5,
                fit: BoxFit.cover,
              ),
              Row(
                children: [
                  BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      final bool hasWishlistItems = state is WishlistLoaded && state.items.isNotEmpty;
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: onFavoritesTap,
                            child: Image.asset(
                              AppAssets.favoriteIcn,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          if (hasWishlistItems)
                            Positioned(
                              top: 0,
                              right: -2,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),0.05.hSpace(),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.notificationScreen,
                      );
                    },
                    child: Image.asset(
                      AppAssets.notificationIcn,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  0.05.hSpace(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.profileUserScreen,
                      );
                    },
                    child: Image.asset(
                      AppAssets.profileIcn,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ],
          ).marginSym(ver: 15),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Hind',
                  color: AppColors.mix,
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: AppColors.grey,
                decoration: InputDecoration(
                  hintText: "Search here",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Hind',
                    color: AppColors.mix,
                    fontWeight: FontWeight.w500,
                  ),
                  fillColor: AppColors.primaryColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      14.0,
                    ),
                    borderSide: BorderSide(
                      color: AppColors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.grey,
                    ),
                    borderRadius: BorderRadius.circular(
                      14.0,
                    ),
                  ),
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.searchIcn),
                    size: 18,
                    color: AppColors.searchIcn,
                  ).allPadding(9.0),
                ),
              ).onlyPadding(
                left: 15,
                right: 10,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(
                  14,
                ),
                border: Border.all(color: AppColors.grey), // Border color
              ),
              child: IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: AppColors.filterIcn,
                  size: 24,
                ),
                onPressed: () {},
              ).allPadding(5.0),
            ).marginRight(13)
          ],
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(160);
}
