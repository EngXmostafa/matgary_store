import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/route/route_name.dart';
import '../../../../core/services/cache_helper.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> initialize() async {

    await Future.delayed(const Duration(seconds: 2));

    final token = await CacheHelper.getString('token');
    final userType = await CacheHelper.getString('userType');

    if (token == null || token.isEmpty) {

      emit(const SplashNavigate(RouteNames.firstScreen));
    } else if (userType == 'vendor') {
      emit(const SplashNavigate(RouteNames.sellerMainLayoutScreen));
    } else {
      emit(const SplashNavigate(RouteNames.mainLayoutScreen));
    }
  }
}

//   Future<void> initialize() async {
//     try {
//       // keep splash visible for at least 2 seconds
//       if (isClosed) return;
//
//       // read token & userType in parallel
//       final results = await Future.wait<String?>([
//         CacheHelper.getString('token'),
//         CacheHelper.getString('userType'),
//       ]);
//       final token    = results[0];
//       final userType = results[1];
//
//       // decide next route
//       var route = RouteNames.firstScreen;
//       if (token?.isNotEmpty == true) {
//         route = switch (userType) {
//           'customer' => RouteNames.customerHomeScreen,
//           'seller'   => RouteNames.sellerHomeScreen,
//           _          => RouteNames.firstScreen,
//         };
//       }
//
//       if (!isClosed) emit(SplashNavigate(route));
//     } catch (_) {
//       if (!isClosed) {
//         emit(const SplashNavigate(RouteNames.firstScreen));
//       }
//     }
//   }
// }
