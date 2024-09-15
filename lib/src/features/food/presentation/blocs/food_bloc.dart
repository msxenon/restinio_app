import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';

class FoodBloc extends Cubit<AsyncState<List<FoodEntity>>> {
  final FoodRepository _foodRepository;
  FoodBloc(this._foodRepository) : super(const AsyncStateLoading()) {
    unawaited(_getFoods());
  }

  Future<void> _getFoods() async {
    try {
      emit(const AsyncStateLoading());
      final foods = await _foodRepository.getFoods();
      emit(AsyncStateData(foods));
    } catch (e) {
      emit(AsyncStateFailure(e.toString()));
    }
  }
}
