import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../manager/wishlist_cubit.dart';
import '../manager/wishlist_state.dart';
import '../widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "MY FAVORITES",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          ),
          body: state is WishlistLoading
              ? const Center(child: CircularProgressIndicator())
              : state is WishlistLoaded
              ? state.items.isEmpty
              ? const Center(
            child: Text(
              "Your favorites list is empty.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: GridView.builder(
              itemCount: state.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = state.items[index];
                final product = item.product;
                return ProductCard(
                  imageUrl: product.thumbImage,
                  name: product.name,
                  price: product.price,
                  isFavorite: true,
                  onFavorite: () {
                    BlocProvider.of<WishlistCubit>(context).toggleFavorite(product.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Removed from favorites!"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  rating: "4.9", // Replace with product.rating if available
                  onTap: () {
                    // TODO: handle product tap
                  },
                );
              },
            ),
          )
              : state is WishlistError
              ? Center(child: Text(state.message))
              : Container(),
        );
      },
    );
  }
}
