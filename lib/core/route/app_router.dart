import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../features/customer/auth/presentation/manager/auth_cubit.dart';
import '../../features/customer/auth/presentation/pages/login_screen.dart';
import '../../features/customer/auth/presentation/pages/sign_up_screen.dart';
import '../../features/customer/home/presentation/pages/customer_home_screen.dart';
import '../../features/customer/main_layout/main_layout.dart';

import '../../features/customer/wishlist/presentation/manager/wishlist_cubit.dart';
import '../../features/customer/wishlist/presentation/pages/wishlist_screen.dart';
// import '../../features/seller/auth/presentation/pages/seller_login_screen.dart';
// import '../../features/seller/auth/presentation/pages/seller_sign_up_screen.dart';
// import '../../features/seller/main_layout/main_layout.dart';
import '../../features/splash/presentation/pages/first_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../injection_container.dart';

import '../../injection_container.dart' as di;
import '/core/route/route_name.dart';

abstract class AppRouter {
  static Route generate(RouteSettings setting) {
    switch (setting.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: setting,
        );
      case RouteNames.firstScreen:
        return MaterialPageRoute(
          builder: (context) => const FirstScreen(),
          settings: setting,
        );
      // case RouteNames.otpScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const OtpScreen(),
      //     settings: setting,
      //   );
      case RouteNames.customerSignUpScreen:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider<AuthCubit>(
                create: (_) => sl<AuthCubit>(),
                child: SignUpScreen(),
              ),
          settings: setting,
        );
      case RouteNames.customerLoginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: setting,
        );
      case RouteNames.mainLayoutScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
          create: (_) => di.sl<WishlistCubit>()..loadWishlist(),
          child: const MainLayout(),
        ),
        settings: setting,
      );
      case RouteNames.customerHomeScreen:
        return MaterialPageRoute(
          builder: (context) =>  CustomerHomeScreen(),
          settings: setting,
        );
      //   case RouteNames.forgetPasswordScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => const ForgetPassword(),
      //       settings: setting,
      //     );
      //   case RouteNames.layoutScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => LayoutScreen(),
      //       settings: setting,
      //     );
      //   case RouteNames.categoryScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => CategoryScreen(),
      //       settings: setting,
      //     );
      //   case RouteNames.chatScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => const ChatScreen(),
      //       settings: setting,
      //     );
      //   case RouteNames.cartScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => const CartScreen(),
      //       settings: setting,
      //     );
      //   case RouteNames.favoriteScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => WishlistScreen(),
      //       settings: setting,
          //);
      //   case RouteNames.notificationScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => const NotificationScreen(),
      //       settings: setting,
      //     );
      //
      // case RouteNames.sellerSignUpScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const SellerSignUpScreen(),
      //     settings: setting,
      //   );
      // case RouteNames.sellerLoginScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const SellerLoginScreen(),
      //
      //     settings: setting,
      //   );
      // case RouteNames.sellerMainLayoutScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const SellerMainLayout(),
      //     settings: setting,
      //   );
      //   case RouteNames.profileUserScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => const ProfileUserScreen(),
      //       settings: setting,
      //     );
      //   case RouteNames.editProfileUserScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => const EditProfileUserScreen(),
      //       settings: setting,
      //     );
      //   case RouteNames.resetPasswordScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => const ResetPasswordScreen(),
      //       settings: setting,
      //     );
      //   case RouteNames.ordersScreen:
      //     return MaterialPageRoute(
      //       builder: (context) => const OrdersScreen(),
      //       settings: setting,
      //     );
      //
      default:
        return MaterialPageRoute(
          builder:(context)=>const FirstScreen(),
        );
    }
  }
}
