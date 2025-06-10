import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/use_cases/add_to_cart_usecase.dart';
import '../../domain/use_cases/apply_coupon_usecase.dart';
import '../../domain/use_cases/clear_cart_usecase.dart';
import '../../domain/use_cases/get_cart_usecase.dart';
import '../../domain/use_cases/remove_cart_item_usecase.dart';
import '../../domain/use_cases/update_cart_item_usecase.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCart;
  final AddToCartUseCase addToCart;
  final UpdateCartItemUseCase updateItem;
  final RemoveCartItemUseCase removeItem;
  final ClearCartUseCase clearCart;
  final ApplyCouponUseCase applyCoupon;

  CartCubit({
    required this.getCart,
    required this.addToCart,
    required this.updateItem,
    required this.removeItem,
    required this.clearCart,
    required this.applyCoupon,
  }) : super(CartLoading());

  // void getCartItems() async {
  //   emit(CartLoading());
  //   final res = await getCart();
  //   res.fold(
  //         (l) => emit(CartError(l.message ?? 'Failed to load cart')),
  //         (r) => emit(CartLoaded(r)),
  //   );
  // }
  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      final result = await getCart();
      result.fold(
            (failure) {
          print('❌ Cart Load Failed: ${failure.message}');
          emit(CartError( failure.message ?? 'Unknown error'));
        },
            (cart) {
          print('✅ Cart Loaded Successfully: ${cart.items.length} items');
          emit(CartLoaded(cart));

            },
      );
    } catch (e, stack) {
      print('🔥 Unexpected error in getCartItems: $e');
      print(stack);
      emit(CartError( 'Unexpected error occurred'));
    }
  }

  void addProduct(String pid, int qty) async {
    final res = await addToCart(pid, qty);
    res.fold(
          (l) => emit(CartError(l.message ?? 'Failed to add')),
          (_) async {
        final refresh = await getCart();
        refresh.fold(
              (f) => emit(CartError(f.message ?? 'Failed to refresh cart')),
              (cart) => emit(CartLoaded(cart)),
        );
      },
    );
  }

  void updateProduct(String id, int qty) async {
    final res = await updateItem(id, qty);
    res.fold(
          (l) => emit(CartError(l.message ?? 'Failed to update')),
          (_) async {
        final refresh = await getCart();
        refresh.fold(
              (f) => emit(CartError(f.message ?? 'Failed to refresh cart')),
              (updatedCart) => emit(CartLoaded(updatedCart)),
        );
      },
    );
  }


  void removeProduct(String id) async {
    final res = await removeItem(id);
    res.fold(
          (l) => emit(CartError(l.message ?? 'Failed to remove')),
          (_) async {
        final refresh = await getCart();
        refresh.fold(
              (f) => emit(CartError(f.message ?? 'Failed to refresh cart')),
              (cart) => emit(CartLoaded(cart)),
        );
      },
    );
  }


  void clearAll() async {
    final res = await clearCart();
    res.fold(
          (l) => emit(CartError(l.message ?? 'Failed to clear cart')),
          (_) async {
        final refresh = await getCart();
        refresh.fold(
              (f) => emit(CartError(f.message ?? 'Failed to refresh cart')),
              (cart) => emit(CartLoaded(cart)),
        );
      },
    );
  }

  void applyCode(String code) async {
    final res = await applyCoupon(code);
    res.fold(
          (l) => emit(CartError(l.message ?? 'Invalid coupon')),
          (coupon) async {
        emit(CouponApplied(coupon)); // ✅ show coupon success in UI
        final refresh = await getCart();
        refresh.fold(
              (f) => emit(CartError(f.message ?? 'Failed to refresh cart')),
              (cart) => emit(CartLoaded(cart)), // ✅ updates summary & items
        );
      },
    );
  }
}