class CouponEntity {
  final String message;
  final double discount;
  final double finalTotal;

  CouponEntity({
    required this.message,
    required this.discount,
    required this.finalTotal,
  });

  factory CouponEntity.fromMap(Map<String, dynamic> map) {
    return CouponEntity(
      message: map['message'] ?? '',
      discount: double.tryParse(map['discount']?.toString() ?? '0') ?? 0.0,
      finalTotal: double.tryParse(map['final_total']?.toString() ?? '0') ?? 0.0,
    );
  }
}