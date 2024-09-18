import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';
import 'package:rxdart/rxdart.dart';

class FoodScreenBloc extends Cubit<AsyncState<List<FoodEntity>>> {
  final FoodRepository _foodRepository;
  static const _searchDebounce = Duration(milliseconds: 300);
  final BehaviorSubject<String> _searchSubject = BehaviorSubject.seeded('');
  late StreamSubscription<String> _searchSubscription;
  FoodScreenBloc(this._foodRepository) : super(const AsyncStateLoading()) {
    unawaited(_getAll());
    _searchSubscription = _searchSubject
        .distinct()
        .debounceTime(_searchDebounce)
        .listen((searchKeyword) => _execSearch(searchKeyword));
  }

  Future<void> _getAll() async {
    try {
      emit(const AsyncStateLoading());
      final all = await _foodRepository.getAll();
      emit(AsyncStateData(all));
    } catch (e) {
      emit(AsyncStateFailure(e.toString()));
    }
  }

  void search(String searchKeyword) {
    final cleanSearchKeyword = searchKeyword.trim();
    _searchSubject.add(cleanSearchKeyword);
  }

  @override
  Future<void> close() async {
    await _searchSubject.close();
    await _searchSubscription.cancel();
    return super.close();
  }

  Future<void> _execSearch(String searchKeyword) async {
    if (searchKeyword.isEmpty) {
      return unawaited(_getAll());
    }
    emit(const AsyncStateLoading());
    try {
      final result = <FoodEntity>[];
      final all = await _foodRepository.getAll();
      if (searchKeyword != _searchSubject.value) return;

      for (final food in all) {
        if (food.name.toLowerCase().contains(searchKeyword.toLowerCase())) {
          result.add(food);
        }
      }
      emit(AsyncStateData(result));
    } catch (e) {
      emit(AsyncStateFailure(e.toString()));
    }
  }

  void onClearSearchTapped() {
    _searchSubject.add('');
    unawaited(_getAll());
  }
}
