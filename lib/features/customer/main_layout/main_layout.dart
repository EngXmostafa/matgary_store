// // lib/features/layout/main_layout/main_layout.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled/core/constants/app_assets.dart';
// import 'package:untitled/features/main_layout/profile_tab/cart_entity.dart';
//
// import '../../core/widgets/_index.dart';
// import '../../injection_container.dart' as di;
// import '../categories/presentation/manager/category_cubit.dart';
// import '../categories/presentation/pages/category_screen.dart';
// import '../home/presentation/pages/customer_home_screen.dart';
// import 'chat/chat.dart';
//
// class MainLayout extends StatefulWidget {
//   const MainLayout({super.key});
//
//   @override
//   State<MainLayout> createState() => _MainLayoutState();
// }
//
// class _MainLayoutState extends State<MainLayout> {
//   int _currentIndex = 0;
//
//   final List<Widget> _tabs = [
//     const CustomerHomeScreen(),
//   BlocProvider<CategoryCubit>(
//   create: (_) => di.sl<CategoryCubit>()..load(),
//   child: CategoryScreen(),),
//     const ChatScreen(),
//     const CartScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: const AppBarWidget(),
//         body: SingleChildScrollView(child: _tabs[_currentIndex]),
//         bottomNavigationBar: BottomNavigationBarWidget(
//           selectedIndex: _currentIndex,
//           onItemTapped: (i) => setState(() => _currentIndex = i),
//           items: [
//             BottomNavItemData(iconPath: AppAssets.homeIcn, label: 'Home'),
//             BottomNavItemData(
//               iconPath: AppAssets.categoryIcn,
//               label: 'Categories',
//             ),
//             BottomNavItemData(iconPath: AppAssets.chatIcn, label: 'Chat Box'),
//             BottomNavItemData(iconPath: AppAssets.cartIcn, label: 'Cart'),
//           ],
//         ),
//       ),
//     );
//   }
// }
// lib/features/layout/main_layout/main_layout.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_bar_widget.dart';
import '../../../core/widgets/bottom_navigation_bar_widget.dart';


import '../../../injection_container.dart' as di;
import '../cart/presentation/manager/cart_cubit.dart';
import '../cart/presentation/pages/cart_screen.dart';
import '../categories/presentation/manager/category_cubit.dart';
import '../categories/presentation/pages/category_screen.dart';
import '../home/presentation/manager/home_cubit.dart';
import '../home/presentation/pages/customer_home_screen.dart';
import '../wishlist/presentation/manager/wishlist_cubit.dart';
import '../wishlist/presentation/pages/wishlist_screen.dart';
import 'chat/chat.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  late final List<Widget> _tabs ;



  @override
  void initState() {
    super.initState();
    _tabs =
    [
      BlocProvider(
        create: (_) =>
        di.sl<HomeCubit>()
          ..fetchHome(),
        child: const CustomerHomeScreen(),
      ),
      const CategoryScreen(),
      // BlocProvider(
      //   create: (_) =>
      //   di.sl<CategoryCubit>()
      //     ..load(),
      //   child: const CategoryScreen(),
      // ),
      const ChatScreen(),
      BlocProvider(
        create: (_) =>
        di.sl<CartCubit>()
          ..getCartItems(),
        child: const CartScreen(),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
        create: (_) => di.sl<CategoryCubit>()..load(),
    child: SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          onFavoritesTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => di.sl<WishlistCubit>()..loadWishlist(),
                  child: const WishlistScreen(),
                ),
              ),
            );
          },
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _tabs,
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          selectedIndex: _currentIndex,
          onItemTapped: (i) => setState(() => _currentIndex = i),
          items: [
            BottomNavItemData(iconPath: AppAssets.homeIcn, label: 'Home'),
            BottomNavItemData(iconPath: AppAssets.categoryIcn, label: 'Categories'),
             BottomNavItemData(iconPath: AppAssets.chatIcn, label: 'Chat Box'),
             BottomNavItemData(iconPath: AppAssets.cartIcn, label: 'Cart'),
          ],
        ),
      ),
    ));
  }
}
