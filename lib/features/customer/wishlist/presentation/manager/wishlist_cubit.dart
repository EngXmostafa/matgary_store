import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/services/_index.dart';
import '../../domain/use_cases/get_wishlist_usecase.dart';
import '../../domain/use_cases/add_to_wishlist_usecase.dart';
import '../../domain/use_cases/remove_from_wishlist_usecase.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../../../../../core/errors/failures.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;

  WishlistCubit({
    required this.getWishlistUseCase,
    required this.addToWishlistUseCase,
    required this.removeFromWishlistUseCase,
  }) : super(WishlistInitial());

  List<WishlistItemEntity> _items = [];

  Future<void> loadWishlist() async {
    emit(WishlistLoading());
    final result = await getWishlistUseCase();
    result.fold(
      (failure) =>
          emit(WishlistError(failure.message ?? "Failed to load wishlist")),
      (items) {
        print('[Cubit] Wishlist loaded, count: ${items.length}');
        _items = items;
        emit(WishlistLoaded(List.from(_items)));
      },
    );
  }

  Future<void> toggleFavorite(String productId) async {
    final isFav = _items.any((e) => e.product.id == productId);

    String? wishlistItemId;
    if (isFav) {
      wishlistItemId = _items.firstWhere((e) => e.product.id == productId).id;
      print('[Cubit] Will remove wishlist item id: $wishlistItemId (productId: $productId)');
      _items.removeWhere((e) => e.product.id == productId);
    }
    emit(WishlistLoaded(List.from(_items)));

    final result = isFav
        ? await removeFromWishlistUseCase(wishlistItemId!)
        : await addToWishlistUseCase(productId);

    result.fold(
          (failure) {
        loadWishlist();
        SnackBarService.showErrorMessage(
          failure.message ?? "Failed to update wishlist",
        );
        emit(WishlistError(failure.message ?? "Failed to update wishlist"));
      },
          (_) {
        loadWishlist();
        if (isFav) {
          SnackBarService.showSuccessMessage("Product removed from wishlist!");
        }
      },
    );
  }

  bool isFavorite(String productId) =>
      _items.any((e) => e.product.id == productId);

  List<WishlistItemEntity> get wishlistItems => _items;
}
