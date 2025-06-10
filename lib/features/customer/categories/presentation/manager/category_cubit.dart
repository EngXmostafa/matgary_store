import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/use_cases/get_category_feature.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoryFeature _uc;
  CategoryCubit(this._uc) : super(CategoryLoading());

  Future <void>load({bool refresh = false}) async {
    emit(CategoryLoading());
    final res = await _uc(refresh: refresh);
    res.fold(
          (Failure f) => emit(CategoryError(f.message ?? 'Unexpected error')),
          (fp)        => emit(CategoryLoaded(fp)),
    );
  }
}
