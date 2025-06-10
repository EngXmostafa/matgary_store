import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/home_entity.dart';
import '../../domain/usecases/get_home_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeUseCase _getHome;
  HomeCubit(this._getHome) : super(HomeInitial());

  Future<void> fetchHome() async {
    emit(HomeLoading());
    final result = await _getHome();
    result.fold(
          (f) => emit(HomeError(f.toString())),
          (h) => emit(HomeLoaded(h)),
    );
  }
}
