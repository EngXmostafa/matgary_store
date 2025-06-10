import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// core
import 'core/constants/app_constants.dart';
import 'core/services/_index.dart';

// splash

import 'features/customer/auth/data/data_sources/auth_interface_data_source.dart';
import 'features/customer/auth/data/data_sources/remote_auth_data_source.dart';
import 'features/customer/auth/data/repositories/auth_repositories_imp.dart';
import 'features/customer/auth/domain/repositories/auth_repositories.dart';
import 'features/customer/auth/domain/use_cases/login_use_case.dart';
import 'features/customer/auth/domain/use_cases/logout_use_case.dart';
import 'features/customer/auth/domain/use_cases/register_use_case.dart';
import 'features/customer/auth/presentation/manager/auth_cubit.dart';
import 'features/customer/cart/data/data_sources/cart_remote_data_source.dart';
import 'features/customer/cart/data/repositories/cart_repository_impl.dart';
import 'features/customer/cart/domain/repositories/cart_repository.dart';
import 'features/customer/cart/domain/use_cases/add_to_cart_usecase.dart';
import 'features/customer/cart/domain/use_cases/apply_coupon_usecase.dart';
import 'features/customer/cart/domain/use_cases/clear_cart_usecase.dart';
import 'features/customer/cart/domain/use_cases/get_cart_usecase.dart';
import 'features/customer/cart/domain/use_cases/remove_cart_item_usecase.dart';
import 'features/customer/cart/domain/use_cases/update_cart_item_usecase.dart';
import 'features/customer/cart/presentation/manager/cart_cubit.dart';
import 'features/customer/categories/data/data_sources/category_remote_data_source.dart';
import 'features/customer/categories/data/repositories/category_repository_imp.dart';
import 'features/customer/categories/domain/repositories/category_repository.dart';
import 'features/customer/categories/domain/use_cases/get_category_feature.dart';
import 'features/customer/categories/presentation/manager/category_cubit.dart';
import 'features/customer/home/data/data_sources/home_remote_data_source.dart';
import 'features/customer/home/data/repositories/home_repository_impl.dart';
import 'features/customer/home/domain/repositories/home_repository.dart';
import 'features/customer/home/domain/usecases/get_home_usecase.dart';
import 'features/customer/home/presentation/manager/home_cubit.dart';
import 'features/customer/wishlist/data/data_sources/wishlist_remote_data_source.dart';
import 'features/customer/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'features/customer/wishlist/domain/repositories/wishlist_repository.dart';
import 'features/customer/wishlist/domain/use_cases/add_to_wishlist_usecase.dart';
import 'features/customer/wishlist/domain/use_cases/get_wishlist_usecase.dart';
import 'features/customer/wishlist/domain/use_cases/remove_from_wishlist_usecase.dart';
import 'features/customer/wishlist/presentation/manager/wishlist_cubit.dart';
// import 'features/seller/auth/data/data_sources/seller_auth_interface_data_source.dart';
// import 'features/seller/auth/data/data_sources/seller_remote_data_source.dart';
// import 'features/seller/auth/data/repositories/seller_repositories_imp.dart';
// import 'features/seller/auth/domain/repositories/seller_auth_repository.dart';
// import 'features/seller/auth/domain/use_cases/seller_login_use_case.dart';
// import 'features/seller/auth/domain/use_cases/seller_logout_use_case.dart';
// import 'features/seller/auth/domain/use_cases/seller_register_use_case.dart';
// import 'features/seller/auth/presentation/manager/seller_auth_cubit.dart';
// import 'features/seller/products/data/datasources/products_remote_data_source.dart';
// import 'features/seller/products/data/repositories/products_repository_impl.dart';
// import 'features/seller/products/domain/repositories/products_repository.dart';
// import 'features/seller/products/domain/use_cases/add_product_use_case.dart';
// import 'features/seller/products/domain/use_cases/get_brands_use_case.dart';
// import 'features/seller/products/domain/use_cases/get_categories_use_case.dart';
// import 'features/seller/products/presentation/manager/add_product_cubit.dart';
import 'features/splash/presentation/manager/splash_cubit.dart';

// home feature


// auth (customer)


// auth (seller)


// categories


// cart


final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! External
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // ! Dio clients
  sl.registerLazySingleton<Dio>(
        () => Dio(BaseOptions(
      baseUrl: Constants.baseURL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    )),
    instanceName: 'publicDio',
  );
  sl.registerLazySingleton<Dio>(
        () => Dio(BaseOptions(
      baseUrl: Constants.baseURL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    )),
    instanceName: 'authDio',
  );

  //! Core services
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<LoadingService>(() => LoadingService());
  sl.registerLazySingleton<SnackBarService>(() => SnackBarService());
  sl.registerLazySingleton<WebServices>(() => WebServices(
    publicDio: sl<Dio>(instanceName: 'publicDio'),
    authDio: sl<Dio>(instanceName: 'authDio'),
  ));
  await sl<WebServices>().loadToken();

  //! Splash
  sl.registerFactory(() => SplashCubit());

  // ─── Customer Auth ─────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthInterfaceDataSource>(
        () => RemoteAuthDataSource(sl<Dio>(instanceName: 'publicDio')),
  );
  sl.registerLazySingleton<AuthRepositories>(
        () => AuthRepositoriesImp(sl<AuthInterfaceDataSource>()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepositories>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepositories>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepositories>()));
  sl.registerFactory(
        () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
    ),
  );

  // // ─── Seller Auth ───────────────────────────────────────────────────────
  // sl.registerLazySingleton<SellerAuthInterfaceDataSource>(
  //       () => SellerRemoteDataSource(sl<Dio>(instanceName: 'publicDio')),
  // );
  // sl.registerLazySingleton<SellerAuthRepository>(
  //       () => SellerAuthRepositoriesImp(sl<SellerAuthInterfaceDataSource>()),
  // );
  // sl.registerLazySingleton(
  //       () => SellerLoginUseCase(sl<SellerAuthRepository>()),
  // );
  // sl.registerLazySingleton(
  //       () => SellerRegisterUseCase(sl<SellerAuthRepository>()),
  // );
  // sl.registerLazySingleton(
  //       () => SellerLogoutUseCase(sl<SellerAuthRepository>()),
  // );
  // sl.registerFactory(
  //       () => SellerAuthCubit(
  //     loginUseCase: sl<SellerLoginUseCase>(),
  //     registerUseCase: sl<SellerRegisterUseCase>(),
  //     logoutUseCase: sl<SellerLogoutUseCase>(),
  //   ),
  // );

  // ─── Categories ────────────────────────────────────────────────────────
  sl.registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSourceImpl(
      sl<Dio>(instanceName: 'authDio'),
    ),
  );
  sl.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(sl<CategoryRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetCategoryFeature>(
        () => GetCategoryFeature(sl<CategoryRepository>()),
  );

  sl.registerFactory(
        () => CategoryCubit(sl<GetCategoryFeature>()),
  );


  // ─── Home ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(sl<Dio>(instanceName: 'authDio')),
  );
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetHomeUseCase>(
        () => GetHomeUseCase(sl<HomeRepository>()),
  );
  sl.registerFactory(
        () => HomeCubit(sl<GetHomeUseCase>()),
  );

  // ─── Cart feature ─────────────────────────────────────────────────────
  // data source
  sl.registerLazySingleton<CartRemoteDataSource>(
        () => CartRemoteDataSourceImpl(sl<Dio>(instanceName: 'authDio')),
  );
  // repository
  sl.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(sl<CartRemoteDataSource>()),
  );
  // use cases
  sl.registerLazySingleton(() => GetCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => UpdateCartItemUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => RemoveCartItemUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => ApplyCouponUseCase(sl<CartRepository>()));
  // cubit
  sl.registerFactory(
        () => CartCubit(
      getCart: sl<GetCartUseCase>(),
      addToCart: sl<AddToCartUseCase>(),
      updateItem: sl<UpdateCartItemUseCase>(),
      removeItem: sl<RemoveCartItemUseCase>(),
      clearCart: sl<ClearCartUseCase>(),
      applyCoupon: sl<ApplyCouponUseCase>(),
    ),
  );

  // // ─── Add Product Feature ──────────────────────────────────────────────
  // sl.registerLazySingleton(() => GetCategoriesUseCase(sl<ProductsRepository>()));
  // sl.registerLazySingleton(() => GetBrandsUseCase(sl<ProductsRepository>()));
  // sl.registerLazySingleton(() => AddProductUseCase(sl<ProductsRepository>()));
  //
  // sl.registerLazySingleton<ProductsRemoteDataSource>(
  //       () => ProductsRemoteDataSourceImpl(sl<WebServices>()),
  // );
  //
  // sl.registerLazySingleton<ProductsRepository>(
  //       () => ProductsRepositoryImpl(sl<ProductsRemoteDataSource>()),
  // );
  //
  // sl.registerFactory(() => AddProductCubit(
  //   getCategoriesUseCase: sl<GetCategoriesUseCase>(),
  //   getBrandsUseCase: sl<GetBrandsUseCase>(),
  //   addProductUseCase: sl<AddProductUseCase>(),
  // ));

  // Wishlist Data Source
  sl.registerLazySingleton<WishlistRemoteDataSource>(
        () => WishlistRemoteDataSourceImpl(sl<Dio>(instanceName: 'authDio')),
  );
  sl.registerLazySingleton<WishlistRepository>(
        () => WishlistRepositoryImpl(sl<WishlistRemoteDataSource>()),
  );
  sl.registerLazySingleton(() => GetWishlistUseCase(sl<WishlistRepository>()));
  sl.registerLazySingleton(() => AddToWishlistUseCase(sl<WishlistRepository>()));
  sl.registerLazySingleton(() => RemoveFromWishlistUseCase(sl<WishlistRepository>()));

  sl.registerFactory(() => WishlistCubit(
    getWishlistUseCase: sl<GetWishlistUseCase>(),
    addToWishlistUseCase: sl<AddToWishlistUseCase>(),
    removeFromWishlistUseCase: sl<RemoveFromWishlistUseCase>(),
  ));

}