import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import 'core/route/app_router.dart';
import 'core/route/route_name.dart';
import 'core/services/cache_helper.dart';
import 'core/services/loading_service.dart';

import 'core/theme/_index.dart';
import 'features/customer/auth/presentation/manager/auth_cubit.dart';
import 'features/seller/auth/presentation/manager/seller_auth_cubit.dart';
import 'features/splash/presentation/manager/splash_cubit.dart';
import 'injection_container.dart' as di;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await di.init();
  await CacheHelper.init();



  // Configure EasyLoading
  di.sl<LoadingService>().init();

  runApp(const MatgaryApp());
}

class MatgaryApp extends StatelessWidget {
  const MatgaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SplashCubit>(create: (_) => di.sl<SplashCubit>()..initialize(),),
            BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()),
            BlocProvider<SellerAuthCubit>(
              create: (_) => di.sl<SellerAuthCubit>(),
            ),
          ],

          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            initialRoute: RouteNames.splashScreen,
            onGenerateRoute: AppRouter.generate,
            builder: EasyLoading.init(builder: BotToastInit()),
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: AppTheme.lightTheme,
          ),
        );
      },
    );
  }
}
