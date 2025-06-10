// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../../../../core/constants/app_constants.dart';
// // import '../manager/cart_cubit.dart';
// // import '../manager/cart_state.dart';
// //
// // class CartScreen extends StatelessWidget {
// //   const CartScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Shopping Cart')),
// //       body: BlocConsumer<CartCubit, CartState>(
// //         listener: (ctx, state) {
// //           if (state is CartActionSuccess) {
// //             ScaffoldMessenger.of(ctx).showSnackBar(
// //               SnackBar(content: Text(state.message)),
// //             );
// //           }
// //           if (state is CouponApplied) {
// //             ScaffoldMessenger.of(ctx).showSnackBar(
// //               SnackBar(content: Text(state.coupon.message)),
// //             );
// //           }
// //         },
// //         builder: (ctx, state) {
// //           if (state is CartLoading) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //           if (state is CartError) {
// //             if (state.message.contains('empty')) {
// //               return const Center(child: Text('Your cart is empty.'));
// //             }
// //             return Center(child: Text(state.message));
// //           }
// //           if (state is CartLoaded) {
// //             final cart = state.cart;
// //             return Column(
// //               children: [
// //                 Expanded(
// //                   child: ListView.separated(
// //                     padding: const EdgeInsets.all(12),
// //                     itemCount: cart.items.length,
// //                     separatorBuilder: (_, __) => const Divider(),
// //                     itemBuilder: (_, i) {
// //                       final itm = cart.items[i];
// //                       return Row(
// //                         children: [
// //                           Image.network(
// //                             '${Constants.baseURL}/${itm.product.thumbImage}',
// //                             width: 80, height: 80, fit: BoxFit.cover,
// //                           ),
// //                           const SizedBox(width: 12),
// //                           Expanded(
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(itm.product.name, style: const TextStyle(fontSize: 16)),
// //                                 const SizedBox(height: 4),
// //                                 Text('\$${itm.product.offerPrice.toStringAsFixed(2)}'),
// //                                 Row(
// //                                   children: [
// //                                     IconButton(
// //                                       icon: const Icon(Icons.remove_circle_outline),
// //                                       onPressed: itm.quantity > 1
// //                                           ? () => ctx.read<CartCubit>()
// //                                           .updateItem(itm.id, itm.quantity - 1)
// //                                           : null,
// //                                     ),
// //                                     Text('${itm.quantity}'),
// //                                     IconButton(
// //                                       icon: const Icon(Icons.add_circle_outline),
// //                                       onPressed: () => ctx.read<CartCubit>()
// //                                           .updateItem(itm.id, itm.quantity + 1),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           IconButton(
// //                             icon: const Icon(Icons.delete_outline, color: Colors.red),
// //                             onPressed: () => ctx.read<CartCubit>().removeItem(itm.id),
// //                           ),
// //                         ],
// //                       );
// //                     },
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16),
// //                   child: Column(
// //                     children: [
// //                       ListTile(
// //                         title: const Text('Apply Coupon'),
// //                         trailing: ElevatedButton(
// //                           child: const Text('Apply'),
// //                           onPressed: () => _showCouponDialog(context),
// //                         ),
// //                       ),
// //                       _buildRow('Total:', cart.total),
// //                       if (cart.discount > 0) _buildRow('Discount:', -cart.discount),
// //                       _buildRow('Final Total:', cart.finalTotal, bold: true),
// //                       const SizedBox(height: 12),
// //                       SizedBox(
// //                         width: double.infinity,
// //                         child: ElevatedButton(
// //                           onPressed: () {}, // continue
// //                           child: const Text('Continue'),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             );
// //           }
// //           return const SizedBox();
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRow(String label, double amount, {bool bold = false}) {
// //     final style = bold ? const TextStyle(fontWeight: FontWeight.bold) : null;
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(label, style: style),
// //           Text('\$${amount.toStringAsFixed(2)}', style: style),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void _showCouponDialog(BuildContext ctx) {
// //     final ctrl = TextEditingController();
// //     showDialog(
// //       context: ctx,
// //       builder: (_) => AlertDialog(
// //         title: const Text('Enter Coupon Code'),
// //         content: TextField(controller: ctrl),
// //         actions: [
// //           TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
// //           ElevatedButton(
// //             onPressed: () {
// //               ctx.read<CartCubit>().applyCode(ctrl.text.trim());
// //               Navigator.pop(ctx);
// //             },
// //             child: const Text('Apply'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// ///////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/constants/app_constants.dart';
// import '../../domain/entities/cart_entity.dart';
// import '../manager/cart_cubit.dart';
// import '../manager/cart_state.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Trigger the load from the existing CartCubit provided by MainLayout
//     context.read<CartCubit>().getCartItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Shopping Cart')),
//       body: BlocConsumer<CartCubit, CartState>(
//         listener: (ctx, state) {
//           if (state is CartActionSuccess) {
//             ScaffoldMessenger.of(ctx)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//           if (state is CouponApplied) {
//             ScaffoldMessenger.of(ctx)
//                 .showSnackBar(SnackBar(content: Text(state.coupon.message)));
//           }
//         },
//         builder: (ctx, state) {
//           if (state is CartLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is CartError) {
//             return Center(child: Text(state.message));
//           }
//           if (state is CartLoaded) {
//             return Column(
//               children: [
//                 Expanded(child: _buildList(ctx, state.cart)),
//                 _buildSummary(ctx, state.cart),
//               ],
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
//
//   Widget _buildList(BuildContext ctx, CartEntity cart) {
//     return ListView.separated(
//       padding: const EdgeInsets.all(12),
//       itemCount: cart.items.length,
//       separatorBuilder: (_, __) => const Divider(),
//       itemBuilder: (_, i) {
//         final itm = cart.items[i];
//         return Row(
//           children: [
//             Image.network(
//               '${Constants.baseURL}/${itm.product.thumbImage}',
//               width: 80,
//               height: 80,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(itm.product.name,
//                       style: const TextStyle(fontSize: 16)),
//                   const SizedBox(height: 4),
//                   Text('\$${itm.product.offerPrice.toStringAsFixed(2)}'),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.remove_circle_outline),
//                         onPressed: itm.quantity > 1
//                             ? () => ctx
//                             .read<CartCubit>()
//                             .updateProduct(itm.id, itm.quantity - 1)
//                             : null,
//                       ),
//                       Text('${itm.quantity}'),
//                       IconButton(
//                         icon: const Icon(Icons.add_circle_outline),
//                         onPressed: () => ctx
//                             .read<CartCubit>()
//                             .updateProduct(itm.id, itm.quantity + 1),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete_outline, color: Colors.red),
//               onPressed: () => ctx.read<CartCubit>().removeProduct(itm.id),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildSummary(BuildContext ctx, CartEntity cart) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(children: [
//         ListTile(
//           title: const Text('Apply Coupon'),
//           trailing: ElevatedButton(
//             onPressed: () => _showCouponDialog(ctx),
//             child: const Text('Apply'),
//           ),
//         ),
//         _row('Total:', cart.total),
//         if (cart.discount > 0) _row('Discount:', -cart.discount),
//         _row('Final Total:', cart.finalTotal, bold: true),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: () => ctx.read<CartCubit>().clearAll(),
//             child: const Text('Clear Cart'),
//           ),
//         ),
//       ]),
//     );
//   }
//
//   Widget _row(String label, double amt, {bool bold = false}) {
//     final style =
//     bold ? const TextStyle(fontWeight: FontWeight.bold) : null;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: style),
//           Text('\$${amt.toStringAsFixed(2)}', style: style),
//         ],
//       ),
//     );
//   }
//
//   void _showCouponDialog(BuildContext ctx) {
//     final ctrl = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Enter Coupon Code'),
//         content: TextField(controller: ctrl),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel')),
//           ElevatedButton(
//             onPressed: () {
//               ctx.read<CartCubit>().applyCode(ctrl.text.trim());
//               Navigator.pop(context);
//             },
//             child: const Text('Apply'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../domain/entities/cart_entity.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_state.dart';
import '../widgets/cart_item_card.dart';

class CartSummary {
  final double total;
  final double discount;
  final double finalTotal;

  CartSummary({required this.total, required this.discount, required this.finalTotal});
}

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<String, ValueNotifier<int>> _quantityNotifiers = {};
  final ValueNotifier<CartSummary> _summaryNotifier =
  ValueNotifier(CartSummary(total: 0, discount: 0, finalTotal: 0));

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCartItems();
  }

  @override
  void dispose() {
    for (var notifier in _quantityNotifiers.values) {
      notifier.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart 🛒')),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (ctx, state) {
          if (state is CartActionSuccess) {
            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is CouponApplied) {
            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(state.coupon.message)));
          }
        },
        builder: (ctx, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartError) {
            return Center(child: Text(state.message));
          }
          if (state is CartLoaded) {
            _summaryNotifier.value = CartSummary(
              total: state.cart.total,
              discount: state.cart.discount,
              finalTotal: state.cart.finalTotal,
            );
            return Column(
              children: [
                Expanded(child: _buildList(ctx, state.cart)),
               _buildSummarySection(),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildList(BuildContext ctx, CartEntity cart) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: cart.items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final itm = cart.items[i];
        if(!_quantityNotifiers.containsKey(itm.id)){
        _quantityNotifiers[itm.id] = ValueNotifier(itm.quantity);
        }
        final notifier = _quantityNotifiers[itm.id]!;
        return CartItemCard(
          imageUrl: '${Constants.baseURL}/${itm.product.thumbImage}',
          name: itm.product.name,
          category: itm.product.category ?? 'Unknown',
          price: itm.product.price,
          quantityNotifier: _quantityNotifiers[itm.id]!,
          onIncrease: () {
            final newQty = _quantityNotifiers[itm.id]!.value + 1;
            _quantityNotifiers[itm.id]!.value = newQty;
            ctx.read<CartCubit>().updateProduct(itm.id, newQty);
          },
          onDecrease: () {
            if (_quantityNotifiers[itm.id]!.value > 1) {
              final newQty = _quantityNotifiers[itm.id]!.value - 1;
              _quantityNotifiers[itm.id]!.value = newQty;
              ctx.read<CartCubit>().updateProduct(itm.id, newQty);
            }
          },
          onDelete: () {
            _quantityNotifiers.remove(itm.id);
            ctx.read<CartCubit>().removeProduct(itm.id);
          },
        );
      },
    );
  }

  Widget _buildSummarySection() {
    return ValueListenableBuilder<CartSummary>(
      valueListenable: _summaryNotifier,
      builder: (_, summary, __) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => _showCouponSheet(context),
              child: Row(
                children: const [
                  Icon(Icons.discount),
                  SizedBox(width: 8),
                  Text("Apply Coupon"),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _row("Total", summary.total),
            if (summary.discount > 0) _row("Discount", -summary.discount),
            _row("Final Total", summary.finalTotal, bold: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, double amt, {bool bold = false}) {
    final style = bold ? const TextStyle(fontWeight: FontWeight.bold) : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('\$${amt.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }

  void _showCouponSheet(BuildContext ctx) {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: ctx,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Enter Coupon Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(controller: ctrl, decoration: const InputDecoration(labelText: "Coupon Code")),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ctx.read<CartCubit>().applyCode(ctrl.text.trim());
                  Navigator.pop(ctx);
                },
                child: const Text("Apply"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

