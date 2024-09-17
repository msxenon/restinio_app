import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';

class FoodDetailsBloc extends Cubit<AsyncState<FoodEntity?>> {
  final FoodRepository _foodRepository;
  final String foodId;
  FoodDetailsBloc(this.foodId, this._foodRepository)
      : super(const AsyncStateLoading(),) {
    unawaited(_get());
  }

  Future<void> _get() async {
    try {
      emit(const AsyncStateLoading());
      final item = await _foodRepository.get(foodId);
      emit(AsyncStateData(item));
    } catch (e) {
      emit(AsyncStateFailure(e.toString()));
    }
  }
}
