import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback? onTap;
  final String? rating; // optional

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.isFavorite,
    required this.onFavorite,
    this.onTap,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 3,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (ctx, child, progress) =>
                        progress == null
                            ? child
                            : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        errorBuilder: (ctx, err, _) =>
                        const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Name
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Text(
                    "${price.toStringAsFixed(0)} EGP",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  // Rating
                  if (rating != null)
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber[700], size: 16),
                        const SizedBox(width: 3),
                        Text(rating!, style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                ],
              ),
            ),
            // Heart Icon
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red, size: 28),
                onPressed: onFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
