import '../../domain/entities/coupon_entity.dart';
class CouponModel extends CouponEntity {
  CouponModel({required String message, required double discount, required double finalTotal})
      : super(message: message, discount: discount, finalTotal: finalTotal);

  factory CouponModel.fromMap(Map<String, dynamic> m) => CouponModel(
    message: m['message'],
    discount: (m['discount'] as num).toDouble(),
    finalTotal: (m['final_total'] as num).toDouble(),
  );
}