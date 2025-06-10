// import 'package:flutter/material.dart';
// import 'package:untitled/core/constants/app_assets.dart';
// import 'package:untitled/core/extensions/extensions.dart';
// import 'package:untitled/features/main_layout/home/widgets/advertisement_carousel.dart';
//
// import '../../../../../core/route/route_name.dart';
// import '../../../../../core/widgets/_index.dart';
//
// class CustomerHomeScreen extends StatelessWidget {
//   const CustomerHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final ads = [
//       AdItem(
//         imageAsset: AppAssets.advertisementBG,
//         onTap: () => Navigator.pushNamed(context, RouteNames.categoryScreen),
//       ),
//       AdItem(
//         imageAsset: AppAssets.advertisementBG,
//         onTap: () => Navigator.pushNamed(context, RouteNames.cartScreen),
//       ),
//       AdItem(
//         imageAsset: AppAssets.advertisementBG,
//         onTap:
//             () => Navigator.pushNamed(context, RouteNames.notificationScreen),
//       ),
//       AdItem(
//         imageAsset: AppAssets.advertisementBG,
//         onTap: () => Navigator.pushNamed(context, RouteNames.favoriteScreen),
//       ),
//     ];
//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [AdvertisementCarousel(items: ads)],
//         ).hPadding(0.03),
//       ).hPadding(0.01),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/route/route_name.dart';
import '../../../../../core/widgets/_index.dart';
import '../../../../../injection_container.dart';
import '../../widgets/advertisement_carousel.dart';
import '../manager/home_cubit.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ads = [
      AdItem(
        imageAsset: AppAssets.advertisementBG,
        onTap: () => Navigator.pushNamed(context, RouteNames.categoryScreen),
      ),
      AdItem(
        imageAsset: AppAssets.advertisementBG,
        onTap: () => Navigator.pushNamed(context, RouteNames.categoryScreen),
      ),
      // AdItem(
      //   imageAsset: AppAssets.advertisementBG,
      //   onTap:
      //       () => Navigator.pushNamed(context, RouteNames.nScreen),
      // ),
      // AdItem(
      //   imageAsset: AppAssets.advertisementBG,
      //   onTap: () => Navigator.pushNamed(context, RouteNames.favoriteScreen),
      // ),
    ];
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..fetchHome(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (ctx, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              final home = state.home;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // sliders
                    SizedBox(
                      height: 200,
                      // child: PageView(
                      //   children: home.sliders.map((s) =>
                      //       Image.network(s.banner, fit: BoxFit.cover)
                      //   ).toList(),
                      // ),
                        child:  AdvertisementCarousel(items: ads)
                    ),
                    // brands
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: home.brands.map((b) =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(b.logo),
                            ),
                        ).toList(),
                      ),
                    ),
                    // type-based
                    for (final entry in home.typeBaseProducts.entries) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(entry.key, style: Theme.of(context).textTheme.titleLarge,),
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: entry.value.map((p) => Card(
                            child: Column(
                              children: [
                                Image.network(p.thumbImage, width: 100, height: 100),
                                Text(p.name),
                                Text('\$${p.offerPrice ?? p.price}'),
                              ],
                            ),
                          )).toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
