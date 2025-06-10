
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';
import '../entities/coupon_entity.dart';

class ApplyCouponUseCase {
  final CartRepository repo;
  ApplyCouponUseCase(this.repo);

  Future<Either<Failure, CouponEntity>> call(String code) =>
      repo.applyCoupon(code);
}